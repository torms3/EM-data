function [train,test] = load_SNEMI3D_dataset

    homeDir = get_project_root_path;

    % batch1: train
    disp('load SNEMI3D train...');
    load([homeDir '/data/SNEMI3D/train.mat']);

    % batch2: test
    disp('load SNEMI3D test...');
    load([homeDir '/data/SNEMI3D/test.mat']);

end