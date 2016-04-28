function [fpath,nickname] = exp_info

    nickname = {'VD2D3D-P3',    ...
                'VD2D3D-P2',    ...
                'VD2D3D-z7',    ...
                'VD2D3D-z9',    ...
                'VD2D3D-avg',   ...
                'VD2D3D-MS',    ...
                'VD2D3D-MS-p',  ...
                'MSF-3D',       ...
                };

    root = get_workbench_root_path;

    fpath = {...%[root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/P3/exp1/iter_100K/exp1/iter_120K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/P2/exp2/iter_150K/exp1/iter_250K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/P1-F5/z7/exp1/iter_70K/exp1/iter_300K/exp1/iter_500K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/P1-F5/z9/exp1/iter_300K/exp1/iter_500K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/avg/P3P2z7z9'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/avg/P3P2z7'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/avg/P3P2z9'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/MS/exp1/iter_150K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/MS/pretrain/exp1/iter_200K/exp1/iter_300K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/MSF/exp1/iter_80K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/dropnode/P3/exp1/iter_80K/exp1/iter_100K/exp1/iter_190K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/dropnode/P2/exp1/iter_70K/exp1/iter_100K/exp1/iter_120K/exp1/iter_140K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/dropnode/z5/exp1/iter_100K/exp1/iter_160K/exp1/iter_180K/exp1/iter_200K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/dropnode/z7/exp1/iter_200K/exp1/iter_230K/exp1/iter_240K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/dropnode/z9/exp1/iter_100K/exp1/iter_150K/exp1/iter_180K/exp1/iter_190K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/dropnode/MS/drop2/exp1/iter_40K/exp1/iter_76K/exp1/iter_84K/exp1/iter_136K'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/dropnode/avg/P3P2z5z7z9'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/dropnode/avg/P3P2z7z9'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/dropnode/avg/P3P2z9'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/dropnode/avg/z5z7z9'], ...
             ...% [root '/seung-lab/znn-release/experiments/new_Piriform/VD2D3D/affinity/MS-maxout/exp1/iter_150K'], ...
             [root '/experiments/Ashwin/3D_affinity/train23_test1/VeryDeep2HR_w65x9/rebalanced/eta02_out100/iter_30K/output/7nmTraining'], ...
            };

end