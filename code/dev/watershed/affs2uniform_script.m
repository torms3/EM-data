function affs2uniform_script( fpath, template, samples )

    for i = 1:numel(fpath)
        disp(fpath{i});
        cd(fpath{i});
        for j = 1:numel(samples)
            sample = samples(j);
            fname  = sprintf(template,sample);
            disp(fname);
            aff = import_tensor(fname,[],'affin','single');
            aff = affs2uniform(aff);
            export_tensor(fname,aff,'uaffin','single');
            hdf5write([fname '_u.h5'],'/main',single(aff));
        end
    end

end
