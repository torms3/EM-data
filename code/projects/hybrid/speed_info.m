function [] = speed_info( w, lgnd, from )

    if ~exist('w','var');          w = 1;end;
    if ~exist('lgnd','var');   lgnd = [];end;
    if ~exist('from','var');    from = 1;end;
    % if ~exist('estim','var'); estim = [];end;

    % load speed info.
    ret = training_speed('train',lgnd);

    ret.speed = ret.speed(from:end);
    ret.iter  = ret.iter(from:end);
    ret.n     = numel(ret.iter);

    % compute estimated finish time
    % if ~isempty(estim)
    %     maxiter     = estim(1);
    %     avgnum      = estim(2);
    %     testfactor  = estim(3);
    %     left = maxiter - ret.iter(end);
    %     if left > 0
    %         spd = mean(ret.speed(end-avgnum:end));
    %         str = datestr(now + (left*spd*testfactor/3600/24));
    %         fprintf('\n');
    %         disp(['Average speed: ' num2str(spd) ' secs/update']);
    %         disp(['Estimated finish time: ' str]);
    %         fprintf('\n');
    %     end
    % end

    % smoothing
    speed = conv(ret.speed,ones(w,1)/w,'valid');
    siter = 1 + floor(w/2);
    iter  = ret.iter(siter:siter+numel(speed)-1);

    % plotting
    plot(iter,speed);
    legend(ret.str,'Location','Best');
    grid on;
    xlabel('Iteration');
    ylabel('Speed (secs/update)');
    title(['Smoothing Window = ' num2str(w)]);

end