function [] = stack2single( fname )

	stack = loadtiff(fname);
	stack = scaledata(single(stack),0,1);
	saveastiff(stack,fname);

end