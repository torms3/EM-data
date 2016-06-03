function [root] = get_workbench_root_path()

    cur = pwd;
    cd('~/Workbench_local/');
    root = pwd;
    cd(cur);

end