clc
clear all

scenario = ["clutter", "deformation","motion","normal","outofview","occ"];

for m = 1:numel(scenario)
    D = ["sachini","saad","destiny","nahid"];
    hold on
    for k = 1:numel(D)
        basedir = D(k);
        basepath = basedir + "/" +scenario(m);
        basename = D(k)+ "_"+ scenario(m)+ "_";
        disp(basepath);
        
        centre_coord_error = basename + "CCE_error.mat";
        load(centre_coord_error, 'centre_coordinate_error');       
        s = size(centre_coordinate_error);
        for i = 1: s(1,1)
            centre_coordinate_error(i,3) = i;
        end
        

        %% Y coordinate error
        p(k) = plot(centre_coordinate_error(:,3),centre_coordinate_error(:,2));
        set(gca, 'FontName', 'Arial')
        set(gca, 'FontSize', 10)
        
        axis([0 s(1,1) 0 200]);
        xlabel('Frame number');
        ylabel('CCE between GT and Tracked bounding boxes','HorizontalAlignment','center');
        title(scenario(m) +':CCE Betweeen Bounding Boxes of GT and Tracking Results w.r.t.the Y cordinate distance ');
    end
    h = [p(1);p(2);p(3);p(4)];
    legend(h, 'Dataset 1', 'Dataset 2', 'Dataset 3','Dataset 4');
    hold off 

end