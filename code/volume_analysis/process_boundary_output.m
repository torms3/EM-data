function [] = process_boundary_output( fname, outname )

	if ~exist('outname','var')
		outname = fname;
	end

	for i = 1:numel(fname)
		
		[out] = assess_boundary_result_script( fname{i} );
		write_tif_image_stack( out.prob, [outname{i} '.prob.tif'] );
		write_tif_image_stack( out.mprob, [outname{i} '.mprob.tif'] );

	end

end