function [averaged_prob_list] = average_augmented_output( fname, indices, med )

	if ~exist('med','var')
		med = false;
	end

	averaged_prob_list = {};
	for i = 1:numel(indices)
		fprintf('(%d/%d) is now being processed...\n',i,numel(indices));
		idx = indices(i);
		sname = [fname '_' num2str(idx)];
		[img] = import_forward_image( sname );
		if med
			[~,prob] = generate_prob_map( img, 2 );
		else
			[prob,~] = generate_prob_map( img, 2 );
		end
		[prob] = revert_image( prob, i-1 );
		if ~exist('prob_sum','var')
			prob_sum = prob;
		else
			prob_sum = prob_sum + prob;
		end		
		averaged_prob_list{i} = medfilt3( prob_sum/i, 4 );
	end

end