function compare_semantic( A, B )

    % Discrepancy map.
    idx = A.sem ~= B.sem;

    temp = A.seg;
    temp(~idx) = 0;
    [C,ia,ic] = unique(temp);
    for id = C
        disp(id);
    end

end
