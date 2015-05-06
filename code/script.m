% fpath = '/data/home/kisuklee/Workbench/torms3/znn-release/experiments/e2198_e2006/SriniNet/exp8/iter_500K/malis/';

% idx = [1:3 5:12];
% cd([fpath 'exp1/iter_1M/output/']);
% assess_affinity_graph_script(fname(idx),data(idx),[],[37 37 37],0,[1 0 1 0]);
% cd([fpath 'exp2/iter_1M/output/']);
% assess_affinity_graph_script(fname(idx),data(idx),[],[37 37 37],0,[1 0 1 0]);
% cd([fpath 'exp3/iter_1M/output/']);
% assess_affinity_graph_script(fname(idx),data(idx),[],[37 37 37],0,[1 0 1 0]);
% cd([fpath 'exp4/iter_1M/output/']);
% assess_affinity_graph_script(fname(idx),data(idx),[],[37 37 37],0,[1 0 1 0]);

fpath = '/data/home/kisuklee/Workbench/torms3/znn-release/experiments/Ashwin/3D_affinity/train23_test1/';


fname   = {'out1','out2','out3','out4'};
data    = load_Ashwin_dataset;
idx     = 1:4;
offset  = [];
FoV     = [69 69 5];
filtrad = 0;
options = [1 1 1 0];

cd([fpath 'VDH-P3_w69x5/exp1/iter_30K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VDH-P3_w69x5/exp1/iter_60K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VDH-P3_w69x5/exp3/iter_30K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VDH-P3_w69x5/exp3/iter_60K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VDH-P3_w69x5/exp4/iter_30K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VDH-P3_w69x5/exp4/iter_60K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VDH-P3_w69x5/exp5/iter_60K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VDH-P3_w69x5/exp5/iter_90K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);


idx = 1:3;
FoV = [55 55 9];

cd([fpath 'VDH-P1-v2_w55x9/dropout/rebalanced/global/eta02_out100/iter_30K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VDH-P1_w55x9/rebalanced/global/eta02_out100/iter_30K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VDH-P1_w55x9/rebalanced/global/eta02_out100/iter_60K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VDH-P1_w55x9/unbalanced/eta02_out100/iter_30K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VDH-P1_w55x9/unbalanced/eta02_out100/iter_60K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);


FoV = [65 65 9];

cd([fpath 'VDH-P2_w65x9/dropout/rebalanced/global/eta02_out100/iter_30K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VDH-P2_w65x9/dropout/rebalanced/global/eta02_out100/iter_60K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VeryDeep2H_w65x9/dropout/rebalanced/global/eta02_out100/iter_60K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VeryDeep2H_w65x9/unbalanced/eta02_out100/iter_30K/output/7nmTraining/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VeryDeep2H_w65x9/unbalanced/eta02_out100/iter_60K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);


options = [0 0 1 0];

cd([fpath 'VeryDeep2H_w65x9/dropout/rebalanced/global/eta02_out100/iter_30K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VeryDeep2H_w65x9/rebalanced/global/eta02_out100/iter_30K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);
cd([fpath 'VeryDeep2H_w65x9/rebalanced/global/eta02_out100/iter_60K/output/']);
assess_affinity_graph_script(fname(idx),data(idx),offset,FoV,filtrad,options);