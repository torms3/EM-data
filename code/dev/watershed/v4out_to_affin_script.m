function v4out_to_affin_script( fpath, prefix, samples )

    cur_pwd = pwd;
    for i = 1:numel(fpath)
        disp(fpath{i});
        cd(fpath{i});
        for j = 1:numel(samples)
            v4out_to_affin(prefix,samples(j));
        end
    end
    cd(cur_pwd);

end
