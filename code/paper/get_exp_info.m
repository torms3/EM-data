function list = get_exp_info

    % index
    idx = 1;

    % base dir
    cur = pwd;
    cd(get_project_root_path);
    cd('..');
    basedir = [pwd '/znn-release/experiments/'];
    cd(cur);

    %  % VD2D 90K (global rebalancing)
    % base_path        = [basedir 'paper/VD2D/exp3/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_90K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'out_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D-90K';
    % list{idx}.lgnd   = 'VD2D 90K';
    % idx = idx + 1;

    % % N4 90K
    % base_path        = [basedir 'paper/N4/exp1/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_90K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.bname  = 'stack%d';
    % list{idx}.str    = 'N4-90K';
    % list{idx}.lgnd   = 'N4 90K';
    % idx = idx + 1;

    % % VD2D 60K
    % base_path        = [basedir 'paper/VD2D/exp5/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_60K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D-60K';
    % list{idx}.lgnd   = 'VD2D 60K';
    % idx = idx + 1;

    % % VD2D 90K
    % base_path        = [basedir 'paper/VD2D/exp5/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_90K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D-90K';
    % list{idx}.lgnd   = 'VD2D 90K';
    % idx = idx + 1;

    % % VD2D (tanh) 60K
    % base_path        = [basedir 'paper/VD2D/exp6/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_60K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D-tanh-60K';
    % list{idx}.lgnd   = 'VD2D (tanh) 60K';
    % idx = idx + 1;

    % % VD2D (tanh) 90K
    % base_path        = [basedir 'paper/VD2D/exp6/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_90K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D-tanh-90K';
    % list{idx}.lgnd   = 'VD2D (tanh) 90K';
    % idx = idx + 1;

    % % VD2D-aug 20K
    % base_path        = [basedir '/multiscale/VD2D-aug/exp1/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_20K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D-aug-20K';
    % list{idx}.lgnd   = 'VD2D-aug 20K';
    % idx = idx + 1;

    % % VD2D-MS 20K
    % base_path        = [basedir '/multiscale/VD2D-MS/exp1/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_20K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D-MS-20K';
    % list{idx}.lgnd   = 'VD2D-MS 20K';
    % idx = idx + 1;

    % % VD2D-aug 50K
    % base_path        = [basedir '/multiscale/VD2D-aug/exp1/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_50K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D-aug-50K';
    % list{idx}.lgnd   = 'VD2D-aug 50K';
    % idx = idx + 1;

    % % VD2D-MS 50K
    % base_path        = [basedir '/multiscale/VD2D-MS/exp1/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_50K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D-MS-50K';
    % list{idx}.lgnd   = 'VD2D-MS 50K';
    % idx = idx + 1;

    % % N4 90K (xavier init)
    % base_path        = [basedir 'paper/N4/exp2/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_90K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.bname  = 'stack%d';
    % list{idx}.str    = 'N4-90K';
    % list{idx}.lgnd   = 'N4 90K (xavier)';
    % idx = idx + 1;

    % % VD2D3D 60K + 90K
    % base_path        = [basedir 'paper/VD2D3D/exp3/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_150K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D3D-60K+90K';
    % list{idx}.lgnd   = 'VD2D3D 60K+90K';
    % idx = idx + 1;

    % % VD2D3D 60K + 90K w/ 90K
    % base_path        = [basedir 'paper/VD2D3D/exp3/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_150K/iter_90K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D3D-60K+90K_w_90K';
    % list{idx}.lgnd   = 'VD2D3D 60K+90K w/ 90K';
    % idx = idx + 1;

    % % VD2D3D 90K + 90K
    % base_path        = [basedir 'paper/VD2D3D/exp4/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_180K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D3D-90K+90K';
    % list{idx}.lgnd   = 'VD2D3D 90K+90K';
    % idx = idx + 1;

    % % VD2D3D (tanh) 60K + 90K
    % base_path        = [basedir 'paper/VD2D3D/exp5/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_150K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D3D-tanh-60K+90K';
    % list{idx}.lgnd   = 'VD2D3D (tanh) 60K+90K';
    % idx = idx + 1;

    % % VD2D3D (tanh) 60K + 90K w/ 90K
    % base_path        = [basedir 'paper/VD2D3D/exp5/'];
    % list{idx}.path   = base_path;
    % list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    % list{idx}.err    = [base_path 'iter_150K/iter_90K/'];
    % list{idx}.batch  = [1 2 3 4];
    % list{idx}.bname  = 'stack%d';
    % list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    % list{idx}.str    = 'VD2D3D-tanh-60K+90K_w_90K';
    % list{idx}.lgnd   = 'VD2D3D (tanh) 60K+90K w/ 90K';
    % idx = idx + 1;

    % VD2D3D (tanh) 90K + 90K
    base_path        = [basedir 'paper/VD2D3D/exp6/'];
    list{idx}.path   = base_path;
    list{idx}.stat   = [base_path 'network/net_statistics.h5'];
    list{idx}.err    = [base_path 'iter_180K/'];
    list{idx}.batch  = [1 2 3 4];
    list{idx}.bname  = 'stack%d';
    list{idx}.fname  = 'Piriform_sample%d_output_0.mat';
    list{idx}.str    = 'VD2D3D-tanh-90K+90K';
    list{idx}.lgnd   = 'VD2D3D (tanh) 90K+90K';
    idx = idx + 1;

end