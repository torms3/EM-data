function [ret] = import_multivolume_3D_series( fname, n, volType )

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
	disp(['dim = [' num2str(x) ' ' num2str(y) ' ' num2str(z) ']']);

	% load volume files
	fimg(1) = fopen([fname '.0'], 'r');
	fimg(2) = fopen([fname '.1'], 'r');
	fimg(3) = fopen([fname '.2'], 'r');
	fimg(4) = fopen([fname '.3'], 'r');

	% for i = 1:numel(fimg)
	for i = 1:1

		if( fimg(i) < 0 )
			continue;
		end
		disp(['volume ' num2str(i) '...']);
		ret{i} = [];

		for j = 1:numel(n)

			switch( volType )
			case 'mask'
				cur = false(vol,1);
				cur = fread(fimg(i),vol,'uint8');
				cur = logical(reshape(cur,dim));
			otherwise
				cur = zeros(vol,1);
				cur = fread(fimg(i),vol,'double');
				cur = reshape(cur,dim);
			end

			ret{i} = cat(3,ret{i},cur);

		end

	end

end