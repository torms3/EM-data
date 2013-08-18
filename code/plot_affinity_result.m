function plot_affinity_result( ret )

	% best f-score
	[fs_srted,idx] = sort(ret.fs,'descend');
	bestIdx = idx(1);
	if( (bestIdx == 1) | (bestIdx == numel(idx)) )
		bestIdx = idx(2);
	end
	bestFs = ret.fs(bestIdx);

	% extreme
	minPrec = min(ret.prec);
	minRec  = min(ret.rec);

	% plot
	figure();
	scatter(ret.rec,ret.prec,'*');
	axis([minRec 1 minPrec 1]);
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
	title(sprintf('Best f-score: %.4f, precision: %.4f, recall: %.4f, pixel error: %.4f',bestFs,ret.prec(bestIdx),ret.rec(bestIdx),ret.pxlErr(bestIdx)));

	fprintf('\n<<<<<<<<<< STATS >>>>>>>>>>\n');
	fprintf('Best f-score \t= %.4f\n',bestFs);
	fprintf('Recall \t\t= %.4f\n',ret.rec(bestIdx));
	fprintf('Precision \t= %.4f\n',ret.prec(bestIdx));
	fprintf('Pixel error \t= %.4f\n',ret.pxlErr(bestIdx));
	fprintf('<<<<<<<<<< STATS >>>>>>>>>>\n');

end