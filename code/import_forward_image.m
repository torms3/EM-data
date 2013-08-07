function [img] = import_forward_image( fname, segIdx )

	fimg(1) = fopen([fname '.0'], 'r');
	fimg(2) = fopen([fname '.1'], 'r');
	fimg(3) = fopen([fname '.2'], 'r');

	for i = 1:numel(fimg)

		x = fread(fimg(i),1,'double');
		y = fread(fimg(i),1,'double');
		z = fread(fimg(i),1,'double');

		img{i} = zeros(x*y*z,1);
		img{i} = fread(fimg(i),prod(size(img{i})),'double');
		img{i} = reshape(img{i},[x y z]);

	end

end