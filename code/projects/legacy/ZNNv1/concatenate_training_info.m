function [ret] = concatenate_training_info( info1, info2 )

	ret.train = concatenate_learning_info(info1.train,info2.train);
	ret.test  = concatenate_learning_info(info1.test,info2.test);
	ret.cost  = info1.cost;

end


function [ret] = concatenate_learning_info( info1, info2 )

	ret.n 	  = info1.n + info2.n;
	ret.iter  = [info1.iter; info2.iter + max(info1.iter)];
	ret.err   = [info1.err; info2.err];
	ret.cls   = [info1.cls; info2.cls];

end