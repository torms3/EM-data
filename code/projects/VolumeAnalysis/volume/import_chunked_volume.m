function [vol] = import_chunked_volume( fname, dim, grid )

	% Volume dimension.
	assert(numel(dim) == 3);
	fprintf('chunk dim = [%d %d %d]\n',dim);

	% Volume file.
	fvol = fopen(fname, 'r');
	if fvol < 0
		vol = [];
		return;
	end

	vol = uint8(zeros(dim.*grid));

	% Read chunk.
	for z = 1:grid(3)
		for y = 1:grid(2)
			for x = 1:grid(1)
				off = ([x y z]-1).*dim + 1;
				% disp(off)
				vol(off(1):off(1)+dim(1)-1,off(2):off(2)+dim(2)-1,off(3):off(3)+dim(3)-1) = read_chunk(fvol);
			end
		end
	end

	fclose(fvol);

	function [chunk] = read_chunk( fid )

		chunk = zeros(prod(dim), 1);
		chunk = fread(fid, size(chunk), 'uint8');
		chunk = reshape(chunk, dim);

	end

end
