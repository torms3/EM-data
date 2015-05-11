function malis_prec_rec_curve( batch )

    dims = {[225 225 225],[225 225 225],[225 225 225],[], ...
            [240 240 240],[240 240 240],[240 240 240], ...
            [240 240 240],[240 240 240],[240 240 240], ...
            [240 240 240],[240 240 240], ...
            [256 256 256],[256 256 256]};
    FoV    = [37 37 37];
    offset = floor(FoV/2) + [1 1 1];
    ox     = offset(1);oy = offset(2);oz = offset(3);
    sz     = dims{batch} - FoV + [1 1 1];

    header = '~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/';
    tail   = sprintf('.x%d_y%d_z%d_dim%dx%dx%d.mat',ox,oy,oz,sz(1),sz(2),sz(3));

    % index
    idx = 1;

    % colormap
    color = colormap(lines);

    % % SriniNet-v2 Standard 0.5M
    % S{idx}.path  = [header 'exp8/iter_500K/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 Standard 0.5M';
    % S{idx}.line  = ':k';
    % % S{idx}.color = color(idx,:);
    % idx = idx + 1;

    % % SriniNet-v2 Standard 1M
    % S{idx}.path  = [header 'exp8/iter_1M/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 Standard 1M';
    % S{idx}.line  = '-.k';
    % % S{idx}.color = color(idx,:);
    % idx = idx + 1;

    % % SriniNet-v2 Standard 1.5M
    % S{idx}.path  = [header 'exp8/iter_1.5M/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 Standard 1.5M';
    % S{idx}.line  = '--k';
    % % S{idx}.color = color(idx,:);
    % idx = idx + 1;

    % % SriniNet-v2 Standard 2M
    % S{idx}.path  = [header 'exp8/iter_2M/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 Standard 2M';
    % S{idx}.line  = '-k';
    % % S{idx}.color = color(idx,:);
    % idx = idx + 1;

    % % SriniNet-v2 MALIS 0.5M (eta = 0.001)
    % S{idx}.path  = [header 'exp8/iter_500K/malis/exp1/iter_500K/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 MALIS 0.5M (eta = 0.001)';
    % S{idx}.line  = ':r';
    % idx = idx + 1;

    % % SriniNet-v2 MALIS 1.0M (eta = 0.001)
    % S{idx}.path  = [header 'exp8/iter_500K/malis/exp1/iter_1M/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 MALIS 1.0M (eta = 0.001)';
    % S{idx}.line  = '--r';
    % idx = idx + 1;

    % % SriniNet-v2 MALIS 1.5M (eta = 0.001)
    % S{idx}.path  = [header 'exp8/iter_500K/malis/exp1/iter_1.5M/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 MALIS 1.5M (eta = 0.001)';
    % S{idx}.line  = '-r';
    % idx = idx + 1;

    % % SriniNet-v2 MALIS 0.5M (eta = 0.01)
    % S{idx}.path  = [header 'exp8/iter_500K/malis/exp2/iter_500K/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 MALIS 0.5M (eta = 0.01)';
    % S{idx}.line  = ':r';
    % idx = idx + 1;

    % % SriniNet-v2 MALIS 1.0M (eta = 0.01)
    % S{idx}.path  = [header 'exp8/iter_500K/malis/exp2/iter_1M/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 MALIS 1.0M (eta = 0.01)';
    % S{idx}.line  = '--r';
    % idx = idx + 1;

    % % SriniNet-v2 MALIS 1.5M (eta = 0.01)
    % S{idx}.path  = [header 'exp8/iter_500K/malis/exp2/iter_1.5M/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 MALIS 1.5M (eta = 0.01)';
    % S{idx}.line  = '-r';
    % idx = idx + 1;

    % % SriniNet-v2 MALIS 0.5M (eta = 0.1)
    % S{idx}.path  = [header 'exp8/iter_500K/malis/exp3/iter_500K/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 MALIS 0.5M (eta = 0.1)';
    % S{idx}.line  = ':r';
    % idx = idx + 1;

    % % SriniNet-v2 MALIS 1.0M (eta = 0.1)
    % S{idx}.path  = [header 'exp8/iter_500K/malis/exp3/iter_1M/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 MALIS 1.0M (eta = 0.1)';
    % S{idx}.line  = '-.r';
    % idx = idx + 1;

    % % SriniNet-v2 MALIS 1.5M (eta = 0.1)
    % S{idx}.path  = [header 'exp8/iter_500K/malis/exp3/iter_1.5M/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 MALIS 1.5M (eta = 0.1)';
    % S{idx}.line  = '-r';
    % idx = idx + 1;

    % % SriniNet-v2 MALIS 0.5M (eta = 1)
    % S{idx}.path  = [header 'exp8/iter_500K/malis/exp4/iter_500K/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 MALIS 0.5M (eta = 1)';
    % S{idx}.line  = ':r';
    % idx = idx + 1;

    % % SriniNet-v2 MALIS 1.0M (eta = 1)
    % S{idx}.path  = [header 'exp8/iter_500K/malis/exp4/iter_1M/output/'];
    % S{idx}.fname = ['out' num2str(batch) tail];
    % S{idx}.lgnd  = 'SriniNet-v2 MALIS 1.0M (eta = 1)';
    % S{idx}.line  = '-r';
    % idx = idx + 1;

    % EyeWire    
    S{idx}.path  = '~/Workbench/torms3/znn-release/experiments/e2198_e2006/MALIS/output/original/';
    S{idx}.fname = ['out' num2str(batch) tail];
    S{idx}.lgnd  = 'EyeWire';
    S{idx}.line  = '-b';
    idx = idx + 1;

    % EyeWire 2
    S{idx}.path  = '~/Workbench/torms3/znn-release/experiments/e2198_e2006/MALIS/output/';
    S{idx}.fname = ['out' num2str(batch) tail];
    S{idx}.lgnd  = 'EyeWire 2';
    S{idx}.line  = '-r';
    idx = idx + 1;

    figure;
    hold on;
    for i = 1:numel(S)
        spec = S{i};
        load([spec.path spec.fname]);
        data = result.xyz;
        h(i) = plot(data.rec,data.prec,spec.line);
        if isfield(spec,'color')
            set(h(i),'Color',spec.color);
        end
        lgnd{i} = spec.lgnd;
    end
    hold off;
    grid on;
    % xlim([0.5 1]);ylim([0.5 1]);
    FontSize = 12;    
    xlabel('Recall','FontSize',FontSize);
    ylabel('Precision','FontSize',FontSize);
    title(['Batch' num2str(batch) ' 3D Rand error (Connected Component)'], ...
           'FontSize',FontSize);
    legend(h,lgnd,'Location','Best');

end