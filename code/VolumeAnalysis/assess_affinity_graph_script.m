function assess_affinity_graph_script( fname, data, offset, crop, filtrad )

	if ~iscell(fname)
		fname = {fname};
	end

	if ~iscell(data)
		data = {data};
	end

	if ~exist('offset','var')
		offset = [];
	end

	if ~exist('crop','var')
		crop = [];
	end

	if ~exist('filtrad','var')
		filtrad = 0;
	end

	for i = 1:numel(fname)
		assess_affinity_graph(fname{i},data{i}.label,offset,crop,filtrad);
	end


	function assess_affinity_graph( fname, label, offset, crop, filtrad )

		% prepare affinity graph
		[affin] = prepare_affinity_graph(fname,filtrad);
		
		% coordinate correction
		if ~isempty(offset)
			affin.coord = affin.coord + offset;
		end

		%  crop
		if ~isempty(crop)
			% ConvNet FoV interpretation
			if numel(crop == 1)
				w 	   = crop(1);
				offset = floor(w/2) + [1,1,1];
				sz 	   = affin.size - w + [1,1,1];
				[affin] = crop_affinity_graph(affin,offset,sz);
			else
				[affin] = crop_affinity_graph(affin,crop(1),crop(2));
			end
		end

		% prpare ground truth affinith graph
		[GT] = prepare_affinity_truth(label,affin);


		%% Voxel error
		%
		disp(['Processing x-affinity...']);
		[result.x] = optimize_voxel_error(affin.x,GT.x);
		disp(['Processing y-affinity...']);
		[result.y] = optimize_voxel_error(affin.y,GT.y);
		disp(['Processing z-affinity...']);
		[result.z] = optimize_voxel_error(affin.z,GT.z);


		%% 2D Rand error
		%
		% xy-plane
		prob  = affin.xy;
		truth = GT.xy;
		disp(['Processing xy-affinity...']);
		[result.xy] = optimize_2D_Rand_error(prob,truth);

		% yz-plane
		prob  = rot90_3D(affin.yz,2,1);
		truth = rot90_3D(GT.yz,2,1);
		disp(['Processing yz-affinity...']);
		[result.yz] = optimize_2D_Rand_error(prob,truth);

		% zx-plane
		prob  = rot90_3D(affin.zx,1,3);
		truth = rot90_3D(GT.zx,1,3);
		disp(['Processing zx-affinity...']);
		[result.zx] = optimize_2D_Rand_error(prob,truth);


		%% Save
		%		
		ox = affin.coord(1);
		oy = affin.coord(2);
		oz = affin.coord(3);

		sx = affin.size(1);
		sy = affin.size(2);
		sz = affin.size(3);

		str = sprintf('x%d_y%d_z%d_sx%d_sy%d_sz%d',ox,oy,oz,sx,sy,sz);

		% ConvNet FoV interpretation
		if ~isempty(crop)
			if numel(crop == 1)
				w = crop(1);
				str = sprintf('w%dx%dx%d',w(1),w(2),w(3));
			end
		end
			
		fname = [fname '.' str];

		if filtrad > 0
			fname = [fname '.median' num2str(filtrad)];
		end

		save(fname,'result');

	end

end