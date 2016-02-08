% function [seg,mt] = merge_regions( seg, mt, thold )
%
%     idx = mt.vals > thold;
%
%     for i = 1:nnz(idx)
%
%         child  = mt.pairs(i,1);
%         parent = mt.pairs(i,2);
%
%         seg(seg == child) = parent;
%
%         replace = mt.pairs(:,2) == child;
%         mt.pairs(replace,2) = parent;
%
%     end
%
%     mt.vals  = mt.vals(~idx);
%     mt.pairs = mt.pairs(~idx,:);
%
% end