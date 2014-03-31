[img] = import_forward_image( fname );
[prob,prob_medfilt] = generate_prob_map( img, 2 );
% assess_prob_map( prob_medfilt, test.label, true );
% assess_prob_map( prob_medfilt, test.label );
assess_prob_map( prob_medfilt, train.label );

figure;
interactive_plot(prob_medfilt);