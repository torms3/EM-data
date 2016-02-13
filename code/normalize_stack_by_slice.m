function [stack] = normalize_stack_by_slice( stack )

	[sx,sy,sz] = size(stack);
    stack = double(reshape(stack,sx*sy,sz));
    M = repmat(mean(stack,1),sx*sy,1);
    S = repmat(mean(stack,1),sx*sy,1);
    stack = (stack - M)./S;
    stack = reshape(stack,sx,sy,sz);

end