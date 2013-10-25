function [net] = import_net(filename)

ff = fopen([filename '.filters'],'r');
fn = fopen([filename '.net'],'r');

[sz] = fread(fn,1,'uint32')
net = cell(sz,1);
net{1}.name = filename;
for l = 1:sz

    % network architecture
    net{l}.W_size = fread(fn,5,'uint32');
    % net{l}.MaxF_size = fread(fn,3,'uint32');
    % net{l}.pool_step = fread(fn,3,'uint32');

    % filters
    net{l}.eta = fread(ff,1,'double');
    net{l}.W_size
    net{l}.bias = fread(ff,net{l}.W_size(5),'double');
    net{l}.W = zeros(net{l}.W_size');
    for i = 1:net{l}.W_size(4)
        for j = 1:net{l}.W_size(5);
            net{l}.W(:,:,:,i,j) = reshape(fread(ff,prod(net{l}.W_size(1:3)),'double'),net{l}.W_size(1:3)');
        end;
    end;

end;