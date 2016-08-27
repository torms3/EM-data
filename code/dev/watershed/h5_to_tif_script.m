function h5_to_tif_script( fpath, template, samples )

    cur_pwd = pwd;
    for i = 1:numel(fpath)
        disp(fpath{i});
        cd(fpath{i});
        for j = 1:numel(samples)
            h5_to_tif(sprintf(template,samples(j)));
        end
    end
    cd(cur_pwd);

end
