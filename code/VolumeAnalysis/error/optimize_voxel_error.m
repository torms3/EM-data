function [ret] = optimize_voxel_error( prob, truth, mask, thresh )

	if ~exist('mask','var');mask = [];end;
	if ~exist('thresh','var')
		thresh = [0.05 0.1:0.1:0.9 0.995];
	end

	% iterate through varying thresholds
	nThresh = numel(thresh);
	data = cell(1,nThresh);
	
	parfor i = 1:nThresh

		threshold = thresh(i);
		fprintf('(%d/%d)... ',i,nThresh);

		data{i} = compute_voxel_error(prob,truth,mask,threshold);		
		data{i}.thresh = threshold;

		fprintf('Voxel error = %.4f @ %.2f\n',data{i}.err,threshold);

	end

	data = cell2mat(data);
	
	ret.thresh 	= extractfield(data,'thresh');
	ret.prec 	= extractfield(data,'prec');
	ret.rec 	= extractfield(data,'rec');
	ret.fs 		= extractfield(data,'fs');
	ret.err 	= extractfield(data,'err');
	ret.poserr 	= extractfield(data,'poserr');
	ret.negerr 	= extractfield(data,'negerr');
	ret.balerr 	= extractfield(data,'balerr');

end