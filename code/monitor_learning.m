function [data] = monitor_learning( cost_type, avgWindow, start_iter  )

	%% Options
	%
	if ~exist('cost_type','var')
		cost_type = 'RMSE';
	end	
	if ~exist('avgWindow','var')
		avgWindow = 0;
	end
	if ~exist('start_iter','var')
		start_iter = [1 1];
	end

	% Load train info
	% [train] = load_info( [fname '.train'] );
	[train] = load_info( ['train'] );

	% Load test info
	% [test] = load_info( [fname '.test'] );
	[test] = load_info( ['test'] );

	% [kisuklee] TEMP
	idx = (train.iter == 0);
	train.iter(idx) = [];
	train.err(idx) 	= [];
	train.cls(idx) 	= [];
	idx = (test.iter == 0);
	test.iter(idx) 	= [];
	test.err(idx) 	= [];
	test.cls(idx) 	= [];

	if strcmp(cost_type,'RMSE')
		train.err = sqrt(train.err);
		test.err = sqrt(test.err);
	end

	% windowing
	train.iter 	= train.iter(start_iter(1):end);
	train.err 	= train.err(start_iter(1):end);
	train.cls 	= train.cls(start_iter(1):end);
	train.n 	= numel(train.iter);
	test.iter 	= test.iter(start_iter(2):end);
	test.err 	= test.err(start_iter(2):end);
	test.cls 	= test.cls(start_iter(2):end);
	test.n 		= numel(test.iter);

	% convolution filter
	[train] = smooth_curve( train, avgWindow );
	[test] 	= smooth_curve( test, avgWindow );
	if( avgWindow > 0 )
		avgStr = [', smoothing window = ' num2str(avgWindow)];
	else
		avgStr = '';
	end

	% return data
	data.train = train;
	data.test = test;
	data.cost = cost_type;

	% Plot cost
	figure;
	hold on;
	grid on;

		h1 = plot(train.iter, train.err, '-k');
		h2 = plot(test.iter, test.err, '-r');
					
		% axis([0 max(train.iter) 0 max(train.err)]);
		xlabel('iteration');
		ylabel(cost_type);
		title(['cost' avgStr]);
		legend([h1 h2],'train','test');

	hold off;

	% Plot classification error
	figure;
	hold on;
	grid on;

		h1 = plot(train.iter, train.cls, '-k');
		h2 = plot(test.iter, test.cls, '-r');

		% axis([0 max(train.iter) 0 max(train.err)]);
		xlabel('iteration');
		ylabel('classification error');
		title(['classification error' avgStr]);
		legend([h1 h2],'train','test');

	hold off;

end

function [ret] = load_info( fname )

	sInfo = [fname '.info'];
	fInfo = fopen(sInfo, 'r');
	ret.n = fread(fInfo, 1, 'uint64');

	sIter = [fname '.iter'];
	fIter = fopen(sIter, 'r');
	ret.iter = fread(fIter, ret.n, 'uint64');

	sErr = [fname '.err'];
	fErr = fopen(sErr, 'r');
	ret.err = fread(fErr, ret.n, 'double');

	sCls = [fname '.cls'];
	fCls = fopen(sCls, 'r');
	ret.cls = fread(fCls, ret.n, 'double');

end


function [data] = smooth_curve( data, w )

	if( w > 0 )

		% smoothing(convolution) filter
		hw = floor(w/2);
		avgFilter = ones(w,1)/w;

		% smoothing
		data.iter = data.iter(1+hw:end-hw);
		data.err  = conv(data.err, avgFilter, 'valid');
		data.cls  = conv(data.cls, avgFilter, 'valid');

		minVal = min([numel(data.iter) ... 
					  numel(data.err)  ...
					  numel(data.cls)]);
		data.iter = data.iter(1:minVal);
		data.err  = data.err(1:minVal);
		data.cls  = data.cls(1:minVal);
	end

end