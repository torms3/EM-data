function [train,test] = monitor_learning( fname )

	% Load train info
	sTrain = [fname '.train'];

	sInfo = [sTrain '.info'];
	fInfo = fopen(sInfo, 'r');
	train.n = fread(fInfo, 1, 'uint64');

	sIter = [sTrain '.iter'];
	fIter = fopen(sIter, 'r');
	train.iter = fread(fIter, train.n, 'uint64');

	sErr = [sTrain '.err'];
	fErr = fopen(sErr, 'r');
	train.err = fread(fErr, train.n, 'double');

	sCls = [sTrain '.cls'];
	fCls = fopen(sCls, 'r');
	train.cls = fread(fCls, train.n, 'double');

	% Load test info
	sTest = [fname '.test'];
	
	sInfo = [sTest '.info'];
	fInfo = fopen(sInfo, 'r');
	test.n = fread(fInfo, 1, 'uint64');

	sIter = [sTest '.iter'];
	fIter = fopen(sIter, 'r');
	test.iter = fread(fIter, test.n, 'uint64');

	sErr = [sTest '.err'];
	fErr = fopen(sErr, 'r');
	test.err = fread(fErr, test.n, 'double');

	sCls = [sTest '.cls'];
	fCls = fopen(sCls, 'r');
	test.cls = fread(fCls, test.n, 'double');

	% [kisuklee] TEMP
	idx = (train.iter == 0);
	train.iter(idx) = [];
	train.err(idx) = [];
	train.cls(idx) = [];
	idx = (test.iter == 0);
	test.iter(idx) = [];
	test.err(idx) = [];
	test.cls(idx) = [];

	% Plot cost
	figure;
	hold on;

		grid on;
		h1 = plot(train.iter, train.err, '-k');
		h2 = plot(test.iter, test.err, '-r');
		xlabel('iteration');
		ylabel('cost');
		title('cost');
		legend([h1 h2],'train','test');

	hold off;

	% Plot classification error
	figure;
	hold on;

		grid on;
		h1 = plot(train.iter, train.cls, '-k');
		h2 = plot(test.iter, test.cls, '-r');
		xlabel('iteration');
		ylabel('classification error');
		title('classification error');
		legend([h1 h2],'train','test');

	hold off;

end