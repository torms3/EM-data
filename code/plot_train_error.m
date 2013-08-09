function [err] = plot_train_error( fname )

	%% Options
	%
	errType = 'RMSE'; % RMSE or MSE
	avgWindow = 50;
	logScale = false;


	%% Load
	%
	[err,train_info] = load_train_error( fname );

	if( strcmp(errType,'MSE') )
		err.train = err.train.^2;
		err.test  = err.test.^2;
	end
	if( logScale )
		err.train = log(err.train);
		err.test  = log(err.test);
	end

	nTrain = numel(err.train);
	nTest  = numel(err.test);


	%% Plot
	%
	figure;
	hold on;

		% convolution filter
		w = avgWindow;
		avg_filter = ones(w,1)/w;

		% testing error
		x = train_info.test_freq*(1:nTest);
		h1 = plot(x, err.test,'-r');

		% training error
		x = train_info.check_freq*(1:nTrain);
		h2 = plot(x, err.train,'-k');

	hold off;

	xlabel('Updates');
	if( logScale )
		ylabel(['log(' errType ')']);
	else
		ylabel(errType);
	end
	grid on;
	legend([h1 h2], 'Testing error', 'Training error');
	title(['Iterations: ' num2str(train_info.iters)]);


end