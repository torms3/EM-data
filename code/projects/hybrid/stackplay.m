function [] = stackplay( stack, alpha, resolution )

    if ~exist('alpha','var')
        alpha = [];
    end
    if ~exist('resolution','var')
        resolution = [1 1 1];
    end

    dim = size(stack);

    % set data
    data.stack = scaledata(double(stack),0,1);
    % data.stack = stack;
    data.x      = size(stack,1);
    data.y      = 1;%size(stack,2);
    data.z      = 1;
    data.ratio  = resolution;
    data.step   = 1;
    data.mode   = 3;
    data.rot    = 45;
    data.el     = 30;

    % display the first slice 
    view3D;
    h = gcf;

    % set event functions
    set( h, 'KeyPressFcn', @key_press );
    set( h, 'WindowScrollWheelFcn', @scroll_wheel );


    %% Key press event
    %
    function key_press( src, event )

        str = {'x','y','z'};

        switch event.Key
        case '1' % x
            data.mode = 1;
        case '2' % y
            data.mode = 2;
        case '3' % z
            data.mode = 3;
        % case 'uparrow'
        %     v = data.(str{data.mode});
        %     v = rem(v - 1,dim(data.mode));
        %     if( v == 0 )
        %         v = dim(data.mode);
        %     end
        %     data.(str{data.mode}) = v;
        % case 'downarrow'
        %     v = data.(str{data.mode});
        %     v = rem(v + 1,dim(data.mode));
        %     if( v == 0 )
        %         v = dim(data.mode);
        %     end
        %     data.(str{data.mode}) = v;
        case 'uparrow'
            data.el = min(data.el + 5,90);
        case 'downarrow'
            data.el = max(data.el - 5,0);
        case 'leftarrow'
            data.rot = min(data.rot + 5,180);
        case 'rightarrow'
            data.rot = max(data.rot - 5,0);
        end
        
        view3D;

    end

    
    %% Mouse wheel event
    %
    function scroll_wheel( src, event )
        
        str = {'x','y','z'};

        val = data.(str{data.mode});
        if str{data.mode} == 'y'
            val = val - ceil(event.VerticalScrollCount*data.step);
        else
            val = val + ceil(event.VerticalScrollCount*data.step);
        end
        val = max(min(val,dim(data.mode)),1);
        data.(str{data.mode}) = val;

        view3D;
    end


    %% Display slice
    %
    function view3D

        clf;
        view3Dstack(data.stack,alpha,data.x,data.y,data.z,data.ratio,true);
        view([data.rot data.el]);
        drawnow;

    end

end