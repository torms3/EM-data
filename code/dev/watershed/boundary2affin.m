function boundary2affin( prefix, sample )

    % e.g. fname = 'Piriform_sample1_output'
    fname = [prefix '_sample' num2str(sample) '_output'];
    disp(['Processing ' fname '...']);

    img = loadtiff([fname '_0.tif']);
    aff = cat(4,img,img,zeros(size(img)));
    export_tensor(fname,aff,'affin','single');
    hdf5write([fname '.h5'],'/main',aff);

    uimg = affs2uniform(img);
    uaff = cat(4,uimg,uimg,zeros(size(uimg)));
    export_tensor(fname,uaff,'uaffin','single');
    hdf5write([fname '_u.h5'],'/main',uaff);

end