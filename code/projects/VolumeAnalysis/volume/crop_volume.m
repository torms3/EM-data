function [vol] = crop_volume( vol, offset, sz )
% Crop 3D volume
%
% Usage:
%   crop_volume( vol, offset )
%   crop_volume( vol, offset, sz )
%
%   vol       3D volume
%   offset    crop offset
%   sz        crop size
%
% Return:
%   vol       cropped volume
%
% Program written by:
% Copyright (C) 2015-2016 	Kisuk Lee <kiskulee@mit.edu>

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