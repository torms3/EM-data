function [ret] = import_multivolume( fname, volType )

	if ~exist('volType','var')
		volType = 'image';
	end
	
	% % volume size
	% fsz = fopen([fname '.size'],'r');
	% assert(fsz>=0);
	% x = fread(fsz,1,'uint32');
	% y = fread(fsz,1,'uint32');
	% z = fread(fsz,1,'uint32');
	% dim = [x y z];	
	% vol = prod(dim);
	% disp(['dim = [' num2str(x) ' ' num2str(y) ' ' num2str(z) ']']);

	% % load volume files
	% fimg(1) = fopen([fname '.0'], 'r');
	% fimg(2) = fopen([fname '.1'], 'r');
	% fimg(3) = fopen([fname '.2'], 'r');
	% fimg(4) = fopen([fname '.3'], 'r');

	% for i = 1:numel(fimg)

	% 	if( fimg(i) < 0 )
	% 		continue;
	% 	end
	% 	disp(['volume ' num2str(i) '...']);

	% 	switch( volType )
	% 	case 'mask'
	% 		ret{i} = false(vol,1);
	% 		ret{i} = fread(fimg(i),vol,'uint8');
	% 		ret{i} = logical(reshape(ret{i},dim));
	% 	otherwise
	% 		ret{i} = zeros(vol,1);
	% 		ret{i} = fread(fimg(i),vol,'double');
	% 		ret{i} = reshape(ret{i},dim);
	% 	end

	% end


	% global volume size
	fsz = fopen([fname '.size'],'r');
	if fsz ~= -1
		x = fread(fsz,1,'uint32');
		y = fread(fsz,1,'uint32');
		z = fread(fsz,1,'uint32');
		dim = [x y z];	
		gvol = prod(dim);
		disp(['dim = [' num2str(x) ' ' num2str(y) ' ' num2str(z) ']']);
	end

	i = 0;
	fimg = fopen([fname '.' num2str(i)], 'r');
	while fimg ~= -1

		disp(['volume ' num2str(i) '...']);

		if ~exist('gvol','var')
			fsz = fopen([fname '.' num2str(i) '.size'],'r');
			x = fread(fsz,1,'uint32');
			y = fread(fsz,1,'uint32');
			z = fread(fsz,1,'uint32');
			dim = [x y z];	
			vol = prod(dim);
			fclose(fsz);
		else
			vol = gvol;
		end

		switch( volType )
		case 'mask'
			ret{i+1} = false(vol,1);
			ret{i+1} = fread(fimg,vol,'uint8');
			ret{i+1} = logical(reshape(ret{i+1},dim));
		otherwise
			ret{i+1} = zeros(vol,1);
			ret{i+1} = fread(fimg,vol,'double');
			ret{i+1} = reshape(ret{i+1},dim);
		end

		i = i + 1;
		fimg = fopen([fname '.' num2str(i)], 'r');

	end

end