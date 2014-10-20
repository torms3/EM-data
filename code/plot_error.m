function plot_error( data, errname )

	if ~exist('errname','var')
		errname = 'Pixel error';
	end

	% best pixel error
	[~,idx] = sort(data.val,'ascend');
	bestIdx = idx(1);
	bestErr = data.val(bestIdx);
	maxErr = data.val(idx(end));

	% base threshold
	[~,baseIdx] = min(abs(data.thresh - 0.5));

	% plot
	figure();
	plot(data.thresh,data.val);
	axis([0 1 0 maxErr+0.1]);
	hold on;

		% best f-score
		circleSize = 80;
		x_loc = data.thresh(bestIdx);
		scatter(x_loc,data.val(bestIdx),circleSize,'ro','fill');

		% lines indicating the best f-score
		line([x_loc x_loc],[0 data.val(bestIdx)],'Color','r');
		line([0 x_loc],[data.val(bestIdx) data.val(bestIdx)],'Color','r');

	hold off;
	grid on;
	% daspect([1 1 1]);
	xlabel('Threshold');
	ylabel(errname);
	% legend('Varying threshold','Best f-score','Location','Best');
	title(sprintf('Best: %.4f (thresh = %.4f), Base: %.4f (thresh = %.4f) %', ...
		bestErr,data.thresh(bestIdx),data.val(baseIdx),0.5));

	fprintf('\n<<<<<<<<<< STATS >>>>>>>>>>\n');
	fprintf('Base error = %.4f @ %.1f\n',data.val(baseIdx),data.thresh(baseIdx));
	fprintf('Best error = %.4f @ %.1f\n',data.val(bestIdx),data.thresh(bestIdx));
	fprintf('<<<<<<<<<< STATS >>>>>>>>>>\n\n');

end