function [err,train_info] = load_train_error( fname )

	%% Load
	%
	sTrain = [fname '.train_error'];
	sTest  = [fname '.test_error'];	

	fTrain = fopen(sTrain, 'r');
	fTest  = fopen(sTest, 'r');	

	[train_info] = read_train_info( fname );
	nTrain = floor(train_info.iters/train_info.check_freq);
	nTest  = floor(train_info.iters/train_info.test_freq);

	% D = dir(sTrain);
	% nTrain = D.bytes/8;
	% D = dir(sTest);
	% nTest = D.bytes/8;

	err.train = fread(fTrain,nTrain,'double');
	err.test  = fread(fTest,nTest,'double');

end