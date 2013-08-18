function omnify( segm, chann, fname )

	%% Argument validations
	%
	[x,y,z,n] = size(segm);
	assert( n == 3 );
	assert( isequal(size(chann),[x y z]) );


	%% HDF5
	%	
	create_hdf5_for_omnification( fname, segm, chann );

end