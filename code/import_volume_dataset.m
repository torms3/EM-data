function [data] = import_volume_dataset( fname )
		
	[vol] = import_volume(fname,[],'image');
	if ~isempty(vol)
		data.image = vol;
	end

	[vol] = import_volume(fname,[],'label');
	if ~isempty(vol)
		data.label = vol;
	end

	[vol] = import_volume_mask(fname,[],'mask');
	if ~isempty(vol)
		data.mask = vol;
	end

	[vol] = import_volume(fname,[],'CLAHE');
	if ~isempty(vol)
		data.CLAHE = vol;
	end

end