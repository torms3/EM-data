function [stack] = stack2single( fin, fout, cropsize )

	stack = loadtiff(fin);
	stack = scaledata(single(stack),0,1);
	if exist('cropsize','var')
		stack = adjust_border_effect(stack,cropsize,true);
	end
	saveastiff(stack,fout);

end