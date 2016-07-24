function boundary2affin_script( fpath, prefix, sample )

    cur_pwd = pwd;
    for i = 1:numel(fpath)
        disp(fpath{i});
        cd(fpath{i});
        for j = 1:numel(sample)
            boundary2affin(prefix,sample(j));
        end
    end
    cd(cur_pwd);

end