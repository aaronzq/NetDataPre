function crop_time_series_3d(cropped_size, overlap, series_path, save_path, save_all, pixel_threshold, var_threshold)

%%% ============================= %%%
% % crop 3-D time series into training data
%%% ============================= %%%


% %=============================== % %
% %user defined parameters
%cropped_size = 176;
%overlap = 0.5;

wrap_content = false;
%save_all = false;
%pixel_threshold = 7e6;
%var_threshold = 7e2;

abandon_threshold = 0.3;
% %================================ %%


overlap_px = floor(overlap .* cropped_size);
step_size = cropped_size - overlap_px;


% series_path = uigetdir(pwd, 'choose a folder containing time-series ...');
% if series_path == 0
%     return
% end

folder_list = dir(series_path);
n_series = length(folder_list);


n_series_gen = 0;
% save_dir = sprintf('\\HR3d_cropped%d_overlap%2.1f', cropped_size, overlap);
% mkdir(series_path, save_dir);

abandoned_list = [];
abandoned_num = zeros(ceil(2018/(step_size(1))) * n_series, 1); %% 2018/(step) * n_series = maximum num of series that may be generated

if save_all
    if mod(n_series, 2) == 1
        interval = floor((n_series - 2) / 2);
    else 
        interval = floor((n_series - 3) / 2);
    end
else
    interval = 1;
end

for i = 3 : interval :n_series
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
        frame = imread3d(frame_file_name);
        [height, width, depth] = size(frame);
        
        % cut image
        n_blocks_in_current_frame = 0;
        for h = 1 : step_size(1) : height
            if h > height-cropped_size(1) +1
                if wrap_content
                    h = height - cropped_size(1) + 1;
                else
                    break;
                end
            end
            
            for w = 1 : step_size(2) : width
                if w > width - cropped_size(2) + 1
                    if wrap_content
                        w = width - cropped_size(2) + 1;
                    else
                        break;
                    end
                end
                
                %fprintf('processing img %d / %d : ', n, file_num)
                
                h2 = h + cropped_size(1) - 1;
                w2 = w + cropped_size(2) - 1;
                
                block = frame(h : h2, w : w2, :);
                
                block_id = sprintf('%06d-%06d.tif', n_series_gen + n_blocks_in_current_frame, f-2);
                pixel_sum = sum(block(:));
                pixel_var = var(double(block(:)));
                
                if ~save_all
                    if pixel_sum > pixel_threshold && pixel_var > var_threshold
                        fprintf('sum %d var %d : saved as %s\n', pixel_sum, pixel_var, block_id)
                        write3d(block, [save_path '\\' block_id]);
                    else
                        abandoned_num(n_series_gen + n_blocks_in_current_frame + 1) = abandoned_num(n_series_gen + n_blocks_in_current_frame + 1) + 1;
                        fprintf('sum %d var %d : abandoned\n', pixel_sum, pixel_var)
                    end
                else  % save all blocks , no matter valid or not
                    fprintf('sum %d var %d : saved as %s', pixel_sum, pixel_var, block_id)
                    write3d(block, [save_path '\\' block_id]);
                    fprintf('\n')
                    
                end
                n_blocks_in_current_frame = n_blocks_in_current_frame + 1;
            end
            
        end
        
    end
    n_series_gen = n_series_gen + n_blocks_in_current_frame;
    
    
end

if ~save_all
    
    for m = 1 : n_series_gen
        if abandoned_num(m, 1) >= floor(n_frames_per_series * abandon_threshold)
            abandoned_list = [abandoned_list; sprintf('%06d', m-1)];
        end
    end
    save('abandoned_list.mat', 'abandoned_list');
    
    [num, ~] = size(abandoned_list);
    for i = 1 : num
        delete(fullfile(save_path, sprintf('%s-*', abandoned_list(i, :) )));
        fprintf('deleting %s-*...\n', abandoned_list(i, :))
    end
end

