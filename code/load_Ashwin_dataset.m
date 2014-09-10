homeDir = '/data/home/kisuklee';

% batch1: 7nm-IDSIA
disp('load 7nm-IDSIA as batch1...');
load([homeDir '/Workbench/seung-lab/EM-data/data/Ashwin/7nm-IDSIA.mat']);
batch1 = data;

% batch2: 7nm-512pxl
disp('load 7nm-512pxl as batch2...');
load([homeDir '/Workbench/seung-lab/EM-data/data/Ashwin/7nm-512pxl.mat']);
batch2 = data;

% batch3: 7nm-notTrained
disp('load 7nm-notTrained as batch3...');
load([homeDir '/Workbench/seung-lab/EM-data/data/Ashwin/7nm-notTrained.mat']);
batch3 = data;

clear data;
clear homeDir;