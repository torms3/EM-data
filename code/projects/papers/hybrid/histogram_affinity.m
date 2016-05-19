function histogram_affinity( graph, nbin, xrange )

    if ~exist('nbin','var');nbin = 100;end;
    if ~exist('thold','var');thold = 0;end;

    [affin] = parse_affin_graph(graph,thold);

    % plot together
    if true
        hold on;
        histogram(affin.x(:),nbin);
        histogram(affin.y(:),nbin);
        histogram(affin.z(:),nbin);
        xlim(xrange);
        legend({'x-affinity','y-affinity','z-affinity'});
        grid on;
    end

end

function [affin] = parse_affin_graph( graph, thold )

    if iscell(graph)
        affin.x = graph{1};
        affin.y = graph{2};
        affin.z = graph{3};
    elseif isstruct(graph)
        affin.x = graph.x;
        affin.y = graph.y;
        affin.z = graph.z;
    elseif ndims(graph) == 4
        affin.x = graph(:,:,:,1);
        affin.y = graph(:,:,:,2);
        affin.z = graph(:,:,:,3);
    end

end