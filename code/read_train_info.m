function [train_info] = read_train_info( fname )

	sInfo  = [fname '.info'];
	fInfo  = fopen(sInfo, 'r');

	train_info.iters = fread(fInfo, 1, 'uint64');
	train_info.check_freq = fread(fInfo, 1, 'uint64');
	train_info.test_freq = fread(fInfo, 1, 'uint64');
	train_info.test_samples = fread(fInfo, 1, 'uint64');

end