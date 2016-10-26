function validation( data, metric, varargin  )

    % Input parsing & validation.
    p = inputParser;
    addRequired(p,'data',@(x)iscell(x));
    addRequired(p,'metric',@(x)isequal(metric,'Rand')||isequal(metric,'VI')||isequal('Voxel'));
    addOptional(p,'fontsize',{},@(x)isnumeric(x)&&(0<x));
    parse(p,data,metric,varargin{:});

    % Font size.
    fontsize = get(0,'DefaultAxesFontSize');
    set(0,'DefaultAxesFontSize',p.Results.fontsize);

    % Main

    % Revert default font size.
    set(0,'DefaultAxesFontSize',fontsize);

end
