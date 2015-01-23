function prepare_omnification_script( fname, params, offset, crop, filtrad, data )

	if ~iscell(fname)
		fname = {fname};
	end

	if ~exist('filtrad','var')
		filtrad = 0;
	end

	if ~exist('offset','var')
		offset = [];
	end

	if ~exist('crop','var')
		crop = []
	end

	% optional data for channel
	if exist('data','var')
		if ~iscell(data)
			data = {data};
		end
	end

	if ~exist('watershed','dir')
		disp('mkdir watershed');
		mkdir('watershed');
	end

	for i = 1:numel(fname)
		affin = prepare_affinity_graph(fname{i},filtrad);

		% coordinate correction
		if ~isempty(offset)
			affin.coord = affin.coord + offset;
			fprintf('affinity graph coordinate = [%d,%d,%d]\n',affin.coord);
		end

		% crop
		if ~isempty(crop)
			[affin] = crop_affinity_graph(affin,crop(1),crop(2));
		end

		prep = single(cat(4,affin.x,affin.y,affin.z));
		watershed(['watershed/' fname{i}],prep,params);

		if exist('data','var')			
			generate_channel(['watershed/' fname{i}],data{i}.image,affin.coord,affin.size);
		end		
	end

end