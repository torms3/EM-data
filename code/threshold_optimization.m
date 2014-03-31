function [ret] = threshold_optimization( prob, truth, mask )

	% threshold = 0.01:0.01:0.99;
	threshold = 0.09:0.1:0.99;
	prec 	= zeros(numel(threshold),1);
	rec 	= zeros(numel(threshold),1);
	pxlErr 	= zeros(numel(threshold),1);
	fscore 	= zeros(numel(threshold),1);

	bTruth = ~logical(truth); 	% binary "boundary" truth	

	parfor i = 1:numel(threshold)

		th = threshold(i);
		fprintf('(%d/%d) threshold = %.3f...\n',i,numel(threshold),th);
		
		%% Compute error
		%
		% [err] = compute_classification_error(prob,truth,mask,th);
		bMap = (prob < th); 	% binary "boundary" map
		tpMap = bMap & bTruth & mask;
		fnMap = ~bMap & bTruth & mask;
		fpMap = bMap & ~bTruth & mask;

		tp = nnz(tpMap);
		fn = nnz(fnMap);
		fp = nnz(fpMap);

		prec(i) 	= tp/(tp+fp);
		rec(i)  	= tp/(tp+fn);
		pxlErr(i) 	= (fn+fp)/nnz(mask);
		fscore(i)	= 2*prec(i)*rec(i)/(prec(i)+rec(i));

		% prec(i) 	= err.prec;
		% rec(i) 		= err.rec;
		% pxlErr(i) 	= err.pxlErr;
		% fscore(i) 	= err.fscore;

	end

	ret.prec	= prec;
	ret.rec 	= rec;
	ret.pxlErr	= pxlErr;
	ret.fscore 	= fscore;
	ret.thresh 	= threshold;

end