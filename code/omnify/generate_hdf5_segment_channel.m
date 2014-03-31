function [] = generate_hdf5_segment_channel( fname, segm, chann )

	%% Argument validations
	%
	assert(exist('fname','var')~=0);
	assert(exist('segm','var')~=0);
	if ~exist('chann','var')
		chann = [];
	end

	
	% segmentation
	segm_fname = [fname '.segm.h5']; disp(segm_fname);
	hdf5write(segm_fname,'/main',segm);

	% channel, if exists
	if ~isempty(chann)
		chann_fname = [fname '.chann.h5']; disp(chann_fname);
		hdf5write(chann_fname,'/main',chann);
	end

end