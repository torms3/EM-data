function [ret] = optimize_2D_Rand_error( prob, truth, mask, thresh )

	if ~exist('mask','var');mask = [];end;
	if ~exist('thresh','var')
		thresh = [0.01 0.1:0.1:0.9 0.99];
	end


	%% 1st pass
    % resolution = 0.1
    disp(['1st pass...']);
    [data] = iterate_over(thresh);


	%% 2st pass
    % resolution = 0.05
    disp(['2nd pass...']);
    [~,I]  = min(extractfield(cell2mat(data),'re'));
    pivot  = data{I}.thresh;
    thresh = union(thresh,[pivot-0.05,pivot+0.05]);
    [data] = iterate_over(thresh);


    %% 3rd pass
    % resolution = 0.01
    disp(['3rd pass...']);
    [~,I]  = min(extractfield(cell2mat(data),'re'));
    pivot  = data{I}.thresh;
    thresh = union(thresh,pivot-0.05:0.01:pivot+0.05);
    [data] = iterate_over(thresh);


	%% Return
    %
	data = cell2mat(data);

	ret.thresh = extractfield(data,'thresh');
	ret.prec   = extractfield(data,'prec');
	ret.rec    = extractfield(data,'rec');
	ret.re 	   = extractfield(data,'re');


	function ret = iterate_over(thresh)

        nThresh = numel(thresh);
        ret = cell(1,nThresh);
        if exist('data','var')
            old = extractfield(cell2mat(data),'thresh');
        else
            old = [];
        end

        idx = 1;
        for i = 1:nThresh

            threshold = thresh(i);

            I = find(old == threshold,1);
            if isempty(I)
                fprintf('(%d/%d)... ',i,nThresh);
                ret{idx} = compute_2D_Rand_error(prob,truth,mask,threshold);
                ret{idx}.thresh = threshold;
                fprintf('2D Rand error = %.4f @ %.2f\n',ret{idx}.re,threshold);
            else
                ret{idx} = data{I};
            end
            idx = idx + 1;

        end

    end

end