function [tensor] = import_tensor( fname, dim, ext, dtype )

	if ~exist('dim','var'); 		  dim = []; end;
	if ~exist('ext','var'); 		  ext = []; end;
	if ~exist('dtype','var'); dtype = 'double'; end;

	% tensor dimension
	if isempty(dim)
		dim = import_size(fname,4);
	end
	assert(numel(dim) == 4);
	fprintf('dim = [%d %d %d %d]\n',dim);

	% tensor
	if isempty(ext)
		ftensor = fopen(fname, 'r');
	else
		ftensor = fopen([fname '.' ext], 'r');
	end
	if ftensor < 0
		tensor = [];
		return;
	end

	tensor = zeros(prod(dim), 1);
	tensor = fread(ftensor, size(tensor), dtype);
	tensor = reshape(tensor, dim);

end