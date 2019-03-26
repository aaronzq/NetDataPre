
depth = 16;     %original vol's depth
tarDepth = 31;   %the depth of capacity to contain the original vol
tarPos = [1:16];  %the position to put the original vol in capacity
                    % e.g.  for psf in [-30,0], and capacity in [-30,30],
                    %       and step as 2, tarPos = [1:16]
                    %       for psf in [-10,20], and capacity in [-30,30],
                    %       and step as 2, tarPos = [11:26]
psfindex = 0;
volsPath = '../Data/TrainingPair/WF';
LFsPath = '../Data/TrainingPair/LF';
saveVolsPath = '../Data/TrainingPair/Collection20X/WF';
saveLFsPath = '../Data/TrainingPair/Collection20X/LF';

if exist('saveVolsPath','dir') ~= 7
    mkdir(saveVolsPath);
end
if exist('saveLFsPath','dir') ~= 7
    mkdir(saveLFsPath);
end

volsDir = dir(volsPath);
volsNum = size(volsDir,1);
for n = 3:volsNum
    tic;
    [vol,row,col] = readVolume(fullfile(volsPath,volsDir(n).name),depth,1);
    cap = zeros(row,col,tarDepth);
    cap(:,:,tarPos) = vol;
    SaveStack(fullfile(saveVolsPath,sprintf('%s-%02d.tif',volsDir(n).name(1:end-4),psfindex)),cap);
    lf = imread(fullfile(LFsPath,volsDir(n).name));
    imwrite(lf,fullfile(saveLFsPath,sprintf('%s-%02d.tif',volsDir(n).name(1:end-4),psfindex)));
    disp([sprintf('%s-%02d.tif',volsDir(n).name(1:end-4),psfindex) '...done...' num2str(toc) 'sec']);
end
disp('done');