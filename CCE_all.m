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
        
        %% the unprocessed predicted BB got from the tracker but with all (5) corrdinates 

        resulttext = basename +'results'; % Example: sachini_clutter_results 
        resulttext_path = basepath + "/" + resulttext; %Ex: sachini_clutter_results
        
        %% the processed predicted BB variable to store required 4 corrdinates
        %Making: sachini_clutter_results_predicted.txt
        predictedtext = basename+ 'results' + "_predicted.txt"; % Ex: sachini_clutter_results_predicted.txt
        predictedtext_path = basepath + "/" + predictedtext; %Ex: sachini/clutter/sachini_clutter_results_predicted.txt
        disp(predictedtext_path);
        
        %% Generating the processed predicted file with 4 required cordinates
        p_bb_file(resulttext_path, predictedtext_path);

        %% The GT txt file tht was created using 'read_allGT.m'. It has GT coordinates: 4 co-ordinates
        gt_bbox = basepath + "/"+ basename +"readGT.txt";

        %% The file which has predicted tracker BB : 4 coordinates
        predicted_bbox = predictedtext_path;
        
        %% Calculate the centre distance error using Bhattacharya Method        
        centre_coordinat_error(basename, gt_bbox, predicted_bbox)  ; 
 
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
        legend('X coordinate centre error', 'Y coordinate centre error');
        xlabel('Frame number');
        ylabel('CCE between GT and Tracked bounding boxes','HorizontalAlignment','center');
        title('CCE Betweeen Bounding Boxes of GT and Tracking Results w.r.t. the X cordinate distance and Y Co-ordinate distance');
        hold off
        
        saveas(gcf,basename + "CCE.jpg"')

   end
end

%% Getting centre distance w.r.t co-ordinates errors
function centre_coordinat_error(basename, gt, predicted)
fid_4 = fopen(gt);
tline_4 = fgetl(fid_4);

fid_3 = fopen(predicted);
tline_3 = fgetl(fid_3);
i=1;
while ischar(tline_3) && ~startsWith(tline_4," ")
    disp(tline_3)
    disp(tline_4)  
    n_tline_3 = str2num(tline_3); %num2double fails
    n_tline_4 = str2num(tline_4); %num2double fails

    x_pred = n_tline_3(1,1);    x_gt = n_tline_4(1,1);
    y_pred = n_tline_3(1,2);    y_gt = n_tline_4(1,2);
    w_pred = n_tline_3(1,3);    w_gt = n_tline_4(1,3);
    h_pred = n_tline_3(1,4);    h_gt = n_tline_4(1,4);
    centre_pred(i,:) = [(x_pred) + (w_pred/2), (y_pred) + (h_pred/2)];
    centre_gt(i,:) = [(x_gt) + (w_gt/2), (y_gt) + (h_gt/2)];
    i = i+1;
    tline_3 = fgetl(fid_3);
    tline_4 = fgetl(fid_4);

end

disp(i)
save (basename + "CCE_gt");
save (basename + "CCE_pred");
centre_coordinate_error = abs(centre_gt - centre_pred);
disp(centre_coordinate_error);
save (basename + "CCE_error");
    
fclose(fid_3);
fclose(fid_4);
end

%% Getting 4 coordinates for the prediction boxes
function p_bb_file(resulttext, predictedtext)
fid_1 = fopen(resulttext);
fid_2 = fopen(predictedtext,'w'); % Open the file to write centre mean predicted
tline = fgetl(fid_1);

%% extract the first 4 coordinates and save in a file
    while ischar(tline)
        disp(tline)
        n_tline = str2num(tline); %num2double fails
        p_bb = n_tline(:,1:4); % p_bb  predicted bounding box     
            if fid_2 ~= -1
              fprintf(fid_2,'%f %f %f %f\n',p_bb); % p_bb = predicted bounding box, print the string    
            end
        tline = fgetl(fid_1);
    end
fclose(fid_2); % Close the file
fclose(fid_1);

end


