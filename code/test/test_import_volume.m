function [vol] = test_import_volume( fname )

	fvol = fopen(fname, 'r');
	
	x = fread(fvol,1,'uint32');
	y = fread(fvol,1,'uint32');
	z = fread(fvol,1,'uint32');

	vol = zeros(x*y*z,1);
	vol = fread(fvol,prod(size(vol)),'double');
	vol = reshape(vol,[x y z]);

end