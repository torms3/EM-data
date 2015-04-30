function [ret] = CLAHE( stack, dist, block )

	if ~exist('dist','var')
		dist = 'uniform';
	end

	if ~exist('block','var')
		block = 64;
	end

	[x,y,~] = size(stack);
	M = floor(x/block);
	N = floor(y/block);

	assert(ndims(stack) == 3);
	parfor z = 1:size(stack,3)
		disp(['Processing slice at z = ' num2str(z) '...']);
		img = stack(:,:,z);
		img = scaledata(img,0,1);
		ret(:,:,z) = adapthisteq(img,'NumTiles',[M N],'ClipLimit',0.01, ...
										'Distribution',dist);
	end

end