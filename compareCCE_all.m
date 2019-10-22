clc
clear all

scenario = ["clutter", "deformation","motion","normal","outofview","occ"];

for m = 1:numel(scenario)
    D = ["sachini","saad","destiny","nahid"];
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
        
        %% X coordinate error
        plot(centre_coordinate_error(:,3),centre_coordinate_error(:,1),'Color',[1,0.0,0.0])
        axis([0 s(1,1) 0 200]);
        hold on

        %% Y coordinate error
        plot(centre_coordinate_error(:,3),centre_coordinate_error(:,2),'Color',[0,0.0,1.0])
        set(gca, 'FontName', 'Arial')
        set(gca, 'FontSize', 5)
        axis([0 s(1,1) 0 200]);
        xlabel('Frame number');
        ylabel('CCE between GT and Tracked bounding boxes','HorizontalAlignment','center');
        title('CCE Betweeen Bounding Boxes of GT and Tracking Results w.r.t. the X cordinate distance and Y Co-ordinate distance');
        hold off 
    end
    legendx_name = scenario(m)+ 'X coordinate centre error';
    legendy_name = scenario(m)+ 'Y coordinate centre error';
    saveas(gcf,"CompareCCE.jpg"')

end