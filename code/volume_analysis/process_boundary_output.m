function [] = process_boundary_output( fname, filtrad, outname )

	if ~exist('filtrad','var')
		filtrad = [];
	end
	if ~exist('outname','var')
		outname = fname;
	end

	for i = 1:numel(fname)
		
		[fwdimg] = import_multivolume( fname{i} );
		
		outidx = 2;
		[prob,mprob] = generate_prob_map( fwdimg, outidx, filtrad );

		write_tif_image_stack( prob, [outname{i} '.prob.tif'] );
		write_tif_image_stack( mprob, [outname{i} '.mprob.tif'] );

	end

end