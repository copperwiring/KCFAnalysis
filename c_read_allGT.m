%% Reading the Groundtruths from the exported data of image labeller
%% here: imageLabelingSession.mat 
%% and converting them to txt file for readabilty

clear all
clc

D = ["sachini","saad","destiny","nahid"];
for k = 1:numel(D)
    scenario = ["clutter", "deformation","motion","normal","outofview","occ"];
    for m = 1:numel(scenario)
        basedir = D(k);    
        GT_path = basedir + "/" +scenario(m) ;
        GTmatfile = dir(fullfile(GT_path,'gt*.mat') );   %# list all *.xyz files
        GT = load(GTmatfile.name);
        loc = GT.gTruth.LabelData.Variables; %extracts all the variables without headers
        disp(GT_path);
        writecell(loc, GT_path + "/"+ D(k)+ "_"+ scenario(m)+ "_"+ 'readGT.txt', 'Delimiter', ' ');
    end
end



