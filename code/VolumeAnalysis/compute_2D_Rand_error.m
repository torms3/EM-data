function [ret] = compute_2D_Rand_error( prob, truth, thresh )

	if ~exist('thresh','var')
		thresh = 0.5;
	end

	% 4-connected neighborhood
	conn = 4;

	% ground truth
	segA = single(truth~=0);
	segA = bwlabeln(segA,conn);

	% proposed
	segB = prob > thresh;
	segB = bwlabeln(segB,conn);

	% 2D Rand index
	ret = SNEMI3D_metrics(segA,segB);

end