function [chann] = generate_channel( fname, data, offset, sz )

	chann = crop_volume(data,offset,sz);
	chann = scaledata(single(chann),0,1);
	
	chann_fname = [fname '.chann.h5']; 
	disp(chann_fname);	
	hdf5write(chann_fname,'/main',chann);

end