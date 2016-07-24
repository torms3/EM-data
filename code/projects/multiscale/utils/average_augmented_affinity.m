function [avg] = average_augmented_affinity( prefix, sample, aug_range )

    % e.g. base = 'Piriform_sample1_output'
    base = [prefix '_sample' num2str(sample) '_output'];

    avg = [];

    for aug = aug_range

        if aug > 0
            postfix = ['_aug' num2str(aug)];
        else
            postfix = '';
        end

        affs{1} = loadtiff([base '_1' postfix '.tif']);
        affs{2} = loadtiff([base '_2' postfix '.tif']);
        affs{3} = loadtiff([base '_0' postfix '.tif']);
        aff = cat(4,affs{:});
        aff = reverse_augmented_affinity(aff,aug);

        if isempty(avg)
            avg = aff;
        else
            avg = avg + aff;
        end

    end

    avg = avg ./ numel(aug_range);

end