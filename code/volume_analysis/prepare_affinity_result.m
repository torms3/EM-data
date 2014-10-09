function [prep] = prepare_affinity_result( fname, data, filtrad, crop_volume )

	if ~exist('filtrad','var')
		filtrad = 0;
	end
	if ~exist('crop_volume','var')
		crop_volume = [];
	end

	%% Options
	%
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

	% original affinity graph
	fprintf('Now generating affinity graph...\n');
	[G] = generate_affinity_graph( data.label );
	if( symm_affin )
		G.x = G.x(1:end-1,1:end-1,1:end-1);
		G.y = G.y(1:end-1,1:end-1,1:end-1);
		G.z = G.z(1:end-1,1:end-1,1:end-1);
	end

	% affinity mask
	fprintf('Now generating affinity mask...\n');
	if isfield(data,'mask')
		[M] = generate_affinity_mask( data.mask );
		if( symm_affin )
			M.x = M.x(1:end-1,1:end-1,1:end-1);
			M.y = M.y(1:end-1,1:end-1,1:end-1);
			M.z = M.z(1:end-1,1:end-1,1:end-1);
		end
	end	

	% adjusting size difference between forward image and ground truth
	[G.x] = adjust_border_effect( G.x, img{1} );
	[G.y] = adjust_border_effect( G.y, img{2} );
	[G.z] = adjust_border_effect( G.z, img{3} );
	if isfield(data,'mask')
		[M.x] = adjust_border_effect( M.x, img{1} );
		[M.y] = adjust_border_effect( M.y, img{2} );
		[M.z] = adjust_border_effect( M.z, img{3} );
	end


	%% Error
	%
	prob  = cat(4,img{1},img{2},img{3});
	truth = cat(4,G.x,G.y,G.z);
	if isfield(data,'mask')
		mask  = cat(4,M.x,M.y,M.z);
	end
	

	%% Return
	%
	prep.prob	= prob;
	prep.truth 	= truth;
	if isfield(data,'mask')
		prep.mask = mask;
	end

end