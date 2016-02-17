function [root] = get_workbench_root_path()

    cur = pwd;
    cd('~/Workbench/');
    root = pwd;
    cd(cur);

end