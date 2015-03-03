function temp_prec_rec_curve(batch)

header = '/data/home/kisuklee/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/';
tail = '.3DRand.x19_y19_z19_dim204x204x204.mat';

load([header 'iter_1M/output/out' num2str(batch) tail]);                % standard 1M
standard{1} = result;
load([header 'iter_3.5M/output/out' num2str(batch) tail]);              % standard 3.5M
standard{2} = result;
load([header 'malis/exp1/iter_500K/output/out' num2str(batch) tail]);   % malis/exp1 1M
malis{1} = result;
load([header 'malis/exp1/iter_3M/output/out' num2str(batch) tail]);     % malis/exp1 3.5M
malis{2} = result;
% load([header 'malis/exp2/iter_500K/output/out' num2str(batch) tail]);   % malis/exp2 1M
% malis{1} = result;
% load([header 'malis/exp2/iter_3M/output/out' num2str(batch) tail]);     % malis/exp2 3.5M
% malis{2} = result;

    figure;
    precision_recall_curve(standard,malis);

    grid on;
    xlabel('Recall');
    ylabel('Precision');
    title(['3D Rand error, batch' num2str(batch)]);

end

function precision_recall_curve(s,m)

    hold on;

    % standard
    d = s{1};plot(d.rec,d.prec,'-.k');
    d = s{2};plot(d.rec,d.prec,'-k');

    % MALIS
    d = m{1};plot(d.rec,d.prec,'-.r');
    d = m{2};plot(d.rec,d.prec,'-r');

    hold off;

    legend({'standard, 1M','standard, 3.5M' ...
            'MALIS, 1M','MALIS, 3.5M'},'Location','Best');

end