%% Multi Stacks Light Field Forward Projection
% DownSample is a switch for whether to downsample the original volume according to Nnum
% The Stacks slice number should correspond to the depth of PSF
% Input: uint8 tif stacks

clear all;

%%%%%%%%%%%%%%%%%%%%% Downsampling for Nnum %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DownSample = 0;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if exist('fileAddr','var')~=1
    if exist('fileAddr.mat','file')~=2
        fileAddr = '\LFRNet\Celegans';
    else
        load('./fileAddr.mat');
    end
end

[file_name,filepath] = uigetfile('*.tif','Select Stacks','MultiSelect','on',fileAddr);
if ~iscell(file_name)
    file_name = {file_name};
end
StacksNum = size(file_name,2)
NameIndex = strfind(filepath,'WF');
Name_Com = filepath(NameIndex(1)+2:end);
Addr_Com = filepath(1:NameIndex(1)-1);

% NameIndex = find(filepath == '\');
% Name_Com = filepath(NameIndex(end-1)+1:end-1);
% Addr_Com = filepath(1:NameIndex(end-2));

PSF_path = '../Data/PSFmatrix';
RectVolume_path = [Addr_Com 'LF\Rect' Name_Com];  % fullfile 
RawLF_path = [Addr_Com 'LF' Name_Com ];


if exist(RectVolume_path,'dir')~=7
    mkdir(RectVolume_path);
end
if exist(RawLF_path,'dir')~=7
    mkdir(RawLF_path);
end


%%%%%%%%%%%%%%%%%%%% psf custimized %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[psf_name,psfpath] = uigetfile('*.mat','Select PSF','MultiSelect','off',PSF_path);

% PSF_file = '/PSFmatrix_M40NA0.85MLPitch150fml3500from-30to30zspacing2Nnum11lambda518n1.515.mat';
% xCenter             = 995.023000;   
% yCenter             = 1028.972000;
xCenter             = 657.0;   
yCenter             = 661.0;
dx                  = 23.455000;  %% as long as the MLA pitch is 150um, dx is around 150/6.5 = 23
beginning_index = 1;  %%minimum = 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp([ 'Loading LF_PSF...' ]);
[LFpsf,psf_h,psf_w,psf_d,Nnum,CAindex] = readPSF([psfpath, psf_name]);
disp(['LF_PSF has been loaded. Size: ' num2str(psf_h) 'x' num2str(psf_w) 'x' num2str(Nnum) 'x' num2str(Nnum) 'x' num2str(psf_d) '.']);
depth = psf_d;

for n = 1:StacksNum
    tic;
    volume = VolumeRectification([filepath file_name{n}],xCenter,yCenter,dx,Nnum,depth,beginning_index,RectVolume_path,n,DownSample);
    volume_unit8 = uint8(volume);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    volume_dims = size(volume);
    stacks = zeros(volume_dims);
    center = floor(Nnum/2) + 1;

    for d = 1 : depth  %stack
        for i = 1 : Nnum
            for j = 1 : Nnum
                sub_region =  zeros(volume_dims(1),volume_dims(2));
                sub_region(i: Nnum: end,j: Nnum: end) = volume(i: Nnum: end, j: Nnum: end, d);
%                 sub_psf = LFpsf(:, :, i, j, d);
                sub_psf = squeeze(LFpsf( CAindex(d,1):CAindex(d,2), CAindex(d,1):CAindex(d,2) ,i,j,d));
                sub_psf = sub_psf/sum(sub_psf(:));
                sub_out = conv2(sub_region,sub_psf,'same');
                stacks(:, :, d) = stacks(:, :, d) + sub_out;
            end
        end
    end
    LF_raw  = (sum(stacks , 3))./6;% ./ depth;
    LF_raw = uint8(LF_raw);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%     disp(['Saving Image...']);
%     namestring = sprintf('/LF_simulatedX%03d.tif',n);
    imwrite(LF_raw, [RawLF_path '/' file_name{n}]);
    disp( ['Projected Image : ' file_name{n}   ' ... ' num2str(toc) 'sec' ] );
end
disp(['Done']);

