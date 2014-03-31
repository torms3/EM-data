function [] = plot_learning_curve( data_array )

	%% Argument validation
	%
	if ~iscell(data_array)
		data_array = {data_array};
	end

	%% Plot
	%
	figure;
	grid on;
	hold on;
	for i = 1:numel(data_array)

		data = data_array{i};
		if( i == 1 )
			plot(data.train.iter, data.train.err, 'Color', [.7 .7 .7]);
			plot(data.test.iter, data.test.err, 'Color', [.7 .7 .7]);
		else
			h1 = plot(data.train.iter, data.train.err, '-k');
			h2 = plot(data.test.iter, data.test.err, '-r');
		end

	end
	xlabel('iteration');
	ylabel(data.cost);
	% ylabel(['classification error']);
	title('cost');
	% title(['classification error']);
	legend([h1 h2],'train','test');
	hold off;

end