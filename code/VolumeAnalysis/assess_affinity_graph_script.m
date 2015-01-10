function assess_affinity_graph_script( fname, data, filtrad )

	if ~exist('filtrad','var')
		filtrad = 0;
	end

	% prepare
	[prep] = prepare_affinity_graph(fname,data,filtrad);


	%% Voxel error
	%
	disp(['Processing x-affinity...']);
	[data.x] = optimize_voxel_error(prep.P.x,prep.G.x);
	disp(['Processing y-affinity...']);
	[data.y] = optimize_voxel_error(prep.P.y,prep.G.y);
	disp(['Processing z-affinity...']);
	[data.z] = optimize_voxel_error(prep.P.z,prep.G.z);


	%% 2D Rand error
	%
	% xy-plane
	prob  = prep.P.xy;
	truth = prep.G.xy;
	disp(['Processing xy-affinity...']);
	[data.xy] = optimize_2D_Rand_error(prob,truth);

	% yz-plane
	prob  = rot90_3D(prep.P.yz,2,1);
	truth = rot90_3D(prep.G.yz,2,1);
	disp(['Processing yz-affinity...']);
	[data.yz] = optimize_2D_Rand_error(prob,truth);

	% zx-plane
	prob  = rot90_3D(prep.P.zx,1,3);
	truth = rot90_3D(prep.G.zx,1,3);
	disp(['Processing zx-affinity...']);
	[data.zx] = optimize_2D_Rand_error(prob,truth);


	%% Save
	%
	if filtrad > 0
		fname = [fname '.median' num2str(filtrad)];
	end
	save(fname,'data');

end