function [chann] = generate_channel( fname, data, crop_volume )

	if ~exist('crop_volume','var')
		crop_volume = [];
	end

	if isempty(crop_volume)
		[chann] = data;
	else	
		[chann] = adjust_border_effect( data, crop_volume, true );
	end
	chann = scaledata(single(chann),0,1);
	
	chann_fname = [fname '.chann.h5']; 
	disp(chann_fname);	
	hdf5write(chann_fname,'/main',chann);

end