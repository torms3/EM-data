addpath_recurse
homeDir = get_project_root_path();

% 7nmDeeper1
disp('load 7nmDeeper1...');
data{1} = double(loadtiff('7nm-415x415x577.tif'));

% 7nmDeeper2
disp('load 7nmDeeper2...');
data{2} = double(loadtiff('7nm-916x916x253.tif'));

clear homeDir;