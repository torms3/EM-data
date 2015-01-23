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
		mkdir('watershed');
	end

	for i = 1:numel(fname)
		affin = prepare_affinity_graph(fname{i},filtrad);

		% coordinate correction
		if ~isempty(offset)
			affin.coord = affin.coord + offset;
		end

		% crop
		if ~isempty(crop)
			[affin] = crop_affinity_graph(affin,crop(1),crop(2));
		end

		watershed(['watershed/' fname{i}],prep.affin,params);

		if exist('data','var')
			offset = floor(w/2) + [1 1 1];
			sz = size(prep.P.x);
			generate_channel(['watershed/' fname{i}],data{i},offset,sz);
		end		
	end

end