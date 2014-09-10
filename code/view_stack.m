function [rotated_stack] = view_stack( stack, perspective, resolution )

	if ~exist('perspective','var')
		perspective = 'front';
	end
	if ~exist('resolution','var')
		% resolution = [6 6 30];	% SNEMI3D
		resolution = [7 7 40];	% Ashwin
	end

	switch perspective
	case 'top'
		stack = rot90_3D(stack,2,1);
		ratio = [resolution(3) resolution(1) resolution(2)]
	case 'side'
		stack = rot90_3D(stack,1,3);
		ratio = [resolution(1) resolution(3) resolution(2)]
	otherwise
		ratio = [1 1 1];
	end
	rotated_stack = stack;

	% parameters for interactive_multiplot
	coloring = false;
	clrStr = {'gray'};
	clrmap = [];

	interactive_multiplot(stack,coloring,clrStr,clrmap,ratio);

end