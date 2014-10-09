function [affin] = prepare_affinity_graph( fname, filtrad, crop_volume )

	if ~exist('filtrad','var')
		filtrad = 0;
	end
	if ~exist('crop_volume','var')
		crop_volume = [];
	end

	% options
	symm_affin = false;


	% import forward image
	fprintf('Now importing forward image...\n');
	[img] = import_multivolume( fname );

	% median filtering
	if filtrad > 0
		[img{1}] = medfilt3( img{1}, filtrad );
		[img{2}] = medfilt3( img{2}, filtrad );
		[img{3}] = medfilt3( img{3}, filtrad );
	end

	% crop volume	
	if ~isempty(crop_volume)
		img{1} = adjust_border_effect( img{1}, crop_volume, true );
		img{2} = adjust_border_effect( img{2}, crop_volume, true );
		img{3} = adjust_border_effect( img{3}, crop_volume, true );
	end	

	% affinity graph
	affin  = cat(4,img{1},img{2},img{3});

end