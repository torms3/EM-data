function assess_affinity_graph_script( fname, data, offset, FoV, filtrad, options )

	if ~iscell(fname);fname = {fname};		end;
	if ~iscell(data);data = {data};			end;	
	if ~exist('offset','var');offset = [];	end;
	if ~exist('FoV','var');FoV = [];		end;
	if ~exist('filtrad','var');filtrad = 0;	end;
	if ~exist('options','var')
		options = [1 1 1]; % voxel, 2D Rand, 3D Rand
	end

	for i = 1:numel(fname)
		if isfield(data{i},'mask')
			mask = data{i}.mask;
		else
			mask = true(size(data{i}.label));
		end
		disp(['Processing ' fname{i} '...']);
		assess_affinity_graph(fname{i},data{i}.label,mask);
	end


	function assess_affinity_graph( fname, label, mask )

		% prepare affinity graph
		[affin] = prepare_affinity_graph(fname,filtrad);
		
		% coordinate correction
		if ~isempty(offset)
			affin.coord = affin.coord + offset;
			fprintf('affinity graph coordinate = [%d,%d,%d]\n',affin.coord);
		end

		% crop FoV
		if ~isempty(FoV)
			offs  	= floor(FoV/2) + [1,1,1];
			sz 	    = affin.size - FoV + [1,1,1];
			[affin] = crop_affinity_graph(affin,offs,sz);
		end

		% prpare ground truth affinith graph
		[GT] = prepare_affinity_truth(label,affin,mask);
		truth = generate_affinity_graph(GT.label);
		masks = generate_affinity_mask(GT.mask);


		%% Voxel error
		%
		if options(1)
			disp(['Processing x-affinity...']);
			[result.x] = optimize_voxel_error(affin.x,truth.x,masks.x);
			disp(['Processing y-affinity...']);
			[result.y] = optimize_voxel_error(affin.y,truth.y,masks.y);
			disp(['Processing z-affinity...']);
			[result.z] = optimize_voxel_error(affin.z,truth.z,masks.z);
		end


		%% 2D Rand error
		%
		if options(2)
			% xy-plane		
			prob = affin.xy;
			lbl  = truth.x & truth.y;
			msk  = masks.x & masks.y;
			disp(['Processing xy-affinity...']);
			[result.xy] = optimize_2D_Rand_error(prob,lbl,msk);

			% yz-plane
			prob = rot90_3D(affin.yz,2,1);
			lbl  = rot90_3D(truth.y & truth.z,2,1);
			msk  = rot90_3D(masks.y & masks.z,2,1);
			disp(['Processing yz-affinity...']);
			[result.yz] = optimize_2D_Rand_error(prob,lbl,msk);

			% zx-plane
			prob = rot90_3D(affin.zx,1,3);
			lbl  = rot90_3D(truth.z & truth.x,1,3);
			msk  = rot90_3D(masks.z & masks.x,1,3);
			disp(['Processing zx-affinity...']);
			[result.zx] = optimize_2D_Rand_error(prob,lbl,msk);
		end


		%% 3D Rand error
        %
        if options(3)
	        % 3D connected component on thresholded affinity graph
	        disp(['Processing 3D Rand error...']);
	        msk  = crop_volume(GT.mask,[2 2 2]);
	        [result.xyz] = optimize_3D_Rand_error(affin,truth,msk);
	    end


		%% Save
		%		
		ox  = affin.coord(1);oy = affin.coord(2);oz = affin.coord(3);
		sx  = affin.size(1); sy = affin.size(2); sz = affin.size(3);
		str = sprintf('x%d_y%d_z%d_dim%dx%dx%d',ox,oy,oz,sx,sy,sz);
			
		fname = [fname '.' str];
		if filtrad > 0
			fname = [fname '.median' num2str(filtrad)];
		end

		% if exist, update
		update_result([fname '.mat'],result);

	end

end

%% Update result
% 
function update_result( fname, update )

	if exist(fname,'file')
		load(fname);
		
		fields = {'x','y','z','xy','zx','xyz'};
		for i = 1:numel(fields)
			field = fields{i};
			if isfield(update,field)
				result.(field) = update.(field);
			end
		end
	else
		result = update;
	end

	save(fname,'result');

end