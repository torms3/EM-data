function [] = test_export_volume( fname, vol )

	fvol = fopen(fname, 'w');
	
	% whole label volume size
	volsz = size(vol);
	% fwrite(fvol, uint32(volsz), 'uint32');
	
	% whole label volume
	fwrite(fvol, uint8(vol), 'uint8');

end