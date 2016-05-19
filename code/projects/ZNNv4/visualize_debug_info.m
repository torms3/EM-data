function visualize_debug_info( prefix )

    s = load_debug_info(prefix);
    volplay(s.in,{1-s.xaff});

    function sample = load_debug_info( prefix )

        sample.in   = loadtiff([prefix 'input0.tif']);
        sample.zaff = loadtiff([prefix 'output0.tif']);
        sample.yaff = loadtiff([prefix 'output1.tif']);
        sample.xaff = loadtiff([prefix 'output2.tif']);

        % crop
        fov       = [37 37 37];
        offset    = floor(fov/2)+1;
        outsz     = size(sample.xaff);
        sample.in = crop_volume(sample.in, offset, outsz);

    end

end