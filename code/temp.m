
batches = 1:14;
for i = 1:numel(batches)
    fname{i} = ['out' num2str(i)];
end
disp(fname);

% Standard 1M
cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/iter_1M/output');
assess_affinity_graph_script(fname([5,11,12]),batch([5,11,12]),[],[37 37 37],0,[0 0 1]);

% Standard 3.5M
cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/iter_3.5M/output');
assess_affinity_graph_script(fname([5,11,12]),batch([5,11,12]),[],[37 37 37],0,[0 0 1]);

% MALIS/exp1 500K
cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/malis/exp1/iter_500K/output');
assess_affinity_graph_script(fname([5,11,12]),batch([5,11,12]),[],[37 37 37],0,[0 0 1]);

% MALIS/exp1 3M
cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/malis/exp1/iter_3M/output');
assess_affinity_graph_script(fname([5,11,12]),batch([5,11,12]),[],[37 37 37],0,[0 0 1]);

% MALIS/exp2 500K
cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/malis/exp2/iter_500K/output');
assess_affinity_graph_script(fname([5,11,12]),batch([5,11,12]),[],[37 37 37],0,[0 0 1]);

% MALIS/exp2 3M
cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/malis/exp2/iter_3M/output');
assess_affinity_graph_script(fname([5,11,12]),batch([5,11,12]),[],[37 37 37],0,[0 0 1]);