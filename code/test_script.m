
% dims = [3 3 3];
dims = size(data.image);
% data.image = double(ceil(10*rand(dims)));
% data.image = double(reshape(prod(dims):-1:1,dims));
% data.label = double(rand(dims)>0.5);
% data.mask = (rand(dims)>0.5);

fname = 'data_batch_1';
fimg = fopen([fname '.image'], 'w');
flbl = fopen([fname '.label'], 'w');
% fmsk = fopen([fname '.mask'], 'w');

fwrite(fimg, reshape(data.image,1,[]), 'double');
fwrite(flbl, reshape(data.label,1,[]), 'double');
% fwrite(fmsk, reshape(data.mask,1,[]), 'uint8');

% fname = '~/Workbench/seung-lab/znn/cpp/kisuk/experiments/hidden4__fmaps12/test_out';

% sTrain = [fname '.train_error'];
% sTest  = [fname '.test_error'];

% fTrain = fopen(sTrain, 'w');
% fTest  = fopen(sTest, 'w');

% err.train(1:8914) = [];
% fwrite(fTrain, err.train, 'double');

% err.test(1:4455) = [];
% fwrite(fTest, err.test, 'double');