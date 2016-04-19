function mt = load_omni_MST( fname )

    fid = fopen(fname,'r');
    header = fgets(fid);
    C = textscan(fid,'%d,%d,%d,%f,%d,%d,%d,%d');
    fclose(fid);

    mt.vals  = double(C{4});
    mt.pairs = uint32(reshape([C{2} C{3}]',[],1));

end