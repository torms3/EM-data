function [ret] = load_ISBI2012_data()

	load '/data/home/kisuklee/Workbench/seung-lab/EM-data/data/ISBI2012/ISBI_data.mat'


	%% train
	%
	image = data.train_images;
	label = data.train_labels;

	image = image - mean(image(:));
	image = image/std(image(:));
	label = double(label ~= 0);

	ret.train.image = image;
	ret.train.label = label;


	%% test
	%
	image = data.test_images;
	label = data.test_labels;

	image = image - mean(image(:));
	image = image/std(image(:));
	label = double(label ~= 0);

	ret.test.image = image;
	ret.test.label = label;

end