addpath_recurse
dataDir = get_project_data_path();

% 7nmDeeper1
disp('load 7nmDeeper1...');
data{1} = double(loadtiff([dataDir '/Ashwin/7nmDeeper/7nm-415x415x577.tif']));

% 7nmDeeper2
disp('load 7nmDeeper2...');
data{2} = double(loadtiff([dataDir '/Ashwin/7nmDeeper/7nm-916x916x253.tif']));

clear dataDir;