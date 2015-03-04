function temp_prec_rec_curve(batch)

header = '~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/';
tail = '.x19_y19_z19_dim204x204x204.mat';

load([header 'iter_1M/output/out' num2str(batch) tail]);                % standard 1M
standard{1} = result.xyz;
load([header 'iter_3.5M/output/out' num2str(batch) tail]);              % standard 3.5M
standard{2} = result.xyz;
% load([header 'malis/exp1/iter_500K/output/out' num2str(batch) tail]);   % malis/exp1 1M
% malis{1} = result.xyz;
% load([header 'malis/exp1/iter_3M/output/out' num2str(batch) tail]);     % malis/exp1 3.5M
% malis{2} = result.xyz;
load([header 'malis/exp2/iter_500K/output/out' num2str(batch) tail]);   % malis/exp2 1M
malis{1} = result.xyz;
load([header 'malis/exp2/iter_3M/output/out' num2str(batch) tail]);     % malis/exp2 3.5M
malis{2} = result.xyz;

header = '~/Workbench/torms3/znn-release/experiments/e2198_e2006/MALIS/output/';
tail = '.x19_y19_z19_dim204x204x204.mat';
load([header 'out' num2str(batch) tail]);     % EyeWire
eyewire = result.xyz;

    figure;
    precision_recall_curve(standard,malis,eyewire);

    grid on;
    xlabel('Recall','FontSize',12);
    ylabel('Precision','FontSize',12);
    title(['3D Rand error, batch' num2str(batch)], ...
           'FontSize',12);

end

function precision_recall_curve(s,m,e)

    hold on;

    % standard
    d = s{1};plot(d.rec,d.prec,'-.k');
    d = s{2};plot(d.rec,d.prec,'-k');

    % MALIS
    d = m{1};plot(d.rec,d.prec,'-.r');
    d = m{2};plot(d.rec,d.prec,'-r');

    % EyeWire
    d = e;plot(d.rec,d.prec,'-b');

    hold off;

    legend({'Standard, 1M','Standard, 3.5M' ...
            'MALIS, 1M','MALIS, 3.5M' ...
            'EyeWire'},'Location','Best', ...
            'FontSize',12);

end