function [Detections] = AprilTag(image,alg,debug)
%addpath('gradient_src','threshold_src','common_src');
Pose = []; Detections = [];
if(nargin < 3)
    debug = 0;
end

if(nargin < 2)
    alg = 3;
end

% if(debug == 1)
%     figure('Name','Original Image');
%     imshow(image);
%     title('Original Image');
% end

%Constants
TagSize = 0.166;
Fx = 420;
Fy = 420;

%Preprocessing to Grayscale
if(ndims(image) > 2)
    image_gray = cvtColor(image);
else
    image_gray = single(image);
end

width = size(image_gray,2);
Px = width/2;
height = size(image_gray,1);
Py = height/2;

if(debug == 1)
figure('Name','Preprocessing: Grayscale');
imshow(image_gray);
title('Preprocessing: Grayscale');
    thisdir = getOutputdir();
    saveas(gca,[thisdir,'\','Grayscale']);
end

%Stage 1: Gaussian Blurring (Without toolbox)
% G = fspecial('gaussian',3,0.8); %Generate Gausian Filter
G = [0.0571, 0.1248 ,0.0571;
     0.1248, 0.2725, 0.1248;
     0.0571, 0.1248 ,0.0571];
image_blurred = conv2(image_gray,G,'same'); %Convolve across image


%Displaying the results of blurring
if(debug == 1)
figure('Name','Stage 1:Gaussian Blurring');
imshow(image_blurred);
title('Stage 1:Gaussian Blurring');
end

switch alg
    case 1
		quads = quad_gradient(image_blurred,image_gray,debug);
    case 2
		quads = quad_thresh(image_blurred,image_gray,debug);
    case 3
		quads = quad_ravven(image_blurred,image_gray,debug);
    case 4
		quads = quad_ravven2(image_blurred,image_gray,debug);
    case 5
		quads = quad_ravven3(image_blurred,image_gray,debug);
    case 6
		quads = quad_ravven4(image_blurred,image_gray,debug);
    otherwise
        disp('Please select a valid option');
end

%Stage 8: Decode Quads
Detections = DecodeQuad(quads,image_gray,0);

%Stage 9: Remove Duplicates
Detections = RemoveDuplicates(Detections);

% stats = [size(quads,1),size(Detections,1)];

%Stage 10?: Decode Pose From Detections
Pose = PoseDecoding(Detections,TagSize,Fx,Fy,Px,Py);

[Detections(:).Pose] = Pose(:);

% if(debug == 1)
% sprintf('I found %i tag(s)\n',size(Detections,1))
% for NumDet = 1:size(Detections)
%     sprintf('Id:%i (Hamming: %i)',Detections(NumDet).id,Detections(NumDet).HD)
%     sprintf('distance=%5fm, x=%5f, y=%5f, z=%5f, pitch=%5f, roll=%5f, yaw=%5f',...
%         Pose(NumDet).dist,Pose(NumDet).x,Pose(NumDet).y,Pose(NumDet).z,...
%         Pose(NumDet).pitch,Pose(NumDet).roll,Pose(NumDet).yaw)
% end
% end

if(debug == 1)
    %Debug visualization
    figure('Name','Detected Tags');
    imshow(image);
    title('Detected Tags');
    hold on;
    for i = 1:length(Detections)
        plot(Detections(i).QuadPts(1:2,1),Detections(i).QuadPts(1:2,2),'g-','LineWidth',2);
        plot(Detections(i).QuadPts(2:3,1),Detections(i).QuadPts(2:3,2),'r-','LineWidth',2);
        plot(Detections(i).QuadPts(3:4,1),Detections(i).QuadPts(3:4,2),'m-','LineWidth',2);
        plot(Detections(i).QuadPts([4,1],1),Detections(i).QuadPts([4,1],2),'b-','LineWidth',2);
        scatter(Detections(i).cxy(1),Detections(i).cxy(2),100,'r','LineWidth',2);
        text(Detections(i).cxy(1)+10,Detections(i).cxy(2)+5,sprintf('#%i',Detections(i).id),'color','r');
    end
    hold off;
        thisdir = getOutputdir();
    saveas(gca,[thisdir,'\','Detections']);
end

end

%These are helper / utility functions

function GrayImage = cvtColor(InputImage)
RedConv   = single(InputImage(:,:,1) *  0.299);
GreenConv = single(InputImage(:,:,2) *  0.587);
BlueConv  = single(InputImage(:,:,3) *  0.114);

GrayImage = RedConv + GreenConv + BlueConv;
GrayImage = GrayImage / 255;
end

function output = NormalizeVals(input,Max,Min)
    switch nargin
        case 1
            output = (input-min(input(:)))./(max(input(:))-min(input(:)));
        otherwise
            output = (input-Min)./(Max-Min);
    end
end

function longArray = ArraytoList(Array)
%Turns a NxM array into a 1xN*M list 
Width = size(Array,2);
Height  = size(Array,1);

longArray = zeros(1,Width*Height);
for i = 1:Height
    StartIdx = ((i-1) * Width)+1;
    EndIdx   = (StartIdx + Width)-1;
    longArray(1,StartIdx:EndIdx) = Array(i,:);
end
end

function dir = getOutputdir
global outputdir
dir = outputdir;
end

function Error = PercentError(Correct,Experimental)
difference = Experimental - Correct;
Error = abs(difference./Correct);
end