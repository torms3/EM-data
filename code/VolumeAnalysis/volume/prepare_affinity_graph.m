function [affin] = prepare_affinity_graph( fname, filtrad )
% 
% Prepare 3D affinity graph from ConvNet outputs
% 
% Usage:
% 	prepare_affinity_graph( fname )
% 	prepare_affinity_graph( fname, filtrad )
% 	
% 	fname		file name of the ConvNet outputs
%	filtrad		median filtering radius
%
% Return:
%	affin		affinity graph preparation
% 		.x 		x-affinity graph
% 		.y 		y-affinity graph
% 		.z 		z-affinity graph
% 		.xy 	xy-plane boundary prediction
% 		.yz 	yz-plane boundary prediction
% 		.zx 	zx-plane boundary prediction
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu> 	2015

	if ~exist('filtrad','var');filtrad = 0;end;

	%% proposed affinity graph
	%
	fprintf('Preparing affinity graph...\n');
	nvol = 3;
	mvol = load_multivolume(fname,nvol);

	affin.x = mvol{1};
	affin.y = mvol{2};
	affin.z = mvol{3};

	affin.xy = min(affin.x,affin.y);
	affin.yz = min(affin.y,affin.z);
	affin.zx = min(affin.z,affin.x);

	% median filtering
	if filtrad > 0
		affin.x  = medfilt3(affin.x,filtrad);
		affin.y  = medfilt3(affin.y,filtrad);
		affin.z  = medfilt3(affin.z,filtrad);

		affin.xy = medfilt3(affin.xy,filtrad);
		affin.yz = medfilt3(affin.yz,filtrad);
		affin.zx = medfilt3(affin.zx,filtrad);
	end

	% coordinate and size
	affin.coord = [1,1,1];
	affin.size  = size(affin.x);

end