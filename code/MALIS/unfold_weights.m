function unfolded = unfold_weights( mw, sw, ws )

    nsnapshots  = numel(ws.snaptime);

    % time-unfolded merger & splitter weights
    unfolded.mw = [];
    unfolded.sw = [];

    for i = 1:nsnapshots

        idx = ws.timestamp > ws.snaptime(i);

        % current
        cmw = mw; cmw(idx) = 0;
        csw = sw; csw(idx) = 0;

        unfolded.mw = cat(5,unfolded.mw,cmw);
        unfolded.sw = cat(5,unfolded.sw,csw);

    end

end