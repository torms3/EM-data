function [ret] = adapted_Rand_index_2D( proposed, data, filtrad )

	if ~exist('filtrad','var')
		filtrad = [];
	end

	% 4-connected neighborhood
	conn = 4;	

	% proposed boundary map
	if isstr(proposed)
		outIdx = 2;
		[prob,~] = generate_prob_map( proposed, outIdx );
	else
		[prob] = proposed;
	end
		
	if any(filtrad)
		stack = medfilt3( prob, filtrad );
	else
		stack = prob;
	end

	% ground truth
	segA = adjust_border_effect(single(data.label~=0),stack);
	segA = bwlabeln(segA,conn);

	% iterate over different thresholds
	thresholds = [0.1:0.1:0.9];
	nThresh = numel(thresholds);
	RI = zeros(1,nThresh);
	parfor i = 1:nThresh

		threshold = thresholds(i);
		fprintf('(%d/%d)... ',i,nThresh);

		segB = stack > threshold;
		segB = bwlabeln(segB,conn);
		RI(i) = SNEMI3D_metrics(segA,segB);

		fprintf('Rand index = %.4f @ %.1f\n',RI(i),threshold);

	end

	[srt,idx] = sort(RI,'ascend');
	fprintf('\n<<<<<<<<<<< STATS >>>>>>>>>>>\n');
	fprintf('Best RI f-score= %.4f @ %.1f\n',srt(1),thresholds(idx(1)));
	fprintf('<<<<<<<<<<< STATS >>>>>>>>>>>\n\n');

	ret.val = RI;
	ret.thresh = thresholds;

	plot_error( ret, '2D Rand error' );

end