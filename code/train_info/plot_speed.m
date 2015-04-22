function plot_speed( data, from, titlestr )

	if ~iscell(data)
		data = {data};
	end

	if ~exist('from','var')
		from = 1;
	end

	if ~exist('titlestr','var')
		titlestr = '';
	end

	fontsize = get(0,'DefaultAxesFontSize');
	set(0,'DefaultAxesFontSize',12);

	figure;
	hold on;
	for i = 1:numel(data)
		n = data{i}.n;
		plot(data{i}.iter(from:n),data{i}.speed(from:n));
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