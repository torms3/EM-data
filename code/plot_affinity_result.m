function plot_affinity_result( ret )

	% best f-score
	[fs_srted,idx] = sort(ret.fs,'descend');
	bestIdx = idx(1);
	if( (bestIdx == 1) | (bestIdx == numel(idx)) )
		bestIdx = idx(2);
	end
	bestFs = ret.fs(bestIdx);

	% plot
	figure();
	scatter(ret.rec,ret.prec,'*');
	axis([0 1 0 1]);
	hold on;

		% best f-score
		circleSize = 80;
		scatter(ret.rec(bestIdx),ret.prec(bestIdx),circleSize,'ro','fill');

		% lines indicating the best f-score
		line([ret.rec(bestIdx) ret.rec(bestIdx)],[0 ret.prec(bestIdx)],'Color','r');
		line([0 ret.rec(bestIdx)],[ret.prec(bestIdx) ret.prec(bestIdx)],'Color','r');

	hold off;
	grid on;
	daspect([1 1 1]);
	xlabel('Recall');
	ylabel('Precision');
	legend('Varying threshold','Best f-score','Location','Best');

	fprintf('Best f-score = %4f\n',bestFs);
	fprintf('Recall @ best f-score = %4f\n',ret.rec(bestIdx));
	fprintf('Precision @ best f-score = %4f\n',ret.prec(bestIdx));
	fprintf('Pixel error @ best f-score = %4f\n',ret.pxlErr(bestIdx));

end