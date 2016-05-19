function [rotated_stack] = view_stack( stack, perspective, resolution, alphas )

	if ~exist('perspective','var')
		perspective = 'front';
	end
	if ~exist('resolution','var')
		% resolution = [6 6 30];	% SNEMI3D
		resolution = [7 7 40];	% Ashwin
	end
	if ~exist('alphas','var')
		alphas = {};
	end

	switch perspective
	case 'top'
		stack = rot90_3D(stack,2,1);
		for i = 1:numel(alphas)
			alphas{i} = rot90_3D(alphas{i},2,1);
		end
		ratio = [resolution(3) resolution(1) resolution(2)]
	case 'side'
		stack = rot90_3D(stack,1,3);
		for i = 1:numel(alphas)
			alphas{i} = rot90_3D(alphas{i},1,3);
		end
		ratio = [resolution(1) resolution(3) resolution(2)]
	case 'bottom'
		stack = rot90_3D(stack,2,3);
		for i = 1:numel(alphas)
			alphas{i} = rot90_3D(alphas{i},2,3);
		end
		ratio = [resolution(3) resolution(1) resolution(2)]
	otherwise
		ratio = resolution;
	end
	rotated_stack = stack;

	% parameters for interactive_multiplot
	coloring = false;
	clrStr = {'gray'};
	clrmap = [];

	% interactive_multiplot(stack,coloring,clrStr,clrmap,ratio);
	volplay(stack,alphas,[],ratio);

end