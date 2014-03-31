function [ret] = compute_pixel_error( prob, truth, mask )

	%% Argument validation
	%
	assert(isequal(size(prob),size(truth)));
	assert(isfloat(prob));
	assert(isfloat(truth));
	if exist('mask','var')
		assert(isequal(size(prob),size(mask)));
		assert(islogical(mask));
	end

	%% Preprocessing
	%
	prob = scaledata(prob,0,1);

	%% Best threshold
	%
	threshold = [0.1:0.1:0.9 0.91:0.01:0.99];
	nThresh = numel(threshold);

	precision  = zeros(1,nThresh);
	recall	   = zeros(1,nThresh);
	pixelError = zeros(1,nThresh);

	for i = 1:nThresh

		thresh = threshold(i);
		fprintf('(%d/%d) threshold = %.3f...\n',i,nThresh,thresh);

		nTP = 0;	% true positive
		nFP = 0;	% false positive
		nFN = 0;	% false negative

		bMap = prob < thresh;	% boundary map

		if exist('mask','var')
			nTP = nnz(xor(bMap,~logical(truth)) & mask);
			nFP = nnz(bMap & logical(truth) & mask);
			nFN = nnz(~bMap & ~logical(truth) & mask);
		else
			nTP = nnz(xor(bMap,~logical(truth)));
			nFP = nnz(bMap & logical(truth));
			nFN = nnz(~bMap & ~logical(truth));
		end

		precision(i)  = nTP/(nTP+nFP);
		recall(i)	  = nTP/(nTP+nFN);
		pixelError(i) = (nFP+nFN);
		if exist('mask','var')
			pixelError(i) = pixelError(i)/nnz(mask);
		else
			pixelError(i) = pixelError(i)/numel(prob);
		end

	end

	%% Return structure
	%
	ret.prec   = precision;
	ret.rec    = recall;
	ret.pxlErr = pixelError;
	ret.thresh = threshold;
	ret.fscore = (2*precision.*recall)./(precision+recall);
	ret.maxF   = 1-ret.fscore;

end