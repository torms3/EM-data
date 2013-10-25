function [err] = plot_train_error( fname, iters )

	%% Options
	%
	errType = 'RMSE'; % RMSE or MSE
	avgWindow = 10;
	logScale = false;
	trainOnly = false;


	%% Load
	%
	if( ~exist('iters','var') )
		[err,train_info] = load_train_error( fname );
		iters = train_info.iters;
	else
		[err,train_info] = load_train_error( fname, iters );
	end

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
		avgFilter = ones(w,1)/w;

		if( avgWindow > 0 )
			if( ~trainOnly )
				% testing moving average			
				x = train_info.test_freq*(1:nTest);
				h1 = plot(x(1:end-w+1), conv(err.test,avgFilter,'valid'),'-r');
			end

			% training moving average
			x = train_info.check_freq*(1:nTrain);
			h2 = plot(x(1:end-w+1),conv(err.train,avgFilter,'valid'),'-k');
		else
			if( ~trainOnly )
				% testing error
				x = train_info.test_freq*(1:nTest);
				h1 = plot(x, err.test,'-r');
			end

			% training error
			x = train_info.check_freq*(1:nTrain);
			h2 = plot(x, err.train,'-k');
		end

	hold off;

	xlabel('Updates');
	if( logScale )
		ylabel(['log(' errType ')']);
	else
		ylabel(errType);
	end
	grid on;
	if( trainOnly )
		legend([h2], 'Training error');
	else
		legend([h1 h2], 'Testing error', 'Training error');
	end
	title(['Iterations: ' num2str(iters)]);


end