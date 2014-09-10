function [] = process_affinity_output( fname, outname )

	if ~exist('outname','var')
		outname = fname;
	end

	for i = 1:numel(fname)

		[out] = import_multivolume( fname{i} );		
		write_tif_image_stack( scaledata(out{1},0,1), [outname{i} '.affin.x.tif'] );
		write_tif_image_stack( scaledata(out{2},0,1), [outname{i} '.affin.y.tif'] );
		write_tif_image_stack( scaledata(out{3},0,1), [outname{i} '.affin.z.tif'] );

	end

end