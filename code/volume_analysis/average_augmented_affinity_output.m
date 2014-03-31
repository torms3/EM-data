function [prob_sum] = average_augmented_affinity_output( fname, indices, med )

	if ~exist('med','var')
		med = false;
	end

	averaged_prob_list = {};
	for i = 1:numel(indices)
		fprintf('(%d/%d) is now being processed...\n',i,numel(indices));
		idx = indices(i);
		sname = [fname '_' num2str(idx)];
		[vol] = import_multivolume( sname );
		for j = 1:numel(vol)
			[vol{j}] = revert_image( vol{j}, i-1 );
		end		
		if ~exist('prob_sum','var')
			prob_sum = cat(4,vol{:});
		else
			prob_sum = prob_sum + cat(4,vol{:});
		end
	end

end