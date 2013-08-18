function [ret] = compute_affinity_error( out, G, mask )

	assert(iscell(out));
	assert(numel(out) == 3);
	
	% convert from affinity graph to boundary map
	affinity = cell(3,1);
	affinity{1} = ~logical(G.x);
	affinity{2} = ~logical(G.y);
	affinity{3} = ~logical(G.z);

	
	%% Best threshold
	%
	threshold = 0.009:0.01:0.999;
	prec = zeros(numel(threshold),1);
	rec = zeros(numel(threshold),1);
	pixelErr = zeros(numel(threshold),1);
	% for i = 1:numel(threshold)
	parfor i = 1:numel(threshold)

		th = threshold(i);
		fprintf('(%d/%d) threshold = %.3f...\n',i,numel(threshold),th);		
		
		nTp = 0;
		nFp = 0;
		nFn = 0;
		nErr = 0;
		for j = 1:numel(out)
			
			bmap = out{j} < th;

			err = xor(bmap,affinity{j}) & mask;
			tp = ~err & affinity{j} & mask;
			fp = err & ~affinity{j} & mask;
			fn = err & affinity{j} & mask;

			nTp = nTp + nnz(tp);
			nFn = nFn + nnz(fn);
			nFp = nFp + nnz(fp);
			nErr = nnz(err);
			
		end
		prec(i) = nTp/(nTp + nFp);
		rec(i) = nTp/(nTp + nFn);
		pixelErr(i) = nErr/(3*nnz(mask));

	end

	ret.prec = prec;
	ret.rec = rec;
	ret.pxlErr = pixelErr;
	ret.th = threshold;
	ret.fs = (2*prec.*rec)./(prec+rec);

end