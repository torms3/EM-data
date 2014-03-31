function [ret] = divide_data( data, xDist, yDist, zDist )

	%% Argument validations
	%
	assert(is_valid_volume_dataset( data ));

	% divide data
	cImage = mat2cell(data.image,xDist,yDist,zDist);
	cLabel = mat2cell(data.label,xDist,yDist,zDist);
	if isfield(data,'aux')
		cAux = mat2cell(data.aux,xDist,yDist,zDist);
	end
	if isfield(data,'mask')
		cMask = mat2cell(data.mask,xDist,yDist,zDist);
	end

	% reconstruct divided data
	idx = 1;
	for i = 1:numel(xDist)
		for j = 1:numel(yDist)
			for k = 1:numel(zDist)
				ret{idx}.image = cImage{i,j,k};
				ret{idx}.label = cLabel{i,j,k};
				if isfield(data,'aux')
					ret{idx}.aux = cAux{i,j,k};
				end
				if isfield(data,'mask')
					ret{idx}.mask = cMask{i,j,k};
				end
				idx = idx + 1;
			end
		end
	end

end