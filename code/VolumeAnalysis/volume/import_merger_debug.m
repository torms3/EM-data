function [ret] = import_merger_debug( fname )
    
    for i = 1:3
        affin{i} = import_tensor( [fname '.affin'],  [], num2str(i-1) );
        truth{i} = import_tensor( [fname '.truth'],  [], num2str(i-1) );
        malis{i} = import_tensor( [fname '.malis'], [], num2str(i-1) );

        affin{i} = squeeze(affin{i});
        truth{i} = squeeze(truth{i});
        malis{i} = squeeze(malis{i});
    end

    ret.affin = affin;
    ret.truth = truth;
    ret.malis = malis;

end