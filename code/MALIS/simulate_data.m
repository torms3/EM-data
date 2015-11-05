function [lbl,bmap] = simulate_data( export )

    if ~exist('export','var'); export = false; end;

    % label
    lbl = ...
    [1 1 1 1 1 1 1 1 1 1; ... % row 1
     1 1 1 1 1 1 1 1 1 1; ... % row 2
     1 1 1 1 1 1 1 1 1 1; ... % row 3
     1 1 1 1 1 1 1 1 1 1; ... % row 4
     1 1 1 1 1 1 1 1 1 1; ... % row 5
     1 1 1 1 1 1 1 1 1 1; ... % row 6
     0 0 0 0 0 0 0 0 0 0; ... % row 7
     2 2 2 2 2 2 2 2 2 2; ... % row 8
     2 2 2 2 2 2 2 2 2 2; ... % row 9
     2 2 2 2 2 2 2 2 2 2; ... % row 10
    ];
    if export; export_volume('label.bin',lbl); end;

    % boundary map
    bmap = ...
    [ 1  1  1  1  1  1  1  1  1  1; ... % row 1
      1  1  1  1  1  1  1  1  1  1; ... % row 2
      1  1  1  1  1  1  1  1  1  1; ... % row 3
     .5 .5 .5 .2 .5 .5 .5 .8 .5 .5; ... % row 4
      1  1  1  1  1  1  1  1  1  1; ... % row 5
      1  1  1  1  1  1  1  1  1  1; ... % row 6
     .5 .5 .5 .2 .5 .5 .5 .8 .5 .5; ... % row 7
      1  1  1  1  1  1  1  1  1  1; ... % row 8
      1  1  1  1  1  1  1  1  1  1; ... % row 9
      1  1  1  1  1  1  1  1  1  1; ... % row 10
    ];
    if export; export_volume('boundary.bin',bmap); end;

end