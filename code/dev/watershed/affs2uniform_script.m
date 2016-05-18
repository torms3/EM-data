function affs2uniform_script( fpath, prefix, samples )

    template = [prefix '_sample%d_output'];
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

end