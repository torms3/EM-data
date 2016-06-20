function script_template( prefix, samples, out_type )
%
% Arguments description:
%   prefix      'Piriform'
%   samples     [1 9 10]
%   out_type    'boundary' or 'affinity'

    template = [prefix '_sample%d_output'];

    % TODO: move to local working directory

    % convert .tif to affinity
    for i = 1:numel(samples)
        v4out_to_affin(sprintf(template,samples(i)));
    end

    %

end