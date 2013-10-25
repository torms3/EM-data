function [] = export_whole_training_data_ver2( fname, data )
	
	% size
	fsz = fopen([fname '.size'], 'w');
	imgsz = size(data.image);
	fwrite(fsz, uint32(imgsz), 'uint32');	

	% image
	% fimg = fopen([fname '.image'], 'w');
	% fwrite(fimg, double(data.image), 'double');

	% % label
	% flbl = fopen([fname '.label'], 'w');
	% fwrite(flbl, double(data.label), 'double');

	% mask
	% fmsk = fopen([fname '.mask'], 'w');
	% fwrite(fmsk, uint8(data.mask), 'uint8');

end