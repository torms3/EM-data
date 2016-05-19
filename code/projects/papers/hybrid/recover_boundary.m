function recover_boundary()
    
    for i = 1:3
        vol = import_volume(['out' num2str(i) '.1']);
        top = import_volume(['top' num2str(i) '.1']);
        btm = import_volume(['btm' num2str(i) '.1']);

        % concatenate
        new = cat(3,top,vol,btm);

        % export volume
        export_volume(['new' num2str(i) '.1'],new);
    end

end