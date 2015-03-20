
batches = 1:14;
for i = 1:numel(batches)
    fname{i} = ['out' num2str(i)];
end
disp(fname);

% Thick (exp5) 500K
rng = [1:3 5:12];
cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp5/iter_500K/output');pwd
assess_affinity_graph_script(fname(rng),batch(rng),[],[37 37 37],0,[0 0 1 0]);

% Thick (exp5) 1M
rng = [1:3 5:12];
cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp5/iter_1M/output');pwd
assess_affinity_graph_script(fname(rng),batch(rng),[],[37 37 37],0,[0 0 1 0]);

% Standard 1M
% rng = 1:3;
% cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/iter_1M/output');pwd
% assess_affinity_graph_script(fname(rng),batch(rng),[],[37 37 37],0,[0 0 1 0]);

% % Standard 3.5M
% cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/iter_3.5M/output');pwd
% assess_affinity_graph_script(fname(rng),batch(rng),[],[37 37 37],0,[0 0 1 0]);

% Standard 5M
% rng = 5:12;
% cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/iter_5M/output');pwd
% assess_affinity_graph_script(fname(rng),batch(rng),[],[37 37 37],0,[0 0 1 0]);

% % MALIS/exp1 500K
% rng = 1:3;
% cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/malis/exp1/iter_500K/output');pwd
% assess_affinity_graph_script(fname(rng),batch(rng),[],[37 37 37],0,[0 0 1 0]);

% % MALIS/exp1 3M
% cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/malis/exp1/iter_3M/output');pwd
% assess_affinity_graph_script(fname(rng),batch(rng),[],[37 37 37],0,[0 0 1 0]);

% % MALIS/exp1 4.5M
% rng = [1:3 5:12];
% cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/malis/exp1/iter_4.5M/output');pwd
% assess_affinity_graph_script(fname(rng),batch(rng),[],[37 37 37],0,[0 0 1 0]);

% % MALIS/exp2 500K
% rng = 1:3;
% cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/malis/exp2/iter_500K/output');pwd
% assess_affinity_graph_script(fname(rng),batch(rng),[],[37 37 37],0,[0 0 1 0]);

% % MALIS/exp2 3M
% cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/malis/exp2/iter_3M/output');pwd
% assess_affinity_graph_script(fname(rng),batch(rng),[],[37 37 37],0,[0 0 1 0]);

% % MALIS/exp2 4.5M
% rng = [1:3 5:12];
% cd('~/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp2/malis/exp2/iter_4.5M/output');pwd
% assess_affinity_graph_script(fname(rng),batch(rng),[],[37 37 37],0,[0 0 1 0]);