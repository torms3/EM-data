function vals = load_dend_values( fname )

    fvals = fopen(fname,'r');
    finfo = dir(fname);
    fsize = finfo.bytes;
    vals  = fread(fvals,fsize/4,'single');

    fclose(fvals);

end