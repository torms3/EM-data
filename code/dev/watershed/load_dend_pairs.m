function pairs = load_dend_pairs( fname )

    fpairs = fopen(fname,'r');
    finfo  = dir(fname);
    fsize  = finfo.bytes;
    pairs  = fread(fpairs,fsize/4,'single');
    % pairs  = reshape(pairs,2,[])';

    fclose(fpairs);

end