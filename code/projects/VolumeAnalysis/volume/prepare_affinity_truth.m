function [truth] = prepare_affinity_truth( label, affin, mask )
% 
% Prepare ground truth affinity graph
% 
% Usage:
% 	prepare_affinity_truth( label, affin, mask )
% 	
% 	label		ground truth segmentation
% 	affin 		affinity graph preparation
%
% Return:
%	truth		ground truth affinity graph preparation
% 		.mask 	label mask
% 		.coord	coordinate
% 		.size	size
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu> 	2015

	%% ground truth affinity graph
	% 
	fprintf('Preparing ground truth affinity graph...\n');
		
	% safeguard
	assert(all(affin.coord > [1,1,1]));

	% crop
	offset  = affin.coord - [1,1,1];
	sz 		= affin.size + [1 1 1];

	truth.label = crop_volume(label,offset,sz);
	truth.mask  = crop_volume(mask,offset,sz);
	
	truth.coord = offset;
	truth.size 	= sz;

end