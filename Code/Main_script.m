
%%%%%%%%%%%%%%%%%%%%%%%%% Substacks Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
substack_depth = 61;
overlap = 0.5;
z_sampling = 1;
dx = 23.265; 
Nnum = 11;
range_adjust = 0.77;
rotation_step = 60;

rectification_enable = 1;
rotation_enable = 1;
complement_stack = 1;
flip_x = 0;
flip_y = 0;
flip_z = 0;

save_path = '../Data/Substacks';
file_path = 'C:\Users\zqwang\Downloads\test_data';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file_name = struct2cell(dir(file_path));
file_name = file_name(1,3:end);
if ~iscell(file_name)
    file_name = {file_name};
end

crop_raw_stack(substack_depth, overlap, dx, Nnum, range_adjust, z_sampling, ...
    rotation_step, rectification_enable, rotation_enable, complement_stack, ...
    flip_x, flip_y, flip_z, file_path, file_name, save_path);

disp('Rectify and Augment HR data ... done');



%%%%%%%%%%%%%%%%%%%%%%%%% Projection Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
brightness_adjust = 0.005;
poisson_noise = 0;
gaussian_noise = 0;
gaussian_sigma = 5e-5;
gpu = 0;

source_path = '../Data/Substacks';
save_path = '../Data/LFforward';

psf_name = 'PSFmatrix_M40NA0.8MLPitch150fml3500from-30to30zspacing1Nnum11lambda518n1.33.mat';
psf_path = 'C:\Users\zqwang\Documents\Repos\MATLAB\NetDataPre\NetDataPre\PSFmatrix\';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

forward_projection([psf_path, psf_name], poisson_noise, gaussian_noise, gaussian_sigma,...
    brightness_adjust, gpu, source_path, save_path);

disp(['Forward Projection ... Done']);


%%%%%%%%%%%%%%%%%%%%%%%%%%Crop Parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cropped_size = [176,176,substack_depth];
overlap = [0.5,0.5,0.];
pixel_threshold = 1e5;
var_threshold   = 1e0;
save_all = 0;

source_path_3d = '../Data/Substacks';
save_path_3d = '../Data/TrainingPair/WF';
source_path_2d = '../Data/LFforward';
save_path_2d = '../Data/TrainingPair/LF';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

generate_patches(cropped_size, overlap, pixel_threshold, var_threshold, ...
    save_all, source_path_3d, save_path_3d, source_path_2d, save_path_2d)

disp('Crop ...Done');



