function [ret] = compute_voxel_error( img, lbl, msk, thresh )
% Compute voxel-wise classification error
%
% Usage:
% 	compute_voxel_error( img, lbl )
% 	compute_voxel_error( img, lbl, msk )
% 	compute_voxel_error( img, lbl, [], thresh )
% 	compute_voxel_error( img, lbl, msk, thresh )
%
% 	img   : boundary image
% 	lbl   : ground truth (segmentation or boundary map)
% 	msk   : binary mask
% 	tresh : classification threshold
%
% Program written by:
% Copyright (C) 2015-2016 	Kisuk Lee <kiskulee@mit.edu>

	validate_args;

	bMap = img < thresh; % binary map

	ret.nTP = nnz( bMap & ~logical(lbl) & msk);
	ret.nFP = nnz( bMap &  logical(lbl) & msk);
	ret.nFN = nnz(~bMap & ~logical(lbl) & msk);
	ret.nTN = nnz(msk) - (ret.nTP + ret.nFP + ret.nFN);

	ret.prec = ret.nTP/(ret.nTP + ret.nFP);
	ret.rec  = ret.nTP/(ret.nTP + ret.nFN);
	ret.fs	 = 2*ret.prec*ret.rec/(ret.prec + ret.rec);

	ret.err    = (ret.nFP + ret.nFN)/nnz(msk);
	ret.poserr = ret.nFN/(ret.nTP + ret.nFN);
	ret.negerr = ret.nFP/(ret.nTN + ret.nFP);
	ret.balerr = 0.5*ret.poserr + 0.5*ret.negerr;


	function validate_args

		assert(isequal(size(img),size(lbl)));

		if ~exist('msk','var');	msk = [];				end;
		if isempty(msk);		msk = true(size(img));	end;

		assert(isequal(size(img),size(msk)));

		if ~exist('thresh','var')
			thresh = 0.5;
		end
	end

end