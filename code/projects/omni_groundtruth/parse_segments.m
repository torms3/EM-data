function [ret] = parse_segments( fname )

    if ~exist('fname','var')
        fname = 'segments.txt';
    end

    % Open text file for reading.
    fid = fopen(fname,'r');

    % Read introduction lines.
    intro = textscan(fid,'%s',2,'Delimiter','\n');

    % Read segments info.
    C = textscan(fid,'%d,%d','Delimiter','\n');
    segIDs = C{1};
    status = C{2};

    % Return a list of valid segments.
    ret.segIDs = uint32(segIDs);
    ret.status = uint32(status);

end
