function [imageStack] = read_tif_image_stack( fileName )

	%% Read metadata
	%
	imageInfo = imfinfo(fileName);
	nImages = numel(imageInfo);			% # images
	assert( nImages > 0 );
	
	w = imageInfo(1).Width;				% image width
	h = imageInfo(1).Height;			% image height
	
	imageStack = zeros(w,h,nImages);
	for i = 1:nImages

		imageStack(:,:,i) = imread(fileName,i);

	end	

end