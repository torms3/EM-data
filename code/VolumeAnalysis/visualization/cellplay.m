function cellplay( data, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'data',@(x)iscell(x)&&(ndims(x)<3));

    default = zeros(size(data));
    fn = @(x) isequal(size(data),size(x)) && ...
              (isnumeric(x) || islogical(x));
    addOptional(p,'coloring',default,fn);

    default = cell(size(data));
    fn = @(x) isequal(size(data),size(x)) && ...
              iscell(x) && all(cellfun(@isstr,x));
    addOptional(p,'label',default,fn);

    parse(p,data,varargin{:});

    % set params
    params.data   = data;
    params.label  = p.Results.label;
    params.clrmap = set_colormap(p.Results.coloring);
    params.z      = 1;
    params.Z      = cellfun(@(x)size(x,3),data);
    params.zmax   = max(params.Z(:));
    params.ratio  = [1 1 1];

    % display the first slice
    display_slice;
    h = gcf;

    % set event functions
    set( h, 'KeyPressFcn', @key_press );
    set( h, 'WindowScrollWheelFcn', @scroll_wheel );


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Assign random colormap
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function clrmap = set_colormap( coloring )

        clrmap = cell(size(data));

        for i = 1:numel(coloring)
            if coloring(i)
                vol = data{i};
                nseg = max(unique(vol(:)));
                clrmap{i} = rand(nseg+1,3);
                clrmap{i}(1,:) = 0;
            end
        end

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Key press event
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function key_press( src, event )

        z = params.z;
        zmax = params.zmax;

        switch event.Key
        case 'uparrow'
            z = rem(z - 1,zmax);
            if( z == 0 )
                z = zmax;
            end
        case 'downarrow'
            z = rem(z + 1,zmax);
            if( z == 0 )
                z = zmax;
            end
        % change color
        case 'c'
            params.clrmap = set_colormap(p.Results.coloring);
        % % print
        % case 'p'
        %     fname = uiputfile;
        %     if fname == 0
        %         fname = 'temp.png';
        %     end
        %     f = getframe(gca);
        %     imwrite(f.cdata,fname,'png');
        end

        params.z = z;
        display_slice;

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Mouse wheel event
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function scroll_wheel( src, event )

        step = 1;
        z    = params.z;
        zmax = params.zmax;

        z = z + (event.VerticalScrollCount*step);
        z = max(min(z,zmax),1);

        params.z = z;
        display_slice;

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Display slice
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function display_slice

        for idx = 1:numel(params.data)

            [x,y] = size(params.data);
            ax(idx) = subplot(x,y,idx);

            vol = params.data{idx};
            z = min(params.z,params.Z(idx));
            if isempty(params.clrmap{idx})
                imagesc(vol(:,:,z));
                colormap('gray');
            else
                image(vol(:,:,z));
                colormap(params.clrmap{idx});
            end

            freezeColors;
            daspect(params.ratio);
            title(['z = ' num2str(z)]);
            xlabel(params.label{idx});

        end

    end

end