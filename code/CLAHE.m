function [ret] = CLAHE( stack, block )

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
		ret(:,:,z) = adapthisteq(img,'NumTiles',[M N],'ClipLimit',0.01);
	end

end