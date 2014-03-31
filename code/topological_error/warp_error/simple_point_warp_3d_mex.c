#include <math.h>
#include "mex.h"
#include "matrix.h"
#include "simple3d_b_l.h"

static int offset6[6][3]={{1,0,0},{-1,0,0},{0,1,0},{0,-1,0},{0,0,1},{0,0,-1}};

static int offset26[26][3]={{1,0,0},{-1,0,0},{0,1,0},{0,-1,0},{0,0,1},{0,0,-1},{1,1,0},{0,1,1},{1,0,1},{1,-1,0},{-1,1,0},{0,1,-1},{0,-1,1},{1,0,-1},{-1,0,1},{-1,-1,0},{-1,0,-1},{0,-1,-1},{1,1,1},{1,1,-1},{1,-1,1},{-1,1,1},{-1,1,-1},{-1,-1,1},{1,-1,-1},{-1,-1,-1}};

struct imorder
{
	unsigned int coord;
	float val;
};

int queue_comp(const void *queue1_, const void *queue2_)
{
	const struct imorder *queue1 = queue1_;
	const struct imorder *queue2 = queue2_;
	
	if(queue1->val > queue2->val)
	{
		return -1;
	}
	else if(queue1->val < queue2->val)
	{
		return 1;
	}
	return 0;
}

void construct_patch(unsigned int *source, bool *patch, int i, int xsize, int ysize, int zsize)
{
	int x, y, z;
	for(x=0;x<3;x++)
	{
		for(y=0;y<3;y++)
		{
			for(z=0;z<3;z++)
			{
				patch[x + y*3 + z*3*3] = (bool)(source[ i + (x-1) + (y-1)*(xsize) + (z-1)*(xsize)*(ysize)]!=0);
			}
		}
	}
}

