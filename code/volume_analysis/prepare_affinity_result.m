function [ret] = prepare_affinity_result( fname, data, load_from_tif )

	if ~exist('load_from_tif','var')
		load_from_tif = false;
	end

	%% Options
	%
	show_error = true;
	symm_affin = false;


	% import forward image
	fprintf('Now importing forward image...\n');
	if load_from_tif
		[img] = load_affinity_from_tif( fname );
	else
		[img] = import_multivolume( fname );
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
	% ret.prob 	= scaledata(prob,0,1);
	ret.prob	= prob;
	ret.truth 	= truth;
	if isfield(data,'mask')
		ret.mask = mask;
	end

end