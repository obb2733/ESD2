% Oran Betz
% serveBall.m

clc;
clear all;
close all;

%Initialization Parameters
server_ip   = '127.0.0.1';     %IP address of the Unity Server
server_port = 55001;           %Server Port of the Unity Sever

client = tcpclient(server_ip,server_port,"Timeout",20);
fprintf(1,"Connected to server\n");

width = 752;
height = 480;
i = 1;
ballPOS = zeros(3,5);
image1Array = zeros(480,752,3,5,'uint8');
image2Array = zeros(480,752,3,5,'uint8');
for counter = 3:0.5:5
    % Move Ball to Selected Depth Value
    blenderLink(client,width,height,(8-counter),8.55,0.55,45,0,0,"tennisBall");
    % Grab Images From Blender
    image = blenderLink(client,width,height,7.25,8.25,0.65,90,0,90,"Camera");
    image2 = blenderLink(client,width,height,7.25,8.85,0.65,90,0,90,"Camera");
    %imagesc(image)
    imagesc(image2)
    ballPOS(:,i) = [8-counter 8.55 0.55];
    image1Array(:,:,:,i) = image;
    image2Array(:,:,:,i) = image2;
    i = i+1;
    set(gcf, 'Position', get(0, 'Screensize'));
    axis off
end
