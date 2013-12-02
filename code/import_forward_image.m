function [img] = import_forward_image( fname )

	fimg(1) = fopen([fname '.0'], 'r');
	fimg(2) = fopen([fname '.1'], 'r');
	fimg(3) = fopen([fname '.2'], 'r');

	fsz = fopen([fname '.size'],'r');
	x = fread(fsz,1,'uint32');
	y = fread(fsz,1,'uint32');
	z = fread(fsz,1,'uint32');

	for i = 1:numel(fimg)

		if( fimg(i) < 0 )
			continue;
		end

		img{i} = zeros(x*y*z,1);
		img{i} = fread(fimg(i),prod(size(img{i})),'double');
		img{i} = reshape(img{i},[x y z]);

	end

end