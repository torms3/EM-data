function [ret] = subsample_train_info( data, period, offset )

	ret.train = subsample_learning_info(data.train,period,offset);
	ret.test  = subsample_learning_info(data.test,period,offset);
	ret.cost  = data.cost;

end


function [ret] = subsample_learning_info( data, period, offset )

	idx = offset:period:data.n;

	ret.n 	 = numel(idx);
	ret.iter = data.iter(idx);
	ret.err  = data.err(idx);
	ret.cls  = data.cls(idx);

end