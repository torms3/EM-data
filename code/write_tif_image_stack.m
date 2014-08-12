function [ret] = write_tif_image_stack( imgStack, fileName, clrMap )
	
	ret = [];
	[X,Y,Z] = size(imgStack);

	if exist('clrMap','var')
		[imgStack] = index2rgb( imgStack, clrMap );
		options.color = true;
		options.comp = 'no';
		saveastiff( imgStack, fileName, options );
		ret = imgStack;
	else
		for z = 1:Z
			imwrite(imgStack(:,:,z), fileName, ...
				'WriteMode', 'append', 'Compression', 'none');
		end
	end

end


function [ret] = index2rgb( imgStack, clrMap )

	[X,Y,Z] = size(imgStack);

	for i = 1:Z

		disp(['z = ' num2str(i) ' is now being processing...']);

		img = imgStack(:,:,i);

		idx = img(:) + 1;

		R = clrMap(idx,1); R = ceil(R*255); R = reshape(R,[X,Y]); R = uint8(R);
		G = clrMap(idx,2); G = ceil(G*255); G = reshape(G,[X,Y]); G = uint8(G);
		B = clrMap(idx,3); B = ceil(B*255); B = reshape(B,[X,Y]); B = uint8(B);

		ret(:,:,:,i) = cat(3,R,G,B);

	end

end