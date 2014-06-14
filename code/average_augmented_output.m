function [ret] = average_augmented_output( fname, indices )

	outIdx = 2;
	filtrad = 5;

	avg = {};
	prob = {};
	accum = {};
	for i = 1:numel(indices)
		fprintf('(%d/%d) is now being processed...\n',i,numel(indices));
		idx = indices(i);
		sname = [fname num2str(idx)];
		[img] = import_multivolume( sname );		
		[prob{i},~] = generate_prob_map( img, outIdx, filtrad );
		[rprob] = revert_image( prob{i}, idx );
		if ~exist('prob_sum','var')
			prob_sum = rprob;
		else
			prob_sum = prob_sum + rprob;
		end
		avg{i} = medfilt3( prob_sum/i, filtrad );
		accum{i} = prob_sum;
	end

	ret.avg = avg;
	ret.prob = prob;
	ret.accum = accum;

end