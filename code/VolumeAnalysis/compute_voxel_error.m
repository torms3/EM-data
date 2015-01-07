function [ret] = compute_voxel_error( prob, truth, thresh )
% 
% Compute
% 
% Usage:
% 	compute_voxel_error( prob, truth )
% 	compute_voxel_error( prob, truth, thresh )
% 
% 	prob : boundary probability map
% 	truth: ground truth
% 	tresh: classification threshold
%
% Program written by:
% Copyright (C) 2015 	Kisuk Lee <kiskulee@mit.edu>

	if ~exist('thresh','var')
		thresh = 0.5;
	end

	bMap = prob < thresh;	% binary map

	ret.nTP = nnz(xor(bMap,~logical(truth)));
	ret.nFP = nnz(bMap & logical(truth));
	ret.nFN = nnz(~bMap & ~logical(truth));
	ret.nTN = numel(bMap) - (ret.nTP + ret.nFP + ret.nFN);

	ret.posACC = ret.nTP/(ret.nTP+ret.nFN);
	ret.negACC = ret.nTN/(ret.nTN+ret.nFP);
	ret.balACC = 0.5*ret.posACC + 0.5*ret.negACC;

	ret.posERR = 1 - ret.posACC;
	ret.negERR = 1 - ret.negERR;
	ret.balERR = 1 - ret.balACC;

	ret.voxelACC = (ret.nTP+ret.nTN)/numel(bMap);
	ret.voxelERR = 1 - ret.voxelACC;

end