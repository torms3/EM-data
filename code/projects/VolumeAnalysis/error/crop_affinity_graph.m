function [affin] = crop_affinity_graph( affin, offset, sz )
% 
% Crop 3D affinity graph
% 
% Usage:
%   crop_affinity_graph( affin, offset, sz )
%   
%   affin       3D affinity graph
%   offset      crop offset
%   sz          crop size
%
% Return:
%   affin       cropped affinity graph
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu>  2015

	affin.x  = crop_volume(affin.x,offset,sz);
	affin.y  = crop_volume(affin.y,offset,sz);
	affin.z  = crop_volume(affin.z,offset,sz);

	affin.xy = crop_volume(affin.xy,offset,sz);
	affin.yz = crop_volume(affin.yz,offset,sz);
	affin.zx = crop_volume(affin.zx,offset,sz);

	affin.coord = affin.coord + offset - [1,1,1];
	affin.size  = sz;

end