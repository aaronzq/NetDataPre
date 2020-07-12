function crop_raw_stack(substack_depth, overlap, dx, Nnum, range_adjust, z_sampling, ...
    rotation_step, rectification_enable, rotation_enable, save_path)
% CROP_RAW_STACK crops the HR data in depth and augments the dataset
%   crop_raw_stack(substack_depth, overlap, dx, Nnum, range_adjust, z_sampling, ...
%                   rotation_step, rectification_enale, rotation_enable)
%   Inputs:
%     substack_depth - int, number of slices of each substack
%     overlap - double 0-1, overlap of each substack
%     dx - double, the number of pixels behind each lenslet, it comes from LFDisplay
%     Nnum - int, output number of pixels behind each lenslet
%     range_adjust - double 0-1, scale the dynamic range
%     z_sampling - int, downsample ratio of depth
%     rotation_step - double, increment of the rotation in degree
%     rectification_enable - enable the rectification of lf raw image
%     rotation_enable - enable the rotation




overlap_slice = floor(overlap * substack_depth);

[file_name,file_path] = uigetfile('*.tif','Select Original Stacks','MultiSelect','on');
if ~iscell(file_name)
    file_name = {file_name};
end
file_num = size(file_name,2);

for n=1:file_num
    save_name = file_name{n};
    save_name = save_name(1:end-4);

    file = fullfile(file_path,file_name{n});
    depth = numel(imfinfo(file));
    [original_stack,row,col] = read_stack(file,depth,1);

    sampled_stack = original_stack(:,:,1:z_sampling:depth); 
    % todo: extend z sampling to a double ratio
    depth = size(sampled_stack,3);

    for angle = 0 : rotation_step : (179*rotation_enable)

        rotated_stack = imrotate(sampled_stack, angle, 'bicubic', 'loose');
        substack_num = ceil((depth-substack_depth)/(substack_depth-overlap_slice)) + 1;   % when Overlap = 0 and depth = SubStackDepth, subStackNum = 1; No Wrap;
        for nn = 1:substack_num
            tic;
            s = 1 + (nn-1)*(substack_depth-overlap_slice);
            e = s + substack_depth - 1;
            if e > depth   % Wrap the last SubStack
                s = s - (e - depth);
                e = depth;
            end
            substack = rotated_stack(:,:,s:e);
            if rectification_enable
                xCenter = col/2;   
                yCenter = row/2;
                rectified_stack = VolumeRectify(substack,xCenter,yCenter,dx,Nnum,depth);
            else
                rectified_stack = substack;
            end        
            rectified_stack = (rectified_stack ./ max(rectified_stack(:))) .* range_adjust .* 255.0;
            substack_name = sprintf('%s_Angle%03d_SUB%02d.tif', save_name, angle, nn);
            save_stack(rectified_stack, [save_path '/' substack_name]);
            disp([substack_name ' ... ' '  done  ' ' in ' num2str(toc) ' sec']);
        end

    end
end



end