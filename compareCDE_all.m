clc
clear all

scenario = ["clutter", "deformation","motion","normal","outofview","occ"];

for m = 1:numel(scenario)
    D = ["sachini","saad","destiny","nahid"];
    hold on
    for k = 1:numel(D)
        
        basedir = D(k); %Ex: sachini
        basepath = basedir + "/" +scenario(m); %Ex:sachini/clutter
        basename = D(k)+ "_"+ scenario(m)+ "_"; %: sachini_clutter_ (note the extra _ at the end)
        disp(basepath);
 
        centre_dist_error = basename + "CDE_error.mat";
        load(centre_dist_error, 'centre_distance_error');
        s = size(centre_distance_error);
        for i = 1: s(1,1)
            centre_distance_error(i,3) = i;
        end

        %% Centre distance error
        p(k) = plot(centre_distance_error(:,3),centre_distance_error(:,1));
        set(gca, 'FontName', 'Arial')
        set(gca, 'FontSize', 10)
        
        xlabel('Frame number')
        ylabel('CDE b/w GT and Tracked Bounding Boxes','HorizontalAlignment','center')
        axis([0 s(1,1) 0 200]);
        title(scenario(m) +': CDE b/w Bounding Boxes Of GT and Tracking Results w.r.t. their centre');

    end
    h = [p(1);p(2);p(3);p(4)];
    legend(h, 'Dataset 1', 'Dataset 2', 'Dataset 3','Dataset 4');
    hold off 
end

