function [] = export_whole_training_data( fname, data )

	fsz  = fopen([fname '.size'], 'w');
	fimg = fopen([fname '.image'], 'w');
	flbl = fopen([fname '.label'], 'w');
	% fmsk = fopen([fname '.mask'], 'w');
	
	% size
	imgsz = size(data.image);
	fwrite(fsz, uint32(imgsz), 'uint32');
	
	% image
	fwrite(fimg, double(data.image), 'double');

	% label
	fwrite(flbl, double(data.label), 'double');

	% mask
	% fwrite(fmsk, uint8(data.mask), 'uint8');

end