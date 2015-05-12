function [err] = bootstrap_voxel_error( prob, truth, mask, thresh, nboot )

	assert(isequal(size(prob),size(truth)));
	if ~exist('mask','var')
		mask = [];
	else
		assert(isequal(size(prob),size(mask)));
	end
	if isempty(mask);mask = true(size(prob));end;
	if ~exist('thresh','var');thresh = 0.5;end;

	% bootstrap sample
	idx = randsample(numel(prob),prod(nboot),true);
	idx = reshape(idx,nboot);

	bMap = prob > thresh;	% binary map
	truth = logical(truth);
	err = sum(xor(bMap(idx),truth(idx)),1)/nboot(1);
	
end