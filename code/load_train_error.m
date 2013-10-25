function [err,train_info] = load_train_error( fname, iters )

	%% Load
	%
	sTrain = [fname '.train_error'];
	sTest  = [fname '.test_error'];	

	fTrain = fopen(sTrain, 'r');
	fTest  = fopen(sTest, 'r');	

	[train_info] = read_train_info( fname );
	if( ~exist('iters','var') )
		iters = train_info.iters;
	end
	nTrain = floor(iters/train_info.check_freq);
	nTest  = floor(iters/train_info.test_freq);

	% D = dir(sTrain);
	% nTrain = D.bytes/8;
	% D = dir(sTest);
	% nTest = D.bytes/8;

	if( fTrain > 0 )
		err.train = fread(fTrain,nTrain,'double');
	else
		err.train = 0;
	end
	if( fTest > 0 )
		err.test  = fread(fTest,nTest,'double');
	else
		err.test = 0;
	end

end