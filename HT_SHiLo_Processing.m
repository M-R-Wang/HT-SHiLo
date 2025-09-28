% HT-SHiLo algorithm for processing OS-SIM data.
% Data acquisition Requirements: Two π-phase-shifted fringe projection images for each layer (z-plane).
% Required MATLAB Version: R2022a or later
%% Read Images
% The format of raw images is required as 3D stack: The first two
% dimensions represent X and Y, while in the third dimension, the (2i-1)-th
% index and (2i)-th index correspond to Phase 1 and Phase 2 of the i-th
% layer, respectively.
ImageName = 'OS-SIM data\BPAEC_60X1.49NA_488.tif';
Images = tiffreadVolume(ImageName);
%% Set Parameters
Parameters.StripePeriod = 4; % Period of the stripe in raw images (unit: pixels)
Parameters.PixelSize = 0.1; % unit: μm
Parameters.ZStep = 0.3; % unit: μm
Parameters.NA = 1.49; % NA of objective lens
Parameters.StripeDirection = 'Horizontal'; % Direction of the stripe in raw images, specified as 'Vertical' or 'Horizontal'
%% HT-SHiLo Processing
OS_HT_SHiLo = HT_SHiLo(Images,Parameters);
%% Write Opical Sectioning Images
StackName = [ImageName(1:end-4),'_OS.tif'];
if exist(StackName,"file")
    delete(StackName)
end
for i = 1:size(OS_HT_SHiLo,3)
    % Save optical sectioning images in 16-bit format. Use im2uint8 instead to save the images as 8-bit.
    imwrite(im2uint16(OS_HT_SHiLo(:,:,i)),StackName,'WriteMode','append')
end