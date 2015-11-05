function [tensor] = import_tensor( fname, dim, ext, dtype )

	if ~exist('dim','var'); 		  dim = []; end;
	if ~exist('ext','var'); 		  ext = []; end;
	if ~exist('dtype','var'); dtype = 'double'; end;

	% tensor dimension
	if isempty(dim)
		fsz = fopen([fname '.size'], 'r');
		if fsz < 0
			tensor = [];
			return;
		end
		x = fread(fsz, 1, 'uint32');
		y = fread(fsz, 1, 'uint32');
		z = fread(fsz, 1, 'uint32');
		w = fread(fsz, 1, 'uint32');
		dim = [x y z w];
	end
	assert(numel(dim) == 4);
	fprintf('dim = [%d %d %d %d]\n',dim(1),dim(2),dim(3),dim(4));

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