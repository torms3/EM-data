homeDir = get_project_root_path();

% batch1: 7nm-IDSIA
disp('load 7nm-IDSIA as batch1...');
load([homeDir '/data/Ashwin/7nm-IDSIA.mat']);
batch1 = data;

% batch2: 7nm-512pxl
disp('load 7nm-512pxl as batch2...');
load([homeDir '/data/Ashwin/7nm-512pxl.mat']);
batch2 = data;

% batch3: 7nm-notTrained
disp('load 7nm-notTrained as batch3...');
load([homeDir '/data/Ashwin/7nm-notTrained.mat']);
batch3 = data;

% batch4: 10nm-IDSIA
disp('load 10nm-IDSIA as batch4...');
load([homeDir '/data/Ashwin/10nm-IDSIA.mat']);
batch4 = data;

clear data;
clear homeDir;