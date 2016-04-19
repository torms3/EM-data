template = 'Piriform_sample%d_output';

% ZNNv4 output to affinity format
v4out_to_affin( sprintf(template,1) );
v4out_to_affin( sprintf(template,9) );
v4out_to_affin( sprintf(template,10) );

% Rand score on validation
Rand_score({pwd},template,1,'low',0,'thold',2.^[8:16],'overwrite',true);
merge_split_plot({pwd},{''},sprintf(template,1),'low',0,'thold',2.^[8:16],'metric','Rand');

% Rand score on test
Rand_score({pwd},template,[9 10],'low',0,'thold',[],'overwrite',true);
merge_split_plot({pwd},{''},sprintf(template,9),'low',0,'thold',[],'metric','Rand');
merge_split_plot({pwd},{''},sprintf(template,10),'low',0,'thold',[],'metric','Rand');
