function [data] = normalize_stack_by_slice( data )

	assert(isfield(data,'image'));
	assert(isfield(data,'label'));
	assert(ndims(data.image) == 3);	% 3D image stack

	Z = size(data.image,3);

	for z = 1:Z

		img = data.image(:,:,z);
		img = (img - mean(img(:)))/std(img(:));
		data.image(:,:,z) = img;

	end

end