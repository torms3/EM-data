function [ret] = adapted_Rand_index_2D( fname, data )

	% 4-connected neighborhood
	conn = 4;	

	% proposed boundary map
	stack = loadtiff(fname);
	stack = scaledata(single(stack),0,1);

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

	ret.RI = RI;

end