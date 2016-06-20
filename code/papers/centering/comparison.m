errtype = 'err';
w = 200;

root = get_workbench_root_path;
nickname = {'VD2D (train)','VD2D (test)','VD2D-BN (train)','VD2D-BN (test)'};
fpath = {[root '/seung-lab/znn-release/experiments/centering/control/VD2D/exp1/network'], ...
         [root '/seung-lab/znn-release/experiments/centering/control/VD2D-BN/exp1/network'], ...
        };

figure;
hold on;
cur = pwd;
idx = 1;
for i = 1:numel(fpath)
    cd(fpath{i});

    train = load_data('net_statistics_current.h5','train',errtype);
    test  = load_data('net_statistics_current.h5','test',errtype);

    train  = smooth_curve(train,w);
    h(idx) = plot(train.iter,train.(errtype),':');
    idx    = idx + 1;

    test   = smooth_curve(test,w/5);
    h(idx) = plot(test.iter,test.(errtype),'-');
    idx    = idx + 1;

end
cd(cur);
hold off;
grid on;

legend(h,nickname);
xlabel('Iteration');
ylabel('Cost');