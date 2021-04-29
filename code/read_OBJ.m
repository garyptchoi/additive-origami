function [points, quads] = read_OBJ(filename)


    fid = fopen(filename, 'r');
    
    % get the first line
    tline = fgetl(fid);
    tline = strsplit(tline);
    
    
    
    
    num_points = str2num(cell2mat(tline(2)));
    num_faces = str2num(cell2mat(tline(4)));
    
    
   
    points = [];
    for i = 1:num_points
        tline = fgetl(fid);
        tline = strsplit(tline);
        points = [points; str2num(cell2mat(tline(2))) str2num(cell2mat(tline(3))) str2num(cell2mat(tline(4)))];
    end
    
    
    quads = [];
    for i = 1:num_faces
        tline = fgetl(fid);
        tline = strsplit(tline,{' ','//'},'CollapseDelimiters',true);
        
        nums = [];
        for j = 1:size(tline,2)
            
            this_num = str2num(cell2mat(tline(j)));
            
            if min(size(this_num)) > 0
                
                nums = [nums this_num];
                
            end
            
            
            
        end
        
        % only keep quads
        if size(nums,2) == 4
                               
                quads = [quads; nums];
           
        else
            
            size(nums,2)
            
        end
        %quads = [quads; nums];
    end
    
    
    fclose(fid);
    
  
    
    
    
    
    
    

end

