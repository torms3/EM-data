template  = 'Piriform_sample%d_output';
samples   = [1 9 10];
[fpath,~] = exp_info;
for i = 1:numel(fpath)
    disp(fpath{i});
    cd(fpath{i});
    for j = 1:numel(samples)
        sample = samples(j);
        fname  = sprintf(template,sample);
        disp(fname);
        affs   = import_tensor(fname,[],'affin','single');
        affs   = affs2uniform(affs);
        export_tensor(fname,affs,'uaffin','single');
    end
end