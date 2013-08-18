
% load raw data
fprintf('Now loading Ashwin dataset...\n');
[dpath] = get_project_data_path();
load([dpath '/EM_boundary.mat']);
fprintf('Done!\n\n');

% mold
mold = [2 2];
[stacks] = divide_stack( mold, data.images, data.label1 );

% batch generation
w = 0;
affinity = true;
data = cell(size(stacks));
for i = 1:numel(stacks)

	fprintf('(%d/%d) %dth stack is now being processed...\n',i,numel(stacks),i);

	s = stacks{i};
	[x,y,z] = size(s.img);
	bb = ones(3,2);
	bb(1,2) = x;
	bb(2,2) = y;
	bb(3,2) = z;
	norm_factor = 256;

	[data{i}] = generate_whole_training_input( s.img/norm_factor, s.lbl, bb, s.msk, w, affinity );

end

% export
dirName = sprintf('Ashwin__%dby%d',mold(1),mold(2));
export_multiple_whole_traing_data( dirName, data );
