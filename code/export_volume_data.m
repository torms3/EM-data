function [] = export_volume_data( fname, data )
	
	assert(isfield(data,'image'));
	assert(isfield(data,'label'));

	% size
	fsz = fopen([fname '.size'], 'w');
	imgsz = size(data.image);
	fwrite(fsz, uint32(imgsz), 'uint32');	

	% image
	fimg = fopen([fname '.image'], 'w');
	fwrite(fimg, double(data.image), 'double');

	% % label
	flbl = fopen([fname '.label'], 'w');
	fwrite(flbl, double(data.label), 'double');

	% mask
	if( isfield(data,'mask') )
		fmsk = fopen([fname '.mask'], 'w');
		fwrite(fmsk, uint8(data.mask), 'uint8');
	end

end