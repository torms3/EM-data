function [ret] = compute_voxel_error( prob, truth, thresh )
% 
% Compute voxel-wise classification error
% 
% Usage:
% 	compute_voxel_error( prob, truth )
% 	compute_voxel_error( prob, truth, thresh )
% 
% 	prob : boundary probability map
% 	truth: ground truth (segmentation or boundary map)
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

	ret.prec = ret.nTP/(ret.nTP + ret.nFP);
	ret.rec  = ret.nTP/(ret.nTP + ret.nFN);
	ret.fs	 = 2*ret.prec*ret.rec/(ret.prec + ret.rec);

	ret.err    = (ret.nFP + ret.nFN)/numel(bMap);
	ret.poserr = ret.nFN/(ret.nTP + ret.nFN);
	ret.negerr = ret.nFP/(ret.nTN + ret.nFP);
	ret.balerr = mean(ret.poserr,ret.negerr);

end