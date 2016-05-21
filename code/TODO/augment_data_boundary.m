function [data] = augment_data_boundary( data, w )
% [02/06/2014 kisuklee]
% currently only 2D boundary augmentation is supported.

	%% Argument validation
	%
	assert(is_valid_volume_dataset( data ));
	assert(1 == exist('w','var'));


	%% Augment data boundary
	%
	% image
	data.image = mirrorImageBoundary( data.image, w );

	% label
	padSz = floor(w/2);
	data.label = padarray( data.label, [padSz padSz 0], 0 );

	% aux
	if isfield(data,'aux')
		data.aux = mirrorImageBoundary( data.aux, w );		
	end

	% mask
	if isfield(data,'mask')
		data.mask = padarray( data.mask, [padSz padSz 0], false );
	end


end