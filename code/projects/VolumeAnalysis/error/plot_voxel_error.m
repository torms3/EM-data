function plot_voxel_error( data )

	[srt,idx] = sort(data.err,'ascend');
	bestIdx   = idx(1);

	figure;
	plot(data.thresh,data.err,data.thresh,data.prec,data.thresh,data.rec);
	axis([0 1 0 1]);
	hold on;

	% plot(data.thresh,data.prec);
	% plot(data.thresh,data.rec);

	% best f-score
	circleSize = 80;
	x_loc = data.thresh(bestIdx);
	scatter(x_loc,data.err(bestIdx),circleSize,'ro','fill');

	% lines indicating the best f-score
	line([x_loc x_loc],[0 data.err(bestIdx)],'Color','r','LineStyle','--');
	line([0 x_loc],[data.err(bestIdx) data.err(bestIdx)],'Color','r','LineStyle','--');

	hold off;
	grid on;
	xlabel('Threshold');
	legend('Voxel error','Precision','Recall');
	title(sprintf('Voxel error = %.4f, Precision = %.4f, Recall = %.4f (thresh = %.3f)', ...
		  data.err(bestIdx),data.prec(bestIdx),data.rec(bestIdx),data.thresh(bestIdx)));

	fprintf('\n<<<<<<<<<<<  STATS  >>>>>>>>>>>\n');
	fprintf('Best voxel error = %.4f @ %.1f\n',srt(1),data.thresh(bestIdx));
	fprintf('Precision        = %.4f @ %.1f\n',data.prec(bestIdx),data.thresh(bestIdx));
	fprintf('Recall           = %.4f @ %.1f\n',data.rec(bestIdx),data.thresh(bestIdx));
	fprintf('<<<<<<<<<<<  STATS  >>>>>>>>>>>\n\n');

	fprintf('%.4f\n',data.thresh(bestIdx));
	fprintf('%.4f\n',srt(1));
	fprintf('%.4f\n',data.prec(bestIdx));
	fprintf('%.4f\n',data.rec(bestIdx));

end