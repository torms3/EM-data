function ret = load_Ashwin_dataset

    homeDir = get_project_root_path();

    nbatch = 1;

    % batch1: 7nm-IDSIA
    disp('load 7nm-IDSIA as batch1...');
    load([homeDir '/data/Ashwin/7nm-IDSIA.mat']);
    ret{nbatch} = data;
    nbatch = nbatch + 1;

    % batch2: 7nm-512pix
    disp('load 7nm-512pix as batch2...');
    load([homeDir '/data/Ashwin/7nm-512pix.mat']);
    ret{nbatch} = data;
    nbatch = nbatch + 1;

    % batch3: 7nm-notTrained
    disp('load 7nm-notTrained as batch3...');
    load([homeDir '/data/Ashwin/7nm-notTrained.mat']);
    ret{nbatch} = data;
    nbatch = nbatch + 1;

    % batch4: 10nm-IDSIA
    disp('load 10nm-IDSIA as batch4...');
    load([homeDir '/data/Ashwin/10nm-IDSIA.mat']);
    ret{nbatch} = data;
    nbatch = nbatch + 1;

end