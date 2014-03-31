function [ret] = compute_pixel_error_maximal_Fscore( prob, lbl )

	%% Best threshold
	%
	threshold = 0.00:0.01:0.999;
	prec = zeros(numel(threshold),1);
	rec = zeros(numel(threshold),1);
	fs = zeros(numel(threshold),1);
	pixelErr = zeros(numel(threshold),1);
	
	parfor i = 1:numel(threshold)

		th = threshold(i);
		% fprintf('(%d/%d) threshold = %.3f...\n',i,numel(threshold),th);
		
		nTp = 0;
		nFp = 0;
		nFn = 0;
		nErr = 0;
					
		% binary map
		bmap = prob < th;

		err = xor(bmap,~logical(lbl));
		tp = ~err & lbl;
		fp = err & ~lbl;
		fn = err & lbl;

		nTp = nnz(tp);
		nFn = nnz(fn);
		nFp = nnz(fp);
		nErr = nnz(err);

		prec(i) = nTp/(nTp + nFp);
		rec(i) = nTp/(nTp + nFn);
		fs(i) = 2*prec(i)*rec(i)/(prec(i)+rec(i));
		pixelErr(i) = 1 - fs(i);

	end

	ret.prec = prec;
	ret.rec = rec;
	ret.pxlErr = pixelErr;
	ret.th = threshold;
	ret.fs = fs;

	% validation
	invalid_idx = isnan(ret.prec) | isinf(ret.prec);
	invalid_idx = invalid_idx | (isnan(ret.rec) | isinf(ret.rec));
	ret.prec(invalid_idx) = [];
	ret.rec(invalid_idx) = [];
	ret.pxlErr(invalid_idx) = [];
	ret.th(invalid_idx) = [];
	ret.fs(invalid_idx) = [];

end