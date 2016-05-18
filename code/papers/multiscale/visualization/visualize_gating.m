function visualize_gating( fmaps )

    scale = 3;

    lname = sprintf('npool%d',scale);
    M{1}  = squeeze(fmaps(lname));

    lname = sprintf('npool%d-r',scale);
    M{2}  = squeeze(fmaps(lname));

    lname = sprintf('nfeedback-p%d',scale);
    M{3}  = squeeze(fmaps(lname));

    lname = sprintf('ngated-p%d',scale);
    M{4}  = squeeze(fmaps(lname));

    cellplay(M);

end