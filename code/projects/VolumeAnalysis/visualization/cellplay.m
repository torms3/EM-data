function cellplay( data, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'data',@(x)iscell(x)&&(ndims(x)<3));

    default = repmat({'gray'},size(data));
    fn = @(x) isequal(size(data),size(x)) && iscell(x);
    addOptional(p,'clr',default,fn);

    default = cell(size(data));
    fn = @(x) isequal(size(data),size(x));
    addOptional(p,'alpha',default,fn);

    default = cell(size(data));
    fn = @(x) isequal(size(data),size(x)) && ...
              iscell(x) && all(all(cellfun(@isstr,x)));
    addOptional(p,'label',default,fn);

    parse(p,data,varargin{:});

    % set params
    params.data   = data;
    params.alpha  = p.Results.alpha;
    params.label  = p.Results.label;
    params.clrmap = set_colormap(p.Results.clr);
    params.mask   = set_alpha_mask;
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
    function clrmap = set_colormap( clr )

        clrmap = cell(size(data));

        for i = 1:numel(clr)
            if isempty(clr{i})
                vol = data{i};
                nseg = max(unique(vol(:)));
                clrmap{i} = rand(nseg,3);
                clrmap{i}(1,:) = 0;
            else
                clrmap{i} = clr{i};
            end
        end

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Set alpha mask
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function msk = set_alpha_mask

        % default mask color: white
        % clr = [1 1 1];
        clr = [1 0 0];

        sz  = size(data{1});
        one = ones(sz(1),sz(2));
        msk = cat(3,clr(1)*one,clr(2)*one,clr(3)*one);

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Key press event
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function key_press( src, event )

        z = params.z;
        zmax = params.zmax;
        step = 30;

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
        case 'leftarrow'
            z = z - step;
            z = max(min(z,zmax),1);
        case 'rightarrow'
            z = z + step;
            z = max(min(z,zmax),1);
        % change color
        case 'c'
            params.clrmap = set_colormap(p.Results.clr);
        % print
        case 'p'
            fname = uiputfile;
            if fname == 0
                fname = 'temp.png';
            end
            f = getframe(gca);
            imwrite(f.cdata,fname,'png');
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

            vol = params.data{idx};
            if isempty(vol); continue; end;

            [x,y] = size(params.data);
            [i,j] = ind2sub([x,y],idx);
            ax(idx) = subplot(x,y,j+y*(i-1));

            % display image
            z   = min(params.z,params.Z(idx));
            clr = params.clrmap{idx};
            if isstr(clr)
                imagesc(vol(:,:,z));
            else
                image(vol(:,:,z));
            end
            colormap(ax(idx),clr);

            hold on;

                % display alpha channel
                if ~isempty(params.alpha{idx})

                    vol = params.alpha{idx};
                    chn = vol(:,:,z);

                    h = imshow(params.mask);
                    set(h,'AlphaData',chn*0.2);

                end

            hold off;

            daspect(params.ratio);
            title(['z = ' num2str(z)]);
            xlabel(params.label{idx});

        end

    end

end