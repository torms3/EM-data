function [] = export_volume_data( fname, data )
	
	%% Argument validation
	% assert(is_valid_volume_dataset(data));

	%% Export	
	% size
	fsz = fopen([fname '.size'], 'w');
	imgsz = size(data.image);
	if ndims(imgsz) < 3
		imgsz = [imgsz 1];
	end
	fwrite(fsz, uint32(imgsz), 'uint32');	

	% image
	fimg = fopen([fname '.image'], 'w');
	fwrite(fimg, double(data.image), 'double');

	% label
	if( isfield(data,'label') )
		flbl = fopen([fname '.label'], 'w');
		fwrite(flbl, double(data.label), 'double');
	end

	% mask
	if( isfield(data,'mask') )
		fmsk = fopen([fname '.mask'], 'w');
		fwrite(fmsk, uint8(data.mask), 'uint8');
	end

	% auxiliary data (e.g., boundary probability map)
	if( isfield(data,'aux') )
		faux = fopen([fname '.aux'], 'w');
		fwrite(faux, double(data.aux), 'double');
	end

end