for i = 1:10

    fname = ['stack' num2str(i) '-label'];
    lbl = loadtiff([fname '.tif']);
    export_volume(fname, double(lbl), 'bin');

end