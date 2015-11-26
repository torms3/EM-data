function ZALIS_script( img, bdm, lbl )

    assert(ndims(size(bdm))==2||ndims(size(bdm))==3);

    sz = size(bdm);
    if numel(sz) == 2
        sz = [sz 1];
    end
    zyx = sz(end:-1:1);

    % ZALIS
    malis = '/usr/people/kisuk/Workbench/seung-lab/znn-release/bin/malis';
    base  = '/usr/people/kisuk/Workbench/seung-lab/znn-release/test/malis/';
    oname = [base 'out'];
    xname = [base 'temp/xaff.bin'];
    yname = [base 'temp/yaff.bin'];
    zname = [base 'temp/zaff.bin'];
    lname = [base 'temp/lbl.bin' ];

    % export affinity graph
    [xaff,yaff] = make_affinity(bdm,false);
    export_volume(xname,xaff);
    export_volume(yname,yaff);
    export_volume(zname,zeros(size(xaff)));

    % export label
    export_volume(lname,lbl);

    % merger constrained
    high      = 1;
    low       = 0.5;
    phase     = 'MERGER';
    constrain = 1;
    frac_norm = 1;

    temp = generate_option;
    system([malis ' ' pwd '/' temp]);
    merger = load_result;

    % splitter constrained
    high      = 0.95;
    low       = 0;
    phase     = 'SPLITTER';
    constrain = 1;
    frac_norm = 1;

    temp = generate_option;
    system([malis ' ' pwd '/' temp]);
    splitter = load_result;
    system(['rm ' temp]);

    % data to visualize
    msigma = 5;
    ssigma = 4;
    mthold = 0.5;
    sthold = 0.02;
    aff    = (xaff+yaff)/2;
    maff   = (merger.xaff+merger.yaff)/2;
    saff   = (splitter.xaff+splitter.yaff)/2;

    mw     = merger.mw;
    sw     = splitter.sw;
    bmw    = double(mw>mthold);
    bsw    = double(sw>sthold);
    mmsk   = imgaussmask(bmw,msigma);
    smsk   = imgaussmask(bsw,ssigma);

    % visualize
    data  = {img,maff,mmsk; lbl,saff,smsk};
    clr   = {'gray','gray','hot'; '','gray','hot'};
    label = {'affinity','merger constrained','merger weight'; ...
             'ground truth','splitter constrained','splitter weight'};
    alpha = {aff,[],aff; [],[],aff};
    cellplay(data,'clr',clr,'label',label,'alpha',alpha);

    % data  = {bdm,mw,bmw,mmsk; lbl,sw,bsw,smsk};
    % clr   = {'gray','hot','hot','hot'; '','hot','hot','hot'};
    % alpha = {[],aff,aff,aff; [],aff,aff,aff};
    % cellplay(data,'clr',clr,'alpha',alpha);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function mask = imgaussmask( img, sigma )

        sz   = 2*ceil(2*sigma) + 1;
        w    = fspecial('gaussian',sz,sigma);
        w    = scaledata(w,0,1);
        mask = convn(img,w,'same');

        mask(mask > 1) = 1;

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function ret = load_result

        affs = import_tensor([oname '.affs']);
        mw   = import_tensor([oname '.merger']);
        sw   = import_tensor([oname '.splitter']);

        ret.xaff = affs(:,:,:,1);
        ret.yaff = affs(:,:,:,2);
        ret.mw   = sum(mw,4);
        ret.sw   = sum(sw,4);

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function temp = generate_option

        temp = 'temp.config';
        fid  = fopen(temp,'w');

        fprintf(fid,'size %d,%d,%d\n',zyx);
        fprintf(fid,'xaff %s\n',xname);
        fprintf(fid,'yaff %s\n',yname);
        fprintf(fid,'zaff %s\n',zname);
        fprintf(fid,'lbl %s\n',lname);
        fprintf(fid,'out %s\n',oname);
        fprintf(fid,'high %f\n',high);
        fprintf(fid,'low %f\n',low);
        fprintf(fid,'phase %s\n',phase);
        fprintf(fid,'constrain %d\n',constrain);
        fprintf(fid,'frac_norm %d\n',frac_norm);
        fprintf(fid,'debug_print 0\n');

        fclose(fid);

    end

end