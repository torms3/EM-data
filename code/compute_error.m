function [ret] = compute_error( out, G, mask )

	assert(isequal(size(out),size(G)));
	G = ~logical(G);


	%% Best threshold
	%
	threshold = 0.01:0.01:0.99;
	prec = zeros(numel(threshold),1);
	rec = zeros(numel(threshold),1);
	pixelErr = zeros(numel(threshold),1);
	for i = 1:numel(threshold)

		fprintf('(%d/%d)...\n',i,numel(threshold));

		th = threshold(i);
		bmap = out < th;

		err = xor(bmap,G) & mask;
		tp = ~err & G & mask;
		fp = err & ~G & mask;
		fn = err & G & mask;

		prec(i) = nnz(tp)/(nnz(tp) + nnz(fp));
		rec(i) = nnz(tp)/(nnz(tp) + nnz(fn));
		pixelErr(i) = nnz(err)/nnz(mask);

	end

	ret.prec = prec;
	ret.rec = rec;
	ret.pxlErr = pixelErr;
	ret.th = threshold;
	ret.fs = (2*prec.*rec)./(prec+rec);

end