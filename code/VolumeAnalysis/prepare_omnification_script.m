function prepare_omnification_script( fname, w, filtrad, params, data )

	if isempty(w)
		w = [0 0 0];
	end

	if ~exist('filtrad','var')
		filtrad = 0;
	end

	if ~iscell(fname)
		fname = {fname};
	end

	if exist('data','var')
		if ~iscell(data)
			data = {data};
		end
	end

	if ~exist('watershed','dir')
		mkdir('watershed');
	end

	for i = 1:numel(fname)
		prep = prepare_affinity_graph(fname{i},w,filtrad);
		watershed(['watershed/' fname{i}],prep.affin,params);

		if exist('data','var')
			offset = floor(w/2) + [1 1 1];
			sz = size(prep.P.x);
			generate_channel(fname{i},data{i},offset,sz);
		end		
	end

end