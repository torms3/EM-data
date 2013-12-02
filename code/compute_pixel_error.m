function [ret] = compute_pixel_error( prob, lbl )

	lbl = ~lbl;

	%% Best threshold
	%
	threshold = 0.039:0.01:0.999;
	prec = zeros(numel(threshold),1);
	rec = zeros(numel(threshold),1);
	pixelErr = zeros(numel(threshold),1);
	
	parfor i = 1:numel(threshold)

		th = threshold(i);
		fprintf('(%d/%d) threshold = %.3f...\n',i,numel(threshold),th);		
		
		nTp = 0;
		nFp = 0;
		nFn = 0;
		nErr = 0;
					
		bmap = prob < th;

		err = xor(bmap,lbl);
		tp = ~err & lbl;
		fp = err & ~lbl;
		fn = err & lbl;

		nTp = nnz(tp);
		nFn = nnz(fn);
		nFp = nnz(fp);
		nErr = nnz(err);

		prec(i) = nTp/(nTp + nFp);
		rec(i) = nTp/(nTp + nFn);
		pixelErr(i) = nErr/numel(lbl);

	end

	ret.prec = prec;
	ret.rec = rec;
	ret.pxlErr = pixelErr;
	ret.th = threshold;
	ret.fs = (2*prec.*rec)./(prec+rec);

end