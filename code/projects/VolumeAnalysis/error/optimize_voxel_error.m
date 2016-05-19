function [ret] = optimize_voxel_error( img, lbl, msk, thresh )

	if ~exist('msk','var');       msk = [];end;
	if ~exist('thresh','var'); thresh = [];end;
    if ~isempty(thresh)
        thresh = thresh((thresh >= 0) & (thresh <= 1));
        [data] = iterate_over(thresh,[]);
    else
    	%% 1st pass
        % line search interval: 0.1
        disp(['1st pass...']);
        thresh = [0:0.1:1];
        [data] = iterate_over(thresh,{});

    	%% 2st pass
        % line search interval: 0.05
        disp(['2nd pass...']);
        [~,I]  = min(extractfield(cell2mat(data),'err'));
        pivot  = data{I}.thresh;
        thresh = union(thresh,[pivot-0.05,pivot+0.05]);
        thresh = thresh((thresh >= 0) & (thresh <= 1));
        [data] = iterate_over(thresh,data);

        %% 3rd pass
        % line search interval: 0.01
        disp(['3rd pass...']);
        [~,I]  = min(extractfield(cell2mat(data),'err'));
        pivot  = data{I}.thresh;
        thresh = union(thresh,pivot-0.05:0.01:pivot+0.05);
        thresh = thresh((thresh >= 0) & (thresh <= 1));
        [data] = iterate_over(thresh,data);
    end

    %% Return
	data = cell2mat(data);

	ret.thresh 	= extractfield(data,'thresh');
	ret.prec 	= extractfield(data,'prec');
	ret.rec 	= extractfield(data,'rec');
	ret.fs 		= extractfield(data,'fs');
	ret.err 	= extractfield(data,'err');
	ret.poserr 	= extractfield(data,'poserr');
	ret.negerr 	= extractfield(data,'negerr');
	ret.balerr 	= extractfield(data,'balerr');


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	function ret = iterate_over( thresh, data )

        nThresh = numel(thresh);
        ret = cell(1,nThresh);
        old = [];
        if ~isempty(data)
            old = extractfield(cell2mat(data),'thresh');
        end

        idx = 1;
        for i = 1:nThresh

            threshold = thresh(i);

            I = find(old == threshold,1);
            if isempty(I)
                fprintf('(%d/%d)... ',i,nThresh);
                ret{idx} = compute_voxel_error(img,lbl,msk,threshold);
                ret{idx}.thresh = threshold;
                fprintf('Voxel error = %.4f @ %.2f\n',ret{idx}.err,threshold);
            else
                ret{idx} = data{I};
            end
            idx = idx + 1;

        end

    end

end