function [ret] = import_volume( fname, volType )

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

	switch( volType )
	case {'image','label'}
		fvol = fopen([fname '.' volType],'r');
		ret = zeros(vol,1);
		ret = fread(fvol,vol,'double');
		ret = reshape(ret,dim);
	case 'mask'
		fvol = fopen([fname '.' volType],'r');
		ret = uint8(zeros(vol,1));
		ret = fread(fvol,vol,'uint8');
		ret = reshape(ret,dim);
	otherwise
		fvol = fopen([fname '.' volType],'r');
		ret = zeros(vol,1);
		ret = fread(fvol,vol,'double');
		ret = reshape(ret,dim);		
	end

end