clc
clear all

scenario = ["clutter", "deformation","motion","normal","outofview","occ"];
%scenario = "deformation";

for m = 1:numel(scenario)
    D = ["sachini","saad","destiny","nahid"];
    %D = "sachini";
    %hold on
    for k = 1:numel(D)
        
        basedir = D(k); %Ex: sachini
        basepath = basedir + "/" +scenario(m); %Ex:sachini/clutter
        basename = D(k)+ "_"+ scenario(m)+ "_"; %: sachini_clutter_ (note the extra _ at the end)
        disp(basepath);
        disp(basename);
        
        
        GTtext = basepath+ "/" + basename +'readGT.txt';
        disp(GTtext);
        
        %% Create a new folder called 'withGT' to store the images with GT over Predicted BB
        subfolder = basepath+ "/";
        subfolderName = 'withGT';
        mkdir(fullfile(subfolder , subfolderName));
        
        fid = fopen(GTtext);
        tline = fgetl(fid);
        i=1;
        while ischar(tline) && ~startsWith(tline," ")

            filename= basepath+ "/" + scenario(m) + num2str(i, '%05.f') + '.png';
            if isfile(filename)
                 filename= basepath+ "/" + scenario(m) + num2str(i, '%05.f') + '.png';
            else
                 filename= basepath+ "/" + D(k) + num2str(i, '%05.f') + '.png';
            end
            
            n_tline = str2num(tline); %num2double fails
            disp(filename);
            disp(n_tline);
            
            x_GT = n_tline(1,1);    
            y_GT = n_tline(1,2);
            w_GT = n_tline(1,3);    
            h_GT = n_tline(1,4);  
            
            
            imshow(filename);
            hold on
            rectangle('Position',[x_GT,y_GT,w_GT,h_GT] ,'EdgeColor','b','LineWidth',2)  
            saveas(gcf, subfolder + subfolderName + '/' + scenario(m) + num2str(i, '%05.f') + '.png')

            hold off
            
            i = i+1;
            tline = fgetl(fid);
        end
        fclose('all');
    end
end