unsigned int unique_neighbor(unsigned int *source, int i, int xsize, int ysize, int zsize, unsigned int fg_conn)
{
	int it, j;
	unsigned int neighbor = 0;
	if(fg_conn==6)
	{
		for(j=0;j<6;j++)
		{
			it = i + offset6[j][0] + offset6[j][1]*xsize + offset6[j][2]*xsize*ysize;
			if(source[it]!=0)
			{
				if(neighbor!=0 && neighbor!=(unsigned int)source[it])
				{
					mxErrMsgTxt("Error with colorization");
				}
				neighbor=(unsigned int)source[it];
			}
		}
	}
	else
	{
		for(j=0;j<26;j++)
		{
			it = i + offset26[j][0] + offset26[j][1]*xsize + offset26[j][2]*xsize*ysize;
			if(source[it]!=0)
			{
				if(neighbor!=0 && neighbor!=(unsigned int)source[it])
				{
					mxErrMsgTxt("Error with colorization");
				}
				neighbor=(unsigned int)source[it];
			}
		}
	}
	if(neighbor==0)
	{
		mexErrMsgTxt("No neighbors found. Something went awry!");
	}
	return neighbor;
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	int i, j, k, it, x, y, z, linind, linind_pad, imsize, xsize, ysize, zsize, imsize_pad, erroro, errorn, delregct, delregbct;
	float binary_threshold;
	unsigned int fg_conn, bg_conn;
	bool *mask, *target, *orig_mask, *missclass_points_image, *patch, *queued;
	unsigned int *sourceout, *orig_source, *source;
	float *orig_target, *target_real;
	struct imorder *delreg, *delregb;
	
	imsize = (int)mxGetNumberOfElements(prhs[0]);
	xsize = (int)mxGetDimensions(prhs[0])[0];
	ysize = (int)mxGetDimensions(prhs[0])[1];
	zsize = (int)mxGetDimensions(prhs[0])[2];
	imsize_pad = (int)(xsize+2)*(ysize+2)*(zsize+2);
	
	if(nrhs!=3 && nrhs!=4 && nrhs!=5)
		mexErrMsgTxt("simple_point_warp_3d_mex(source, target, mask[, binary threshold=0.5, fg_conn=6])");
	if(nrhs==4 && (!mxIsScalar(prhs[3]) || !mxIsSingle(prhs[3])))
		mexErrMsgTxt("binary threshold must be a scalar of type \'SINGLE\'");
	if(nrhs==5 && (!mxIsScalar(prhs[4]) || !mxIsUint32(prhs[4])))
		mexErrMsgTxt("fg_conn must be a scalar of type \'UINT32\'");
	if(!mxIsLogical(prhs[2]))
		mexErrMsgTxt("mask must be of type \'LOGICAL\'");
	if(!mxIsSingle(prhs[1]))
		mexErrMsgTxt("target must be of type \'SINGLE\'");
	if(!mxIsUint32(prhs[0]))
		mexErrMsgTxt("source must be of type \'UINT32\'");
	
	binary_threshold = (float)((nrhs==3)?0.5:mxGetScalar(prhs[3]));
	fg_conn = (unsigned int)((nrhs==4)?6:mxGetScalar(prhs[4]));
	if(fg_conn!=6 && fg_conn!=26)
	{
		mexErrMsgTxt("fg_conn must be 6 or 26");
	}
	
	if(fg_conn==6)
	{
		bg_conn=26;
	}
	else
	{
		bg_conn=6;
	}
	
	orig_source = (unsigned int *)mxGetData(prhs[0]);
	orig_target = (float *)mxGetData(prhs[1]);
	orig_mask = (bool *)mxGetData(prhs[2]);
		
	source = (unsigned int *)mxCalloc(imsize_pad,sizeof(unsigned int));
	target_real = (float *)mxCalloc(imsize_pad,sizeof(float));
	mask = (bool *)mxCalloc(imsize_pad,sizeof(bool));
	target = (bool *)mxCalloc(imsize_pad,sizeof(bool));
	missclass_points_image = (bool *)mxCalloc(imsize_pad,sizeof(bool));
	delreg = (struct imorder *)mxCalloc(imsize_pad,sizeof(struct imorder));
	delregb = (struct imorder *)mxCalloc(imsize_pad,sizeof(struct imorder));
	patch = (bool *)mxCalloc(27,sizeof(bool));
	queued = (bool *)mxCalloc(imsize_pad,sizeof(bool));
	
	for(x=0;x<xsize;x++)
	{
		for(y=0;y<ysize;y++)
		{
			for(z=0;z<zsize;z++)
			{
				linind_pad = (x+1) + (y+1)*(xsize+2) + (z+1)*(xsize+2)*(ysize+2);
				linind = x + y*xsize + z*xsize*ysize;
				source[linind_pad] = (unsigned int)(orig_source[linind]);
				target_real[linind_pad] = (float)(orig_target[linind]);
				mask[linind_pad] = (bool)(orig_mask[linind]);
			}
		}
	}
	
	erroro = -1;
	errorn = 0;
	
	for(i=0;i<imsize_pad;i++)
	{
		target[i] = (bool)(target_real[i]>binary_threshold);
		missclass_points_image[i] = (bool)(mask[i] && ((source[i]!=0)!=target[i]));
		
		delreg[i].coord = i;
		delreg[i].val = (float)fabs(target_real[i]-binary_threshold);
		if(missclass_points_image[i])
		{
			errorn++;
		}
	}
	delregct = imsize_pad;
	mexPrintf("Checking points for simpleness\n");
	
	bool changed=true;
	float difftime;
	while( changed )
	{
		changed=false;
		qsort(delreg,delregct,sizeof(struct imorder),queue_comp);
		for(i=0;i<delregct;i++)
		{
			delregb[i] = delreg[i];
		}
		for(i=0;i<imsize_pad;i++)
		{
			queued[i] = false;
		}
		
		delregbct = delregct;
		delregct = 0;
		
		for(k=0;k<delregbct;k++)
		{
			i = delregb[k].coord;
			if(missclass_points_image[i])
			{
				construct_patch(source,patch,i,xsize+2,ysize+2,zsize+2);
				if(simple3d_b(patch,fg_conn))
				{
					if(source[i]==0)
					{
						source[i] = unique_neighbor(source,i,xsize+2,ysize+2,zsize+2,fg_conn);
					}
					else
					{
						source[i] = 0;
					}
					missclass_points_image[i] = false;
					errorn--;
					changed = true;
					for(j=0;j<26;j++)
					{
						it = i+offset26[j][0]+offset26[j][1]*(xsize+2)+offset26[j][2]*(xsize+2)*(ysize+2);
						if(!queued[it])
						{
							queued[it] = true;
							delreg[delregct].coord = it;
							delreg[delregct].val = (float)fabs(target_real[it]-binary_threshold);;
							delregct++;
						}
					}
				}
			}
		}
		/*mexPrintf("Difference %d\n",errorn);*/
	}
	plhs[0] = mxCreateNumericArray(mxGetNumberOfDimensions(prhs[0]),mxGetDimensions(prhs[0]),mxUINT32_CLASS,mxREAL);
	sourceout = (unsigned int *)mxGetData(plhs[0]);
	/*sourceout = (unsigned int *)mxCalloc(imsize,sizeof(unsigned int));*/
	for(x=0;x<xsize;x++)
	{
		for(y=0;y<ysize;y++)
		{
			for(z=0;z<zsize;z++)
			{
				sourceout[x + y*xsize + z*xsize*ysize] = source[(x+1) + (y+1)*(xsize+2) + (z+1)*(xsize+2)*(ysize+2)];
			}
		}
	}
	/*mxSetData(plhs[0],sourceout);*/
	mexPrintf("Finished\n");
	
	mxFree(source);
	mxFree(target_real);
	mxFree(mask);
	mxFree(target);
	mxFree(missclass_points_image);
	mxFree(patch);
	mxFree(queued);
	mxFree(delreg);
	mxFree(delregb);
	
	return;
}

