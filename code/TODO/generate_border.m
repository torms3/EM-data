function [label] = generate_border( stack, r, oname, nthread )

    % Maximum number of threads is 8.
    nthread = min(nthread, 8);

    % Paralle pool open.
    parpool(nthread);

    label = zeros(size(stack));
    [X,Y,Z] = size(stack);
    parfor z = 1:Z

        slice = stack(:,:,z)

        for x = 1:X
            for y = 1:Y
                if slice(x,y) > 0
                    patch = slice(max(x-r,1):min(x+r,X),max(y-r,1):min(y+r,Y));
                    if numel(setdiff(unique(patch), 0)) > 1
                        slice(x,y) = 0;
                    end
                end
            end
        end

        label(:,:,z) = slice;
        fprintf( 'Processed slice %d...\n', z );
    end

    save(oname, 'label');

    % Paralle pool close.
    parpool close;

end
