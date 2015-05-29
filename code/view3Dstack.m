function view3Dstack( stack, alpha, x, y, z, resolution, showline )

    if ~exist('showline','var'); showline = false; end;

    stack   = scaledata(double(stack),0,1);
    [X,Y,Z] = size(stack);    

    % slicing
    xy = squeeze(stack(:,:,z));
    yz = squeeze(stack(x,:,:));
    zx = squeeze(stack(:,y,:));

    if ~isempty(alpha)
        axy = squeeze(alpha(:,:,z));
        ayz = squeeze(alpha(x,:,:));
        azx = squeeze(alpha(:,y,:));
    end

    % post-processing
    % x = x - 0.5;
    % y = y - 0.5;    
    % z = z - 0.5;
    z = -z + 1;
    Z = -Z + 1;
    zx = zx';

    if ~isempty(alpha)
        azx = azx';
    end

    % plotting
    hold on;

    xlabel('x');
    ylabel('y');
    zlabel('z');
    
    % xy-slice
    % xImage = [0.5 0.5; X X];
    % yImage = [0.5 Y; 0.5 Y];
    xImage = [0 0; X X];
    yImage = [0 Y; 0 Y];
    zImage = [z z; z z];
    surf(xImage,yImage,zImage,'CData',repmat(xy,1,1,3),'FaceColor','texturemap','FaceAlpha',1);

    % xy-alpha
    if ~isempty(alpha)
        alph = zeros([size(axy) 3]);
        alph(:,:,1) = axy; % R-channel
        surf(xImage,yImage,zImage,'CData',alph,'FaceColor','texturemap','FaceAlpha',0.4,'FaceLighting','gouraud');
    end

    % yz-slice
    xImage = [x x; x x];
    % yImage = [0.5 0.5; Y Y];
    % zImage = [0.5 Z; 0.5 Z];
    yImage = [0 0; Y Y];
    zImage = [0 Z; 0 Z];
    surf(xImage,yImage,zImage,'CData',repmat(yz,1,1,3),'FaceColor','texturemap');

    % yz-alpha
    if ~isempty(alpha)
        alph = zeros([size(ayz) 3]);
        alph(:,:,1) = ayz; % R-channel
        surf(xImage,yImage,zImage,'CData',alph,'FaceColor','texturemap','FaceAlpha',0.4,'FaceLighting','gouraud');
    end
    
    % zx-slice
    % xImage = [0.5 X; 0.5 X];
    % yImage = [y y; y y];
    % zImage = [0.5 0.5; Z Z];
    xImage = [0 X; 0 X];
    yImage = [y y; y y];
    zImage = [0 0; Z Z];
    surf(xImage,yImage,zImage,'CData',repmat(zx,1,1,3),'FaceColor','texturemap');

    % zx-alpha
    if ~isempty(alpha)
        alph = zeros([size(azx) 3]);
        alph(:,:,1) = azx; % R-channel
        surf(xImage,yImage,zImage,'CData',alph,'FaceColor','texturemap','FaceAlpha',0.4,'FaceLighting','gouraud');
    end

    % line
    if showline
        % line([0.5 X],[y y],[z z],'Color','r');
        % line([x x],[0.5 Y],[z z],'Color','r');
        % line([x x],[y y],[0.5 Z],'Color','r');
    end

    hold off;

    % colormap('gray');

    xlim([0.5 X]);
    ylim([0.5 Y]);
    zlim([Z 0.5]);    
    
    daspect(resolution);

    grid on;

end