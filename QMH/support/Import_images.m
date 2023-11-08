function Import_images(path,display)
folder_contents  = dir([path '\*.png']);
data = struct([]);

opts = delimitedTextImportOptions("NumVariables", 1);
opts.VariableNames = "Angle";
opts.VariableTypes = "double";
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "Angle", "EmptyFieldRule", "auto");
% Import the data
tbl = readtable([path '\angles.txt'], opts);

for k = 1:length(folder_contents)
    image_path = [folder_contents(k).folder '\' folder_contents(k).name];
    data(k).image = imread(image_path,'png');
    data(k).angle = tbl.Angle(k);
end

assignin('base','data',data);

if display
    m = 4;
    n = ceil(length(folder_contents)/m);
    figure;
    
    idx = 1;  
    
    for row = 1:m
        for col = 1:n
            if idx == length(folder_contents); break; end
            subplot(n,m,idx);
            imshow(data(idx).image);
            text(0,...
                0,...
                [num2str(data(idx).angle) '°'],'Color','k',...
                'VerticalAlignment','bottom');
            idx = idx + 1;            
        end
    end    
end