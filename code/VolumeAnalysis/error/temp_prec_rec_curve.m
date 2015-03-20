function temp_prec_rec_curve(batch)

    dims = {[225 225 225],[225 225 225],[225 225 225],[], ...
            [240 240 240],[240 240 240],[240 240 240], ...
            [240 240 240],[240 240 240],[240 240 240], ...
            [240 240 240],[240 240 240]};    
    FoV    = [37 37 37];
    offset = floor(FoV/2) + [1 1 1];
    ox  = offset(1);oy = offset(2);oz = offset(3);
    sz  = dims{batch} - FoV + [1 1 1];

    header = '~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/';
    tail   = sprintf('.x%d_y%d_z%d_dim%dx%dx%d.mat',ox,oy,oz,sz(1),sz(2),sz(3));

    load([header 'iter_1M/output/out' num2str(batch) tail]);                % standard 1M
    standard{1} = result.xyz;
    load([header 'iter_3.5M/output/out' num2str(batch) tail]);              % standard 3.5M
    standard{2} = result.xyz;
    load([header 'iter_5M/output/out' num2str(batch) tail]);                % standard 5M
    standard{3} = result.xyz;
    load([header 'malis/exp1/iter_500K/output/out' num2str(batch) tail]);   % malis/exp1 1M
    malis{1} = result.xyz;
    load([header 'malis/exp1/iter_3M/output/out' num2str(batch) tail]);     % malis/exp1 3.5M
    malis{2} = result.xyz;
    load([header 'malis/exp1/iter_4.5M/output/out' num2str(batch) tail]);   % malis/exp1 5M
    malis{3} = result.xyz;
    % load([header 'malis/exp2/iter_500K/output/out' num2str(batch) tail]);   % malis/exp2 1M
    % malis{1} = result.xyz;
    % load([header 'malis/exp2/iter_3M/output/out' num2str(batch) tail]);     % malis/exp2 3.5M
    % malis{2} = result.xyz;
    % load([header 'malis/exp2/iter_4.5M/output/out' num2str(batch) tail]);     % malis/exp2 5M
    % malis{3} = result.xyz;

    header = '~/Workbench/torms3/znn-release/experiments/e2198_e2006/MALIS/output/original/';
    load([header 'out' num2str(batch) tail]);     % EyeWire
    eyewire = result.xyz;

    header = '~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp5/';
    load([header 'iter_500K/output/out' num2str(batch) tail]);     % Thick/exp5 500K
    thick{1} = result.xyz;
    load([header 'iter_1M/output/out' num2str(batch) tail]);     % Thick/exp5 1M
    thick{2} = result.xyz;

    figure;
    precision_recall_curve(standard,malis,eyewire,thick);

    FontSize = 12;
    grid on;
    xlabel('Recall','FontSize',FontSize);
    ylabel('Precision','FontSize',FontSize);
    title(['3D Rand error, batch' num2str(batch)], ...
           'FontSize',FontSize);

end

function precision_recall_curve(s,m,e,t)

    hold on;

    % standard
    d = s{1};plot(d.rec,d.prec,':k');
    d = s{2};plot(d.rec,d.prec,'-.k');
    d = s{3};plot(d.rec,d.prec,'-k');

    % MALIS
    d = m{1};plot(d.rec,d.prec,':r');
    d = m{2};plot(d.rec,d.prec,'-.r');
    d = m{3};plot(d.rec,d.prec,'-r');

    % EyeWire
    d = e;plot(d.rec,d.prec,'-b');

    % Thick
    d = t{1};plot(d.rec,d.prec,':m');
    d = t{2};plot(d.rec,d.prec,'-.m');

    hold off;

    FontSize = 12; 
    legend({'Standard 1M','Standard 3.5M','Standard 5M', ...
            'MALIS 1M','MALIS 3.5M','MALIS 5M', ...
            'EyeWire', ...
            'Thick 0.5M','Thick 1M'},'Location','Best', ...
            'FontSize',FontSize);

end