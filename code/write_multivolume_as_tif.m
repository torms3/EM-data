function [] = write_multivolume_as_tif( fname, mulvol, scale )

	assert(iscell(mulvol));

	if ~exist('scale','var')
		scale = [];
	end

	for i = 1:numel(mulvol)
		disp(['Writing volume ' num2str(i) '...']);

		if ~isempty(scale)
			stack = scaledata(mulvol{i},scale(1),scale(2));
		else
			stack = mulvol{i};
		end

		write_tif_image_stack( stack, [fname num2str(i) '.tif'] );
	end

end