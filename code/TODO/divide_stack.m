function [stacks] = divide_stack( mold, img, lbl, msk )

	%% Argument validations
	%
	if( ~exist('msk','var') )
		msk = true(size(img));
	end


	%% Preparation
	%
	% data
	assert(isequal(size(img),size(lbl)));
	[x,y,z] = size(img);

	% mold
	assert(numel(size(mold)) == 2);	
	dim = mold;
	subx = floor(x/dim(1));
	suby = floor(y/dim(2));

	
	%% Divide the given image stack into multiple substacks
	%
	nStacks = dim(1)*dim(2);
	stacks = cell(nStacks,1);
	for i = 1:dim(1)
		for j = 1:dim(2)

			linIdx = dim(1)*(i-1) + j;
			
			if( i == dim(1) )
				indx = 1+subx*(i-1):x;
			else
				indx = 1+subx*(i-1):subx*i;
			end
			if( j == dim(2) )
				indy = 1+suby*(j-1):y;
			else
				indy = 1+suby*(j-1):suby*j;
			end

			stacks{linIdx}.img = img(indx,indy,:);
			stacks{linIdx}.lbl = lbl(indx,indy,:);
			stacks{linIdx}.msk = msk(indx,indy,:);

		end
	end

end