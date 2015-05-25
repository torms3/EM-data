function view3Dstack( stack, x, y, z, resolution )

    [X,Y,Z] = size(stack);    

    % slicing
    xy = squeeze(stack(:,:,z));
    yz = squeeze(stack(x,:,:));
    zx = squeeze(stack(:,y,:));

    % post-processing
    x = x - 0.5;
    y = y - 0.5;
    z = z - 0.5;
    z = -z;
    Z = -Z;    
    zx = zx';

    % plotting
    hold on;

    xlabel('x');
    ylabel('y');
    zlabel('z');
    
    % xy-slice
    xImage = [0.5 0.5; X X];
    yImage = [0.5 Y; 0.5 Y];
    zImage = [z z; z z];
    surf(xImage,yImage,zImage,'CData',xy,'FaceColor','texturemap');

    % yz-slice
    xImage = [x x; x x];
    yImage = [0.5 0.5; Y Y];
    zImage = [0.5 Z; 0.5 Z];
    surf(xImage,yImage,zImage,'CData',yz,'FaceColor','texturemap');

    % zx-slice
    xImage = [0.5 X; 0.5 X];
    yImage = [y y; y y];
    zImage = [0.5 0.5; Z Z];
    surf(xImage,yImage,zImage,'CData',zx,'FaceColor','texturemap');

    % line
    line([0.5 X],[y y],[z z],'Color','r');
    line([x x],[0.5 Y],[z z],'Color','r');
    line([x x],[y y],[0.5 Z],'Color','r');

    hold off;

    colormap('gray');

    xlim([0.5 X]);
    ylim([0.5 Y]);
    zlim([Z 0.5]);    
    
    daspect(resolution);

end