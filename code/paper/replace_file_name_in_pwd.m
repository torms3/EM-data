function replace_file_name_in_pwd( old, new )

    list = dir([old '*']);
    for i = 1:numel(list)
        oldname = list(i).name;        
        tail = oldname(1+numel(old):end);
        newname = [new tail];
        eval(['!mv ' oldname ' ' newname]);
    end

end