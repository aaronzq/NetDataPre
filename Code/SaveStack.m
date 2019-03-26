%% Save stacks in uint8

function SaveStack(filename,stacks)
    stacks = uint8(stacks);
    depth = size(stacks,3);
    imwrite(stacks(:,:,1),filename);
    for d = 2:depth
        img = stacks(:,:,d);
        imwrite(img,filename,'WriteMode','append');
    end
end