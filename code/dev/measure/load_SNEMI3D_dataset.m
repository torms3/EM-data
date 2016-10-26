function data = load_SNEMI3D_dataset( idx, bordered )

    if ~exist('idx','var'); idx = [];  end;
    if isempty(idx);        idx = 1:3; end;
    if ~exist('bordered','var'); bordered = true; end;

    cur = pwd;
    if bordered
        cd('~/Data_local/datasets/SNEMI3D/train_val_test');

        imgs{1} = 'train-image.h5';
        lbls{1} = 'train-label.h5';

        imgs{2} = 'validation-image.h5';
        lbls{2} = 'validation-label.h5';

        imgs{3} = 'test-image.h5';
        lbls{3} = 'test-label.h5';

        for i = 1:numel(idx)
            n = idx(i);
            disp(['load stack' num2str(n) '...']);
            data{i}.image = hdf5read(imgs{n},'/main');
            data{i}.label = hdf5read(lbls{n},'/main');
        end
    else
        cd('~/Data_local/datasets/SNEMI3D/original');

      	for i = 1:numel(idx)
      	    n = idx(i);
      	    if n == 1
            		train = load_original('train');
            		data{i}.image = train.img(:,:,1:80);
            		data{i}.label = train.lbl(:,:,1:80);
      	    end
      	    if n == 2
            		train = load_original('train');
            		data{i}.image = train.img(:,:,81:end);
            		data{i}.label = train.lbl(:,:,81:end);
      	    end
      	    if n == 3
            		test = load_original('test');
            		data{i}.image = test.img;
            		data{i}.label = test.lbl;
      	    end
      	end

    end


    cd(cur);


    function [ret] = load_original( phase )

        assert(strcmp(phase,'train') || strcmp(phase,'test'));
        if exist(phase,'var')
            ret = eval(phase);
        else
            disp(['load ' phase '...']);
            ret.img = loadtiff([phase '-input.tif']);
            ret.lbl = loadtiff([phase '-labels.tif']);
        end

    end

end
