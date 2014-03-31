function [ret] = compute_classification_error( prob, truth, mask, thresh )

	%% Argument validation
	%	prob: probability map ([0,1])
	% 	truth: ground truth (binary)
	assert(isequal(size(prob),size(truth)));
	assert(isequal(size(prob),size(mask)));
	if ~exist('thresh','var')
		thresh = 0.5;
	else
		thresh = max(0,min(1,thresh));
	end


	%% Compute error
	%
	truth = ~logical(truth); 	% binary "boundary" truth	
	prob = (prob < thresh); 	% binary "boundary" map	

	tpMap = prob & truth & mask;
	fnMap = ~prob & truth & mask;
	fpMap = prob & ~truth & mask;

	tp = nnz(tpMap);
	fn = nnz(fnMap);
	fp = nnz(fpMap);

	ret.prec 	= tp/(tp+fp);
	ret.rec  	= tp/(tp+fn);
	ret.pxlErr 	= (fn+fp)/nnz(mask);
	ret.fscore	= 2*ret.prec*ret.rec/(ret.prec+ret.rec);

end