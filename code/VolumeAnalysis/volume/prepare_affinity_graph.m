function [prep] = prepare_affinity_graph( fname, data, filtrad )

	if ~exist('filtrad','var')
		filtrad = 0;
	end

	%% proposed affinity graph
	%
	fprintf('Now load proposed affinity graph...\n');
	nvol = 3;
	mvol = load_multivolume( fname, nvol );	

	P.x = mvol{1}(2:end,2:end,2:end);
	P.y = mvol{2}(2:end,2:end,2:end);
	P.z = mvol{3}(2:end,2:end,2:end);

	P.xy = min(P.x,P.y);
	P.yz = min(P.y,P.z);
	P.zx = min(P.z,P.x);

	% median filtering
	if filtrad > 0
		P.x = medfilt3( P.x, filtrad );
		P.y = medfilt3( P.y, filtrad );
		P.z = medfilt3( P.z, filtrad );

		P.xy = medfilt3( P.xy, filtrad );
		P.yz = medfilt3( P.yz, filtrad );
		P.zx = medfilt3( P.zx, filtrad );
	end

	%% ground truth affinity graph
	%
	fprintf('Now generating ground truth affinity graph...\n');
	G = generate_affinity_graph( data.label );

	G.xy = G.x & G.y;
	G.yz = G.y & G.z;
	G.zx = G.z & G.x;

	%% preparation
	%
	prep.P = P;
	prep.G = G;

end