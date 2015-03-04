function [ret] = compute_voxel_error( prob, truth, mask, thresh )
% 
% Compute voxel-wise classification error
% 
% Usage:
% 	compute_voxel_error( prob, truth )
% 	compute_voxel_error( prob, truth, mask )
% 	compute_voxel_error( prob, truth, [], thresh )
% 	compute_voxel_error( prob, truth, mask, thresh )
% 
% 	prob : boundary probability map
% 	truth: ground truth (segmentation or boundary map)
% 	mask : binary mask
% 	tresh: classification threshold
%
% Program written by:
% Copyright (C) 2015 	Kisuk Lee <kiskulee@mit.edu>

	assert(isequal(size(prob),size(truth)));
	if ~exist('mask','var')
		mask = [];
	else
		assert(isequal(size(prob),size(mask)));
	end
	if isempty(mask);mask = true(size(prob));end;
	if ~exist('thresh','var');thresh = 0.5;end;

	bMap = prob < thresh;	% binary map

	ret.nTP = nnz(bMap & ~logical(truth) & mask);
	ret.nFP = nnz(bMap & logical(truth) & mask);
	ret.nFN = nnz(~bMap & ~logical(truth) & mask);
	ret.nTN = nnz(mask) - (ret.nTP + ret.nFP + ret.nFN);

	ret.prec = ret.nTP/(ret.nTP + ret.nFP);
	ret.rec  = ret.nTP/(ret.nTP + ret.nFN);
	ret.fs	 = 2*ret.prec*ret.rec/(ret.prec + ret.rec);

	ret.err    = (ret.nFP + ret.nFN)/nnz(mask);
	ret.poserr = ret.nFN/(ret.nTP + ret.nFN);
	ret.negerr = ret.nFP/(ret.nTN + ret.nFP);
	ret.balerr = 0.5*ret.poserr + 0.5*ret.negerr;

end