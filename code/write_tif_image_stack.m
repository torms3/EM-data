function [] = write_tif_image_stack( imgStack, fileName )
	
	[X,Y,Z] = size(imgStack);

	for z = 1:Z
		imwrite(imgStack(:,:,z), fileName, ...
			'WriteMode', 'append', 'Compression', 'none');
	end

end