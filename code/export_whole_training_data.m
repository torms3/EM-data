function [] = export_whole_training_data( fname, data )

	fsz  = fopen([fname '.size'], 'w');
	fimg = fopen([fname '.image'], 'w');
	fmsk = fopen([fname '.mask' ], 'w');
	
	% size
	sz = size(data.image);
	fwrite(fsz, uint32(sz), 'uint32');
	nout = numel(data.label);
	outputsz = [1 1 1 nout];
	fwrite(fsz, uint32(outputsz), 'uint32');
	
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