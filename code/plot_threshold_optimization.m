function plot_threshold_optimization( err )

	% best pixel error
	[~,idx] = sort(err.pxlErr,'ascend');
	bestIdx = idx(1);
	bestPxlErr = err.pxlErr(bestIdx);
	maxPxlErr = err.pxlErr(idx(end));

	% base threshold
	[~,baseIdx] = min(abs(err.th - 0.5));

	% plot
	figure();
	plot(err.pxlErr);
	axis([0 numel(err.pxlErr) 0 maxPxlErr+0.1]);
	hold on;

		% best f-score
		circleSize = 80;
		scatter(bestIdx,err.pxlErr(bestIdx),circleSize,'ro','fill');

		% lines indicating the best f-score
		line([bestIdx bestIdx],[0 err.pxlErr(bestIdx)],'Color','r');
		line([0 bestIdx],[err.pxlErr(bestIdx) err.pxlErr(bestIdx)],'Color','r');

	hold off;
	grid on;
	% daspect([1 1 1]);
	xlabel('threshold (x 0.01)');
	ylabel('pixel error');
	% legend('Varying threshold','Best f-score','Location','Best');
	title(sprintf('Best: %.4f (th = %.4f), Base: %.4f (th = %.4f) %', ...
		bestPxlErr,err.th(bestIdx),err.pxlErr(baseIdx),0.5));

	fprintf('\n<<<<<<<<<< STATS >>>>>>>>>>\n');
	fprintf('Base pixel error = %.4f\n',err.pxlErr(baseIdx));
	fprintf('Best pixel error = %.4f\n',err.pxlErr(bestIdx));
	fprintf('<<<<<<<<<< STATS >>>>>>>>>>\n\n');

end