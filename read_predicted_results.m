count=001;
fid = fopen('clutter_results');
tline = fgetl(fid);
while ischar(tline)
    disp(tline)
    n_tline = str2num(tline); %num2double fails
    BaseName='destiny';
    im=[BaseName num2str(count, '%05.f') '.png'];  %to ensure that there are 5 digits in the name
    imshow(im);
    hold on
    rectangle('Position',n_tline(:,1:4), 'Edgecolor', 'b' , 'LineWidth', 0.8)
    count = count + 1;
    tline = fgetl(fid);
end
fclose(fid);
