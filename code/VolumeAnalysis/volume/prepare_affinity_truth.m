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
% 		.x 		x-affinity truth
% 		.y 		y-affinity truth
% 		.z 		z-affinity truth
% 		.mx		x-affinity mask
% 		.my		y-affinity mask
% 		.mz		z-affinity mask
% 		.xy 	xy-plane boundary
% 		.yz 	yz-plane boundary
% 		.zx 	zx-plane boundary
% 		.mxy 	xy-plane mask
% 		.myz 	yz-plane mask
% 		.mzx 	zx-plane mask
% 		.coord	coordinate
% 		.size	size
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu> 	2015

	%% ground truth affinity graph
	% 
	fprintf('Preparing ground truth affinity graph...\n');
		
	% x, y, z-affinity graph
	truth = generate_affinity_graph(label);
	masks = generate_affinity_mask(mask);

	% safeguard
	assert(all(affin.coord > [1,1,1]));

	% crop
	offset  = affin.coord - [1,1,1];
	
	truth.x = crop_volume(truth.x,offset,affin.size);
	truth.y = crop_volume(truth.y,offset,affin.size);
	truth.z = crop_volume(truth.z,offset,affin.size);
	
	truth.mx = crop_volume(masks.x,offset,affin.size);
	truth.my = crop_volume(masks.y,offset,affin.size);
	truth.mz = crop_volume(masks.z,offset,affin.size);
	truth.mask = crop_volume(mask,offset,affin.size);

	truth.xy = truth.x & truth.y;
	truth.yz = truth.y & truth.z;
	truth.zx = truth.z & truth.x;

	truth.mxy = truth.mx & truth.my;
	truth.myz = truth.my & truth.mz;
	truth.mzx = truth.mz & truth.mx;
	
	truth.coord = affin.coord;
	truth.size 	= affin.size;

end