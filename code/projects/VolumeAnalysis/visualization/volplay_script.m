function volplay_script( data, prob, FoV )

    offs = floor(FoV/2) + [1,1,1];    
    sz   = size(prob) - FoV + [1,1,1];

    img  = crop_volume(data.image,offs,sz);
    lbl  = crop_volume(data.label,offs,sz);
    prob = scaledata(double(prob),0,1);
    prob = 1 - crop_volume(prob,offs,sz);

    volplay(img,{lbl==0,prob});

end