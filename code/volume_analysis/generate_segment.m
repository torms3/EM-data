function [segm] = generate_segment( fname )

	% import output volume
	fprintf('Now importing ouput volume...\n');
	[vol] = import_multivolume( fname );
	[segm] = cat(4,vol{:});

end