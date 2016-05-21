function [ret] = is_valid_volume_dataset( data )
	
	if( isstruct(data) )
		ret = true;
		ret = ret & isfield(data,'image');
		ret = ret & isfield(data,'label');
		ret = ret & (isequal(size(data.image),size(data.label)));
		if isfield(data,'aux')
			ret = ret & isequal(size(data.image),size(data.aux));
		end
		if isfield(data,'mask')
			ret = ret & (isequal(size(data.image),size(data.mask)));
		end
	else
		ret = false;
	end

end