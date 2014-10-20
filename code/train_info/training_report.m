function [] = training_report( data, avgWindow )

	if ~exist('avgWindow','var')
		avgWindow = 0;
	end

	% Smoothing by averaging
	data.train = smooth_curve( data.train, avgWindow );
	data.test  = smooth_curve( data.test,  avgWindow );
	data.cost  = train.cost;

	% Draw plot
	data.title = ['Cost, smoothing window = ' num2str(avgWindow)];
	plot_learning_curve( data, 'err' );
	data.title = ['Classification error, smoothing window = ' num2str(avgWindow)];
	plot_learning_curve( data, 'cls' );

end