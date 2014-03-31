function plot_threshold_optimization( err, fscore )

	% whether using (1 - maximum F-score) as pixel error
	if ~exist('fscore','var')
		fscore = false;
	end

	if( fscore )
		pxlErr = err.maxF;
	else
		pxlErr = err.pxlErr;
	end

	% best pixel error
	[~,idx] = sort(err.pxlErr,'ascend');
	bestIdx = idx(1);
	bestPxlErr = err.pxlErr(bestIdx);
	maxPxlErr = err.pxlErr(idx(end));

	% base threshold
	[~,baseIdx] = min(abs(err.thresh - 0.5));

	% plot
	figure();
	plot(err.thresh,err.pxlErr);
	axis([0 1 0 maxPxlErr+0.1]);
	hold on;

		% best f-score
		circleSize = 80;
		x_loc = err.thresh(bestIdx);
		scatter(x_loc,err.pxlErr(bestIdx),circleSize,'ro','fill');

		% lines indicating the best f-score
		line([x_loc x_loc],[0 err.pxlErr(bestIdx)],'Color','r');
		line([0 x_loc],[err.pxlErr(bestIdx) err.pxlErr(bestIdx)],'Color','r');

	hold off;
	grid on;
	% daspect([1 1 1]);
	xlabel('threshold');
	ylabel('pixel error');
	% legend('Varying threshold','Best f-score','Location','Best');
	title(sprintf('Best: %.4f (thresh = %.4f), Base: %.4f (thresh = %.4f) %', ...
		bestPxlErr,err.thresh(bestIdx),err.pxlErr(baseIdx),0.5));

	fprintf('\n<<<<<<<<<< STATS >>>>>>>>>>\n');
	fprintf('Base pixel error = %.4f\n',err.pxlErr(baseIdx));
	fprintf('Best pixel error = %.4f\n',err.pxlErr(bestIdx));
	fprintf('<<<<<<<<<< STATS >>>>>>>>>>\n\n');

end