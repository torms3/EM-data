function [mov] = play_time_evolution( fname, export )

    assert(exist(fname,'file')>0);

    tensor = import_tensor(fname, [], [], 'uint64');

    % random color map
    nseg = max(unique(tensor(:)));
    clrmap = rand(nseg+1,3);

    % index to RGB
    nframe = size(tensor,4);
    for f = 1:nframe
        RGB(:,:,:,f) = ind2rgb(tensor(:,:,:,f),clrmap);
    end

    % generate & play Matlab movie
    mov = immovie(RGB);
    implay(mov);

    % export, if specified
    if export
        movie2avi(mov,[fname '.avi'],'fps',30,'quality',100);
    end

end