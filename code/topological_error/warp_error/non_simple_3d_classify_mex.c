#include <math.h>
#include "mex.h"
#include "matrix.h"

static int offset6[6][3]={{1,0,0},{-1,0,0},{0,1,0},{0,-1,0},{0,0,1},{0,0,-1}};

static int offset26[26][3]={{1,0,0},{-1,0,0},{0,1,0},{0,-1,0},{0,0,1},{0,0,-1},{1,1,0},{0,1,1},{1,0,1},{1,-1,0},{-1,1,0},{0,1,-1},{0,-1,1},{1,0,-1},{-1,0,1},{-1,-1,0},{-1,0,-1},{0,-1,-1},{1,1,1},{1,1,-1},{1,-1,1},{-1,1,1},{-1,1,-1},{-1,-1,1},{1,-1,-1},{-1,-1,-1}};

void construct_patch(unsigned int *source, unsigned int *patch, int i, int xsize, int ysize, int zsize)
{
	int x, y, z;
	for(x=0;x<3;x++)
	{
		for(y=0;y<3;y++)
		{
			for(z=0;z<3;z++)
			{
				patch[x + y*3 + z*3*3] = source[ i + (x-1) + (y-1)*(xsize) + (z-1)*(xsize)*(ysize)];
			}
		}
	}
}

bool neighbor_exists(unsigned int *patch, bool foreground, unsigned int fg_conn)
{
	int i;
	if(fg_conn==6 && foreground)
	{
		for(i=0;i<6;i++)
		{
			if(patch[1+offset6[i][0] + (1+offset6[i][1])*3 + (1+offset6[i][2])*3*3]!=0)
				return true;
		}
	}
	else if(fg_conn==6 && !foreground)
	{
		for(i=0;i<26;i++)
		{
			if(patch[1+offset26[i][0] + (1+offset26[i][1])*3 + (1+offset26[i][2])*3*3]==0)
				return true;
		}
	}
	else if(fg_conn==26 && foreground)
	{
		for(i=0;i<26;i++)
		{
			if(patch[1+offset26[i][0] + (1+offset26[i][1])*3 + (1+offset26[i][2])*3*3]!=0)
				return true;
		}
	}
	else
	{
		for(i=0;i<6;i++)
		{
			if(patch[1+offset6[i][0] + (1+offset6[i][1])*3 + (1+offset6[i][2])*3*3]==0)
				return true;
		}
	}
	return false;
}

bool multiple_neighbors(unsigned int *patch, bool foreground, unsigned int fg_conn)
{
	int i;
	unsigned int nbor=0;
	if(fg_conn==6 && foreground)
	{
		for(i=0;i<6;i++)
		{
			if(patch[(1+offset6[i][0]) + (1+offset6[i][1])*3 + (1+offset6[i][2])*3*3]!=0)
			{
				if(nbor!=0 && nbor!=patch[1+offset6[i][0] + (1+offset6[i][1])*3 + (1+offset6[i][2])*3*3])
				{
					return true;
				}
				else if(nbor==0)
				{
					nbor = patch[1+offset6[i][0] + (1+offset6[i][1])*3 + (1+offset6[i][2])*3*3];
				}
			}
		}
	}
	else if(fg_conn==6 && !foreground)
	{
		for(i=0;i<26;i++)
		{
			if(patch[1+offset26[i][0] + (1+offset26[i][1])*3 + (1+offset26[i][2])*3*3]==0)
			{
				if(nbor!=0 && nbor!=patch[1+offset26[i][0] + (1+offset26[i][1])*3 + (1+offset26[i][2])*3*3])
				{
					return true;
				}
				else if(nbor==0)
				{
					nbor = patch[1+offset26[i][0] + (1+offset26[i][1])*3 + (1+offset26[i][2])*3*3];
				}
			}
		}
	}
	else if(fg_conn==26 && foreground)
	{
		for(i=0;i<26;i++)
		{
			if(patch[(1+offset26[i][0]) + (1+offset26[i][1])*3 + (1+offset26[i][2])*3*3]!=0)
			{
				if(nbor!=0 && nbor!=patch[1+offset26[i][0] + (1+offset26[i][1])*3 + (1+offset26[i][2])*3*3])
				{
					return true;
				}
				else if(nbor==0)
				{
					nbor = patch[1+offset26[i][0] + (1+offset26[i][1])*3 + (1+offset26[i][2])*3*3];
				}
			}
		}
	}
	else
	{
		for(i=0;i<6;i++)
		{
			if(patch[1+offset6[i][0] + (1+offset6[i][1])*3 + (1+offset6[i][2])*3*3]==0)
			{
				if(nbor!=0 && nbor!=patch[1+offset6[i][0] + (1+offset6[i][1])*3 + (1+offset6[i][2])*3*3])
				{
					return true;
				}
				else if(nbor==0)
				{
					nbor = patch[1+offset6[i][0] + (1+offset6[i][1])*3 + (1+offset6[i][2])*3*3];
				}
			}
		}
	}
	return false;
}

