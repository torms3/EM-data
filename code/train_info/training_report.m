function [] = training_report( train_info, avgWindow )

	if ~exist('avgWindow','var')
		avgWindow = 0;
	end

	% Smoothing by averaging
	data.train = smooth_curve( train_info.train, avgWindow );
	data.test  = smooth_curve( train_info.test,  avgWindow );
	data.cost  = train_info.cost;

	% Draw plot
	data.title = ['Cost, smoothing window = ' num2str(avgWindow)];
	plot_learning_curve( data, 'err' );
	data.title = ['Classification error, smoothing window = ' num2str(avgWindow)];
	plot_learning_curve( data, 'cls' );

end