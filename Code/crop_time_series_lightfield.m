function crop_time_series_lightfield(cropped_size, overlap, series_path, save_path)

%cropped_size = 176;
%overlap = 0.5;

wrap_content = false;

% series_path = uigetdir(pwd, 'choose a folder containing time-series ...');
% if series_path == 0
%     return
% end

overlap_px = floor(overlap * cropped_size);
if mod(overlap_px, 2) == 1
    overlap_px = overlap_px + 1;
end

folder_list = dir(series_path);
n_series = length(folder_list);


n_series_gen = 0;
% save_dir = sprintf('\\LF_cropped%d_overlap%2.1f', cropped_size, overlap);
% mkdir(series_path, save_dir);

step = cropped_size - overlap_px;
for i = 3 : n_series
    if ~(folder_list(i).isdir) || ~isempty(strfind(folder_list(i).name, 'cropped'))
        continue;
    end
    
    frames_path = fullfile(series_path, folder_list(i).name);
    frames_list = dir(frames_path);
    n_frames_per_series = length(frames_list);
    if n_frames_per_series < 3
        continue;
    end
    for f = 3 : n_frames_per_series
        if isempty(strfind(frames_list(f).name, '.tif')) 
            continue;
        end
        frame_file_name = fullfile(frames_path, frames_list(f).name);
        frame = imread(frame_file_name);
        [height, width] = size(frame);
        
        % cut image
        n_patches_in_one_frame = 0;
        for h = 1 : step : height
            if h > height-cropped_size+1
                if wrap_content
                    h = height - cropped_size + 1;
                else
                    break;
                end
            end
            
            for w = 1 : step : width
                if w > width-cropped_size+1
                    if wrap_content
                        w = width - cropped_size + 1;
                    else
                        break;
                    end
                end
                
                %fprintf('processing img %d / %d : ', n, file_num)
                
                h2 = h + cropped_size - 1;
                w2 = w + cropped_size - 1;
                
                
                patch = frame(h : h2, w : w2);
                
                patch_id = sprintf('%06d-%06d.tif', n_series_gen + n_patches_in_one_frame, f-2);
                
                write3d(patch, [save_path '\\' patch_id]);
                %fprintf('\n')
                n_patches_in_one_frame = n_patches_in_one_frame + 1;
            end
            
        end
        
    end
    n_series_gen = n_series_gen + n_patches_in_one_frame;
end   

% % delete invalid patches 
load('abandoned_list.mat');

[num, ~] = size(abandoned_list);
for i = 1 : num
    delete(fullfile(save_path, sprintf('%s-*', abandoned_list(i, :) )));
    fprintf('deleting %s-*...\n', abandoned_list(i, :))
end
    