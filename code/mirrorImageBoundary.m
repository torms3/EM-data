function [img] = mirrorImageBoundary( img, w )

	assert(numel(size(img)) == 3);	% 3D image stack
	w = floor(w/2);

	%% x-axis
	%
	dim = 2;
	A = flipdim(img(:,2:1+w,:),dim);
	B = flipdim(img(:,end-w:end-1,:),dim);
	img = cat(dim,A,img,B);


	%% y-axis
	%
	dim = 1;
	A = flipdim(img(2:1+w,:,:),dim);
	B = flipdim(img(end-w:end-1,:,:),dim);
	img = cat(dim,A,img,B);


	%% z-axis
	%
	dim = 3;
	A = flipdim(img(:,:,2:1+w),dim);
	B = flipdim(img(:,:,end-w:end-1),dim);
	img = cat(dim,A,img,B);

end