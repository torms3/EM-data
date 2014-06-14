function [ret] = sample_train_info( data, idx1, idx2 )

	ret.train = sample_learning_info(data.train,idx1);
	ret.test  = sample_learning_info(data.test,idx2);
	ret.cost  = data.cost;

end


function [ret] = sample_learning_info( data, idx )

	idx = intersect(1:data.n,idx);

	ret.n 	 = numel(idx);
	ret.iter = data.iter(idx);
	ret.err  = data.err(idx);
	ret.cls  = data.cls(idx);

end