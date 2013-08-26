function [] = export_whole_training_data( fname, data )

	fsz  = fopen([fname '.size'], 'w');
	fimg = fopen([fname '.image'], 'w');
	fmsk = fopen([fname '.mask' ], 'w');
	
	% size: image & mask
	imgsz = size(data.image);
	fwrite(fsz, uint32(imgsz), 'uint32');
	
	% size: labels
	lblsz = size(data.label{1});
	fwrite(fsz, uint32(lblsz), 'uint32');
	nout = numel(data.label);
	fwrite(fsz, uint32(nout), 'uint32');
	
	% image
	fwrite(fimg, data.image, 'double');

	% mask
	fwrite(fmsk, uint8(data.mask), 'uint8');

	% label
	
	for i = 1:nout
		
		flbl = fopen([fname '.label.' num2str(i)], 'w');
		fwrite(flbl, double(data.label{i}), 'double');

	end

end