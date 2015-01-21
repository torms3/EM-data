function [vol] = crop_volume( vol, offset, sz )

	if ~exist('sz','var')
		sz = [];
	end

	ox = offset(1);
	oy = offset(2);
	oz = offset(3);

	if isempty(sz)
		vol = vol(ox:end, oy:end, oz:end);
	else
		vol = vol(ox:ox+sz(1)-1, oy:oy+sz(2)-1, oz:oz+sz(3)-1);
	end

end