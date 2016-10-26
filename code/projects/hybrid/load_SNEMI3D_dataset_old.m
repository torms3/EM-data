function [train,test] = load_SNEMI3D_dataset_old

    homeDir = get_project_root_path;

    % batch1: train
    disp('load SNEMI3D train...');
    load([homeDir '/data/SNEMI3D/train.mat']);
    train.gpath = '/data/home/kisuklee/Workbench/torms3/znn-release/dataset/SNEMI3D/data/batch1';

    % batch2: test
    disp('load SNEMI3D test...');
    load([homeDir '/data/SNEMI3D/test.mat']);
    test.gpath = '/data/home/kisuklee/Workbench/torms3/znn-release/dataset/SNEMI3D/data/batch2';

end
