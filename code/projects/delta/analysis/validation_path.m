function [vpath] = validation_path( fpath, iters, subdir )

    vpath = {};

    cur = pwd;
    for i = 1:numel(fpath)
        for j = 1:numel(iters)
            for k = 1:numel(subdir)
                cd(fpath{i});
                cd(['iter_' num2str(iters(j))]);
                cd(subdir{j});
                vpath{end+1} = pwd;
            end
        end
    end
    cd(cur);

end
