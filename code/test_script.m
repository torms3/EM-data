
fname = '~/Workbench/seung-lab/znn/cpp/kisuk/experiments/hidden4__fmaps12/test_out';

sTrain = [fname '.train_error'];
sTest  = [fname '.test_error'];

fTrain = fopen(sTrain, 'w');
fTest  = fopen(sTest, 'w');

err.train(1:8914) = [];
fwrite(fTrain, err.train, 'double');

err.test(1:4455) = [];
fwrite(fTest, err.test, 'double');