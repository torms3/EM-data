function assess_affinity_graph_script( fname, data, offset, crop, filtrad )

	if ~iscell(fname);fname = {fname};		end;
	if ~iscell(data);data = {data};			end;	
	if ~exist('offset','var');offset = [];	end;
	if ~exist('crop','var');crop = [];		end;
	if ~exist('filtrad','var');filtrad = 0;	end;

	for i = 1:numel(fname)		
		if isfield(data{i},'mask')
			mask = data{i}.mask;
		else
			mask = true(data{i}.label);
		end
		assess_affinity_graph(fname{i},data{i}.label,mask,offset,crop,filtrad);
	end


	function assess_affinity_graph( fname, label, mask, offset, crop, filtrad )

		% prepare affinity graph
		[affin] = prepare_affinity_graph(fname,filtrad);
		
		% coordinate correction
		if ~isempty(offset)
			affin.coord = affin.coord + offset;
			fprintf('affinity graph coordinate = [%d,%d,%d]\n',affin.coord);
		end

		% crop
		if ~isempty(crop)
			% ConvNet FoV interpretation
			if numel(crop) == 1
				w 	   = crop{1};
				offset = floor(w/2) + [1,1,1];
				sz 	   = affin.size - w + [1,1,1];
				[affin] = crop_affinity_graph(affin,offset,sz);
			else
				[affin] = crop_affinity_graph(affin,crop{1},crop{2});
			end
		end

		% prpare ground truth affinith graph
		[GT] = prepare_affinity_truth(label,affin,mask);


		%% Voxel error
		%
		disp(['Processing x-affinity...']);
		[result.x] = optimize_voxel_error(affin.x,GT.x,GT.mx);
		disp(['Processing y-affinity...']);
		[result.y] = optimize_voxel_error(affin.y,GT.y,GT.my);
		disp(['Processing z-affinity...']);
		[result.z] = optimize_voxel_error(affin.z,GT.z,GT.mz);


		%% 2D Rand error
		%
		% xy-plane
		prob  = affin.xy;
		truth = GT.xy;
		mask  = GT.mxy;
		disp(['Processing xy-affinity...']);
		[result.xy] = optimize_2D_Rand_error(prob,truth,mask);

		% yz-plane
		prob  = rot90_3D(affin.yz,2,1);
		truth = rot90_3D(GT.yz,2,1);
		mask  = rot90_3D(GT.myz,2,1);
		disp(['Processing yz-affinity...']);
		[result.yz] = optimize_2D_Rand_error(prob,truth,mask);

		% zx-plane
		prob  = rot90_3D(affin.zx,1,3);
		truth = rot90_3D(GT.zx,1,3);
		mask  = rot90_3D(GT.mzx,1,3);
		disp(['Processing zx-affinity...']);
		[result.zx] = optimize_2D_Rand_error(prob,truth,mask);


		%% Save
		%		
		ox = affin.coord(1);
		oy = affin.coord(2);
		oz = affin.coord(3);

		sx = affin.size(1);
		sy = affin.size(2);
		sz = affin.size(3);

		str = sprintf('x%d_y%d_z%d_dim%dx%dx%d',ox,oy,oz,sx,sy,sz);
			
		fname = [fname '.' str];

		if filtrad > 0
			fname = [fname '.median' num2str(filtrad)];
		end

		save([fname '.mat'],'result');

	end

end