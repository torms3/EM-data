function plot_2D_Rand_error( data )

	[srt,idx] = sort(data.re,'ascend');
	bestIdx   = idx(1);

	figure;
	plot(data.thresh,data.re);
	axis([0 1 0 1]);
	hold on;

		plot(data.thresh,data.prec);
		plot(data.thresh,data.rec);

		% best f-score
		circleSize = 80;
		x_loc = data.thresh(bestIdx);
		scatter(x_loc,data.re(bestIdx),circleSize,'ro','fill');

		% lines indicating the best f-score
		line([x_loc x_loc],[0 data.re(bestIdx)],'Color','r','LineStyle','--');
		line([0 x_loc],[data.re(bestIdx) data.re(bestIdx)],'Color','r','LineStyle','--');

	hold off;
	grid on;
	xlabel('Threshold');
	legend('Rand error','Precision','Recall');
	title(sprintf('Rand error = %.4f, Precision = %.4f, Recall = %.4f (thresh = %.3f)', ...
		  data.re(bestIdx),data.prec(bestIdx),data.rec(bestIdx),data.thresh(bestIdx)));

	fprintf('\n<<<<<<<<<<<  STATS  >>>>>>>>>>>\n');
	fprintf('Best RI f-score = %.4f @ %.1f\n',srt(1),data.thresh(idx(1)));
	fprintf('Precision       = %.4f @ %.1f\n',data.prec(idx(1)),data.thresh(idx(1)));
	fprintf('Recall          = %.4f @ %.1f\n',data.rec(idx(1)),data.thresh(idx(1)));
	fprintf('<<<<<<<<<<<  STATS  >>>>>>>>>>>\n\n');

end