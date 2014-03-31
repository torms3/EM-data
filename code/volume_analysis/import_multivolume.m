function [ret] = import_multivolume( fname, volType )

	if( ~exist('volType','var') )
		volType = 'image';
	end
	
	% volume size
	fsz = fopen([fname '.size'],'r');
	assert(fsz>=0);
	x = fread(fsz,1,'uint32');
	y = fread(fsz,1,'uint32');
	z = fread(fsz,1,'uint32');
	dim = [x y z];
	vol = prod(dim);

	% load volume files
	fimg(1) = fopen([fname '.0'], 'r');
	fimg(2) = fopen([fname '.1'], 'r');
	fimg(3) = fopen([fname '.2'], 'r');
	fimg(4) = fopen([fname '.3'], 'r');

	for i = 1:numel(fimg)

		if( fimg(i) < 0 )
			continue;
		end

		switch( volType )
		case 'mask'
			ret{i} = false(vol,1);
			ret{i} = fread(fimg(i),vol,'uint8');
			ret{i} = logical(reshape(ret{i},dim));
		otherwise
			ret{i} = zeros(vol,1);
			ret{i} = fread(fimg(i),vol,'double');
			ret{i} = reshape(ret{i},dim);
		end

	end

end