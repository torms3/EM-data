function omnify_test_batch( fdir, fname, segIdx )

	% segmentation & channel
	fpath = [fdir fname];
	% [kisuklee: TODO] imStack
	[segm,chann] = extract_segment_channel( fpath, segIdx );

	% HDF5
	mkdir(fdir,'omni');
	omniPath = [fdir 'omni'];
	
	hdf5path = [omniPath '/' fname '.test_batch' num2str(segIdx)];	
	omnify( segm, chann, hdf5path );
	% create_hdf5_for_omnification( hdf5path, segm, chann );

	% omni script
	% omni_exec = '/Users/balkamm/omni/omni.desktop';
	% sysline = [omni_exec ' --headless' ];

end