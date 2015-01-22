function [prep] = prepare_affinity_graph( fname, w, filtrad, data )

	if ~isempty(w)
		assert(isequal(mod(w,2),[1 1 1]));
		assert(all(floor(w/2)>[0 0 0]));
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

	% border effect (ConvNet FoV)
	if ~isempty(w)
		one = [1 1 1];
		offset = floor(w/2) + one;
		P.x = crop_volume(P.x,offset,size(P.x)-w+one);
		P.y = crop_volume(P.y,offset,size(P.y)-w+one);
		P.z = crop_volume(P.z,offset,size(P.z)-w+one);
	end

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


	%% preparation
	%
	prep.P = P;
	prep.affin = cat(4,P.x,P.y,P.z);


	%% ground truth affinity graph
	%
	if exist('data','var')
		fprintf('Now generating ground truth affinity graph...\n');
		
		G = generate_affinity_graph(data.label);
		if ~isempty(w)
			offset = floor(w/2);
			G.x = crop_volume(G.x,offset,size(P.x));
			G.y = crop_volume(G.y,offset,size(P.y));
			G.z = crop_volume(G.z,offset,size(P.z));
		end
		
		G.xy = G.x & G.y;
		G.yz = G.y & G.z;
		G.zx = G.z & G.x;

		prep.G = G;
	end

end