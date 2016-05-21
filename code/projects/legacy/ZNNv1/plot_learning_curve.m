function [] = plot_learning_curve( data, errtype )
	
	if ~exist('errtype','var')
		errtype = 'err';
	end

	figure;	
	hold on;
	
	%% Train
	y 	= extractfield(data.train,errtype);
	h1 	= plot(data.train.iter, y, '-k');

	%% Test
	y 	= extractfield(data.test,errtype);
	h2 	= plot(data.test.iter, y, '-r');

	hold off;
	grid on;

	% x-axis label
	xlabel('Iteration');

	% y-axis label
	switch errtype
	case 'cls'
		ylabel('Classification error');
	otherwise
		ylabel(data.cost);
	end

	% title
	if isfield(data,'title')
		title(data.title);
	end

	% legend
	legend([h1 h2],'Train','Test');	

end