function [aff] = reverse_augmented_affinity( aff, aug )

    % no augmentation
    if aug == 0
        return;
    end

    % add 15 to ensure 4-bit code
    code = de2bi([aug 15]);
    code = code(1,:);

    % 1. original augmentation order is reversed
    % 2. x/y-reflection order is swapped (tif transpose)

    % transpose in xy
    % swap x/y affinity
    if code(1)
        aff = permute(aff,[2 1 3 4]);
        aff(:,:,:,[1 2]) = aff(:,:,:,[2 1]);
    end

    % y-reflection
    if code(2)
        aff = flip(aff,2);
    end

    % x-reflection
    if code(3)
        aff = flip(aff,1);
    end

    % z-reflection
    if code(4)
        aff = flip(aff,3);
        % special treatment for z-affinity
        aff(:,:,2:end,3) = aff(:,:,1:end-1,3);
        aff(:,:,1,3) = zeros([size(aff,1) size(aff,2)]);
    end

end