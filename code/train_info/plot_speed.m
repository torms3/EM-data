function plot_speed( data, titlestr )

	fontsize = get(0,'DefaultAxesFontSize');
	set(0,'DefaultAxesFontSize',12);

	figure;
	hold on;
	for i = 1:numel(data)
		plot(data{i}.iter,data{i}.speed);
		lgnd{i} = data{i}.str;
	end
	hold off;

	legend(lgnd,'Location','Best');
	xlabel('Iteration');
	ylabel('Speed (update/sec)');
	title(titlestr);
	grid on;

	% revert default font size
	set(0,'DefaultAxesFontSize',fontsize);

end