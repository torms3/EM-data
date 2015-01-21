function [prep] = prepare_affinity_graph( fname, data, w, filtrad )

	if isempty(w)
		w = [0 0 0];
	end

	if ~exist('filtrad','var')
		filtrad = 0;
	end

	%% proposed affinity graph
	%
	fprintf('Now load proposed affinity graph...\n');
	nvol = 3;
	mvol = load_multivolume( fname, nvol );	

	P.x = mvol{1};
	P.y = mvol{2};
	P.z = mvol{3};

	if any(w)
		one = [1 1 1];
		P.x = adjust_border_effect(P.x,size(P.x)-w+one,true);
		P.y = adjust_border_effect(P.y,size(P.y)-w+one,true);
		P.z = adjust_border_effect(P.z,size(P.z)-w+one,true);
	end
	
	P.x = P.x(2:end,2:end,2:end);
	P.y = P.y(2:end,2:end,2:end);
	P.z = P.z(2:end,2:end,2:end);

	P.xy = min(P.x,P.y);
	P.yz = min(P.y,P.z);
	P.zx = min(P.z,P.x);

	% median filtering
	if filtrad > 0
		P.x = medfilt3(P.x,filtrad);
		P.y = medfilt3(P.y,filtrad);
		P.z = medfilt3(P.z,filtrad);

		P.xy = medfilt3(P.xy,filtrad);
		P.yz = medfilt3(P.yz,filtrad);
		P.zx = medfilt3(P.zx,filtrad);
	end

	%% ground truth affinity graph
	%
	fprintf('Now generating ground truth affinity graph...\n');
	truth = data.label;
	if any(w)
		truth = adjust_border_effect(truth,size(truth)-w+[1 1 1],true);	
	end
	G = generate_affinity_graph(truth);

	G.xy = G.x & G.y;
	G.yz = G.y & G.z;
	G.zx = G.z & G.x;

	%% preparation
	%
	prep.P = P;
	prep.G = G;

	% for watershed
	prep.affin = cat(4,P.x,P.y,P.z);

end