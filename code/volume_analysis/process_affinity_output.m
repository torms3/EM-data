function [] = process_affinity_output( fname, filtrad, outname )
	
	if ~exist('filtrad','var')
		filtrad = [];
	end
	if ~exist('outname','var')
		outname = fname;
	end

	for i = 1:numel(fname)
		
		fvol = fopen(fname{i},'r');
		if fvol ~= -1
			[tensor] = import_tensor(fname{i});
			for j = 1:size(tensor,4)
				out{j} = tensor(:,:,:,j);
			end
		else
			[out] = import_multivolume( fname{i} );
		end

		write_tif_image_stack( out{1}, [outname{i} '.affin.x.tif'] );
		write_tif_image_stack( out{2}, [outname{i} '.affin.y.tif'] );
		write_tif_image_stack( out{3}, [outname{i} '.affin.z.tif'] );

		% median filtering
		if any(filtrad)
			[filtered{1}] = medfilt3( out{1}, filtrad );
			[filtered{2}] = medfilt3( out{2}, filtrad );
			[filtered{3}] = medfilt3( out{3}, filtrad );

			write_tif_image_stack( filtered{1}, [outname{i} '.med' num2str(filtrad) '.affin.x.tif'] );
			write_tif_image_stack( filtered{2}, [outname{i} '.med' num2str(filtrad) '.affin.y.tif'] );
			write_tif_image_stack( filtered{3}, [outname{i} '.med' num2str(filtrad) '.affin.z.tif'] );
		end

	end

end