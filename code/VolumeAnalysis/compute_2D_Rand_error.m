function [ret] = compute_2D_Rand_error( prob, truth, mask, thresh )

	assert(isequal(size(prob),size(truth)));
	if ~exist('mask','var')
		mask = [];
	else
		assert(isequal(size(prob),size(mask)));
	end
	if isempty(mask);mask = true(size(prob));end;
	if ~exist('thresh','var');thresh = 0.5;end;

	% 4-connected neighborhood
	conn = 4;

	% ground truth
	segA = single(truth~=0);
	segA = bwlabeln(segA,conn);
	segA(~mask) = 0;

	% proposed
	segB = prob > thresh;
	segB = bwlabeln(segB,conn);
	segB(~mask) = 0;

	% 2D Rand index
	ret = SNEMI3D_metrics(segA,segB);

end