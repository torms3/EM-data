function [] = process_affinity_output( fname, outname )
	
	% filtrad = 5;
	filtrad = 0;

	if ~exist('outname','var')
		outname = fname;
	end

	for i = 1:numel(fname)

		[out] = import_multivolume( fname{i} );

		write_tif_image_stack( out{1}, [outname{i} '.affin.x.tif'] );
		write_tif_image_stack( out{2}, [outname{i} '.affin.y.tif'] );
		write_tif_image_stack( out{3}, [outname{i} '.affin.z.tif'] );

		% median filtering
		if( filtrad > 0 )
			[filtered{1}] = medfilt3( out{1}, filtrad );
			[filtered{2}] = medfilt3( out{2}, filtrad );
			[filtered{3}] = medfilt3( out{3}, filtrad );

			write_tif_image_stack( filtered{1}, [outname{i} '.med' num2str(filtrad) '.affin.x.tif'] );
			write_tif_image_stack( filtered{2}, [outname{i} '.med' num2str(filtrad) '.affin.y.tif'] );
			write_tif_image_stack( filtered{3}, [outname{i} '.med' num2str(filtrad) '.affin.z.tif'] );
		end

	end

end