function [] = export_segmentation( fname, volume, ext )

    % volume dimension
    fsz = fopen([fname '.size'], 'w');
    sz  = size(volume); 
    if ndims(sz) < 3
        sz = [sz 1];
    end
    fwrite(fsz, uint32(sz), 'uint32');

    % volume
    if exist('ext','var')       
        fvol = fopen([fname '.' ext], 'w');
    else
        fvol = fopen(fname, 'w');
    end     
    fwrite(fvol, uint32(volume), 'uint32');

end