unsigned int count_unique(unsigned int *comps, int imsize, int max_ct)
{
	int i, j;
	bool found_eq;
	unsigned int found_ct=0;
	unsigned int *found=mxCalloc(max_ct,sizeof(unsigned int));
	for(i=0;i<imsize;i++)
	{
		if(comps[i]!=0)
		{
			found_eq=false;
			for(j=0;j<found_ct;j++)
			{
				if(found[j] == comps[i])
				{
					found_eq=true;
					break;
				}
			}
			if(!found_eq)
			{
				found[found_ct]=comps[i];
				found_ct++;
				if(found_ct==max_ct)
				{
					return max_ct+1;
				}
			}
		}
	}
	mxFree(found);
	return found_ct;
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	int i, j, x, y, z, xc, yc, zc, x_begin, x_end, y_begin, y_end, z_begin, z_end, xsize, ysize, zsize, linind, linind_pad, imsize, imsize_pad;
	int radius, fg_conn;
	bool *points_to_classify, *orig_points_to_classify;
	unsigned int *orig_segmented_source, *segmented_source, *classify_im, *classify_im_out, *patch;
	bool *source_alt;
	double *comps;
	double numcomps, numcompsalt;
	int num_comps, num_comps_alt;
	
	imsize = (int)mxGetNumberOfElements(prhs[0]);
	xsize = (int)mxGetDimensions(prhs[0])[0];
	ysize = (int)mxGetDimensions(prhs[0])[1];
	zsize = (int)mxGetDimensions(prhs[0])[2];
	imsize_pad = (int)(xsize+2)*(ysize+2)*(zsize+2);
	
	if(nrhs!=2 && nrhs!=3 && nrhs!=4)
		mexErrMsgTxt("non_simple_3d_classify_mex(segmented_source, points_to_classify[, radius=Inf, fg_conn=6])");
	if(nrhs==3 && (!mxIsScalar(prhs[2]) || !mxIsUint32(prhs[2])))
		mexErrMsgTxt("radius must be a scalar of type \'UINT32\'");
	if(nrhs==4 && (!mxIsScalar(prhs[3]) || !mxIsUint32(prhs[3])))
		mexErrMsgTxt("fg_conn must be a scalar of type \'UINT32\'");
	if(!mxIsLogical(prhs[1]))
		mexErrMsgTxt("points_to_classify must be of type \'LOGICAL\'");
	if(!mxIsUint32(prhs[0]))
		mexErrMsgTxt("segmented_source must be of type \'UINT32\'");
	
	radius = (int)((nrhs==2)?0:mxGetScalar(prhs[2]));
	fg_conn = (int)((nrhs==3)?6:mxGetScalar(prhs[3]));
	if(fg_conn!=6 && fg_conn!=26)
	{
		mexErrMsgTxt("fg_conn must be 6 or 26");
	}
	
	orig_segmented_source = (unsigned int *)mxGetData(prhs[0]);
	orig_points_to_classify = (bool *)mxGetData(prhs[1]);
	
	segmented_source = (unsigned int *)mxCalloc(imsize_pad,sizeof(unsigned int));
	points_to_classify = (bool *)mxCalloc(imsize_pad,sizeof(bool));
	classify_im = (unsigned int *)mxCalloc(imsize_pad,sizeof(unsigned int));
	
	for(x=0;x<xsize;x++)
	{
		for(y=0;y<ysize;y++)
		{
			for(z=0;z<zsize;z++)
			{
				linind_pad = (x+1) + (y+1)*(xsize+2) + (z+1)*(xsize+2)*(ysize+2);
				linind = x + y*xsize + z*xsize*ysize;
				segmented_source[linind_pad] = orig_segmented_source[linind];
				points_to_classify[linind_pad] = orig_points_to_classify[linind];
			}
		}
	}
	
	mwSize dims[3];
	
	if(radius==0)
	{
		dims[0]=xsize+2;
		dims[1]=ysize+2;
		dims[2]=zsize+2;
	}
	else
	{
		dims[0]=(2*radius+1);
		dims[1]=(2*radius+1);
		dims[2]=(2*radius+1);
	}
	
	patch = (unsigned int *)mxCalloc(27,sizeof(unsigned int));
	
	mxArray *plhs1[2], *prhs1[2];
	prhs1[0] = mxCreateNumericArray((mwSize)3,dims,mxLOGICAL_CLASS,mxREAL);
	source_alt = (bool *)mxGetData(prhs1[0]);
	
	prhs1[1] = mxCreateDoubleMatrix(1,1,mxREAL);
	double *param_conn = (double *)mxGetPr(prhs1[1]);
	param_conn[0] = (double)fg_conn;
	
	for(i=0;i<imsize_pad;i++)
	{
		if(points_to_classify[i])
		{
			construct_patch(segmented_source,patch,i,xsize+2,ysize+2,zsize+2);
			if(segmented_source[i]==0)
			{
				if(!neighbor_exists(patch,true,fg_conn))
				{
					classify_im[i] = 1; /* flipping would create an object */
				}
				else if(!neighbor_exists(patch,false,fg_conn))
				{
					classify_im[i] = 2; /* flipping would delete a hole */
				}
				else
				{
					if(multiple_neighbors(patch,true,fg_conn))
					{
						classify_im[i] = 3; /* flipping would cause a merger */
					}
					else
					{
						classify_im[i] = 4; /* flipping would create a hole */
					}
				}
			}
			else
			{
				if(!neighbor_exists(patch,true,fg_conn))
				{
					classify_im[i] = 5; /* flipping would delete an object */
				}
				else if(!neighbor_exists(patch,false,fg_conn))
				{
					classify_im[i] = 6; /* flipping would create a hole */
				}
				else
				{
					if(radius==0) 
					{
						for(j=0;j<imsize_pad;j++)
						{
							source_alt[j] = (bool)(segmented_source[j]==segmented_source[i]);
						}
						source_alt[i]=!source_alt[i];
						mexCallMATLAB(2,plhs1,2,prhs1,"bwlabeln");
						numcompsalt = (double)mxGetScalar(plhs1[1]);
						mxDestroyArray(plhs1[0]);
						mxDestroyArray(plhs1[1]);
						num_comps_alt = (int)numcompsalt;
					}
					else
					{
						xc = i%(xsize+2);
						yc = ((int)(i/(xsize+2)))%(ysize+2);
						zc = (int)(i/((xsize+2)*(ysize+2)));
						
						x_begin = (0>xc-radius) ? (0) : (xc-radius);
						x_end = (xsize+2<xc+radius+1) ? (xsize+2) : (xc+radius+1);
						
						y_begin = (0>yc-radius) ? (0) : (yc-radius);
						y_end = (ysize+2<yc+radius+1) ? (ysize+2) : (yc+radius+1);
						
						z_begin = (0>zc-radius) ? (0) : (zc-radius);
						z_end = (zsize+2<zc+radius+1) ? (zsize+2) : (zc+radius+1);
						
						for(j=0;j<(2*radius+1)*(2*radius+1)*(2*radius+1);j++)
						{
							source_alt[j] = false;
						}
						for(x=0;x<(x_end-x_begin);x++)
						{
							for(y=0;y<(x_end-x_begin);y++)
							{
								for(z=0;z<(z_end-z_begin);z++)
								{
									source_alt[x + y*(2*radius+1) + z*(2*radius+1)*(2*radius+1)] = (bool) (segmented_source[(x_begin+x) + (y_begin+y)*(xsize+2) + (z_begin+z)*(xsize+2)*(ysize+2)] == segmented_source[i]);
								}
							}
						}
						mexCallMATLAB(2,plhs1,2,prhs1,"bwlabeln");
						numcomps = (double)mxGetScalar(plhs1[1]);
						num_comps = (int)numcomps;
						mxDestroyArray(plhs1[0]);
						mxDestroyArray(plhs1[1]);
						xc = (int)(xc-x_begin);
						yc = (int)(yc-y_begin);
						zc = (int)(zc-z_begin);
						source_alt[xc + yc*(2*radius+1) + zc*(2*radius+1)*(2*radius+1)] = !source_alt[xc + yc*(2*radius+1) + zc*(2*radius+1)*(2*radius+1)];
						mexCallMATLAB(2,plhs1,2,prhs1,"bwlabeln");
						numcomps = (double)mxGetScalar(plhs1[1]);
						mxDestroyArray(plhs1[0]);
						mxDestroyArray(plhs1[1]);
						num_comps_alt = (unsigned int)numcomps;
						num_comps_alt = num_comps_alt-num_comps+1;
					}
					if(num_comps_alt>1)
					{
						classify_im[i] = 7; /* flipping would cause a split */
					}
					else if(num_comps_alt==0)
					{
						mexPrintf("shouldnt happen\n");
					}
					else
					{
						classify_im[i] = 8; /* flipping would delete a hole */
					}
				}
			}
		}
	}
	mxDestroyArray(prhs1[0]);
	mxDestroyArray(prhs1[1]);
	
	plhs[0] = mxCreateNumericArray(mxGetNumberOfDimensions(prhs[0]),mxGetDimensions(prhs[0]),mxUINT32_CLASS,mxREAL);
	classify_im_out = (unsigned int *)mxGetData(plhs[0]);
	for(x=0;x<xsize;x++)
	{
		for(y=0;y<ysize;y++)
		{
			for(z=0;z<zsize;z++)
			{
				classify_im_out[x + y*xsize + z*xsize*ysize] = classify_im[(x+1) + (y+1)*(xsize+2) + (z+1)*(xsize+2)*(ysize+2)];
			}
		}
	}
	mxFree(segmented_source);
	mxFree(points_to_classify);
	mxFree(classify_im);
	mxFree(patch);
	return;
}
