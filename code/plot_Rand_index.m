function [] = plot_Rand_index( data, th_min, th_max )

	if ~exist('th_min','var')
		th_min = 0;
	end
	if ~exist('th_max','var')
		th_max = 1000;
	end

	idx = (data.x >= th_min) & (data.x <= th_max);
	x = data.x(idx)/1000;
	y = data.y(idx);

	% best Rand index
	[sorted_y,idx] = sort(y,'ascend');
	best_idx = idx(1);
	best_err = sorted_y(1);
	best_th  = x(best_idx);

	ymin = max(0,best_err-0.1);

	% plot
	figure;
	hold on;

		plot(x,y);		% line
		plot(x,y,'k.');	% points

		v = axis;
		xmin = v(1);
		axis([v(1) v(2) ymin v(4)]);

		% best Rand index
		circleSize = 30;		
		scatter(best_th,best_err,circleSize,'ro','fill');

		% lines indicating the best f-score
		line([best_th best_th],[ymin best_err],'Color','r');
		line([xmin best_th],[best_err best_err],'Color','r');

	hold off;
	grid on;

	xlabel('Threshold');
	ylabel('Rand index');
	title(sprintf('Best Rand index: %.4f @ %.3f',best_err,best_th));

end