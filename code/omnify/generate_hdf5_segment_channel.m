function [] = generate_hdf5_segment_channel( segm, chann, fname )

	%% Argument validations
	%
	if( ~exist('fname','var') )
		fname = 'temp';
	end

	
	% segmentation
	segm_fname = [fname '.segm.h5']; disp(segm_fname);
	hdf5write(segm_fname,'/main',segm);

	% channel
	chann_fname = [fname '.chann.h5']; disp(chann_fname);
	hdf5write(chann_fname,'/main',chann);

end