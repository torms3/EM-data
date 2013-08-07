function [motifs] = affinity_edge_motif_analysis( G, mask, th )

	if( isstruct(G) )		
		motifs(:,1) = G.x(mask);
		motifs(:,2) = G.y(mask);		
		motifs(:,3) = G.z(mask);
	end

	if( iscell(G) )
		assert(numel(G) == 3);

		if( exist('th','var') )
			G{1} = G{1} > th;
			G{2} = G{2} > th;
			G{3} = G{3} > th;
		end

		motifs(:,1) = G{1}(mask);
		motifs(:,2) = G{2}(mask);
		motifs(:,3) = G{3}(mask);
	end

end