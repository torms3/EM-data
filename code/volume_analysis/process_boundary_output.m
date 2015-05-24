function [] = process_boundary_output( fname, filtrad, outname )

	if ~iscell(fname)
		fname = {fname};
	end
	if ~exist('filtrad','var')
		filtrad = [];
	end
	if ~exist('outname','var')
		outname = fname;
	end

	for i = 1:numel(fname)
		
		% [fwdimg] = import_multivolume( fname{i} );
		
		% outidx = 2;
		% [prob,mprob] = generate_prob_map( fwdimg, outidx, filtrad );

		prob = import_volume([fname{i} '.1']);
		
		% median filtering
		mprob = [];
		if any(filtrad)
			[mprob] = medfilt3( prob, filtrad );
		end

		write_tif_image_stack( prob, [outname{i} '.prob.tif'] );
		write_tif_image_stack( mprob, [outname{i} '.mprob.tif'] );

	end

end