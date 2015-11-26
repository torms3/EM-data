function superimpose_curve( data, fname, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'data');
    addRequired(p,'fname',@(x)exist(x,'file'));
    addOptional(p,'siter',1,@(x)isnumeric(x)&&(x>0));
    parse(p,fname,varargin{:});

    % superimpose learning curve
    figure;
    subplot(1,2,1,data.h(1)); plot_curve('err','Cost');
    subplot(1,2,2,data.h(2)); plot_curve('cls','Classification error');

end