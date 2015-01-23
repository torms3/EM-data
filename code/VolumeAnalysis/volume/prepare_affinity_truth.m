function [truth] = prepare_affinity_truth( label, affin )
% 
% Prepare ground truth affinity graph
% 
% Usage:
% 	prepare_affinity_truth( label, affin )
% 	
% 	label		ground truth segmentation
% 	affin 		affinity graph preparation
%
% Return:
%	truth		ground truth affinity graph preparation
% 		.x 		x-affinity truth
% 		.y 		y-affinity truth
% 		.z 		z-affinity truth
% 		.xy 	xy-plane boundary
% 		.yz 	yz-plane boundary
% 		.zx 	zx-plane boundary
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu> 	2015

	%% ground truth affinity graph
	% 
	fprintf('Preparing ground truth affinity graph...\n');
		
	% x, y, z-affinity graph
	truth = generate_affinity_graph(label);

	% safeguard
	assert(all(affin.coord > [1,1,1]));

	% crop
	offset  = affin.coord - [1,1,1];
	truth.x = crop_volume(truth.x,offset,affin.size);
	truth.y = crop_volume(truth.y,offset,affin.size);
	truth.z = crop_volume(truth.z,offset,affin.size);

	truth.xy = truth.x & truth.y;
	truth.yz = truth.y & truth.z;
	truth.zx = truth.z & truth.x;

	truth.coord = affin.coord;
	truth.size 	= affin.size;

end