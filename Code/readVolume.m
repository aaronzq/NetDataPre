%% Read the 3D tif forwardly from the beginning_index and for depth stacks

function [volume,row,col] = readVolume(img,depth,beginning_index)
   imtest = imread(img);
   [row,col] = size(imtest);
    volume = zeros(row,col,depth);
    for d = 1:depth
        stack = imread(img,'Index',d+beginning_index-1);
        volume(:,:,d) = stack;
    end
end