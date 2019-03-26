% % delete invalid blocks

load('crop3dparams.mat');

% path = 'zebrafish_heart\cropped64X64X16_overlap0.25-0.25-0.25';
path = uigetdir(pwd, 'directory of files to be screened');
for i = 1 : length(abandoned_list)
    delete(fullfile(path, abandoned_list(i, :)));
    fprintf('deleting %s ...\n', abandoned_list(i, :))
end