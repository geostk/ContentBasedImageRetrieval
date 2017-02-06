function search_images_SURF(path)
% Example 3, Affine registration
% Load images
%d=dir('C:\Users\akshay\Desktop\project implementation\OpenSURF_version1c\*.jpg');
%abhi=cell(1,length(d));
%for i=1:length(d)
 %   abhi{i}=d(i).name;
%end
source=load('model1');
nsize=length(source.ipts_db);
figure(2)
I1=imread(path);

subplot(2,2,1);imshow(I1);title('image result...\n');        
%I2=im2double(imread('TestImages/lena2.png'));
image_s=size(I1);
nr=image_s(1);
nc=image_s(2);
% Get the Key Points
Options.upright=true;
Options.tresh=0.0001;
Ipts1=OpenSurf(I1,Options);
result=zeros(1,nsize);
p=1;
for start=1:nsize
    a1=source.files{start};
    I2=imread(a1);
    Ipts2=source.ipts_db{start};
    %fprintf('Computing 3-D (HSV) histogram for each image in db...\n');
    
subplot(2,2,2);imshow(I2);
title(a1);        
drawnow
    %display(abhi{i});
    %display(size(a));
    %I2=imresize(I2,[nr nc]);


    %Ipts2=OpenSurf(I2,Options);

% Put the landmark descriptors in a matrix
D1 = reshape([Ipts1.descriptor],64,[]);
D2 = reshape([Ipts2.descriptor],64,[]);
a1
% Find the best matches
err=zeros(1,length(Ipts1));
cor1=1:length(Ipts1);
cor2=zeros(1,length(Ipts1));
for i=1:length(Ipts1),
    distance=sum((D2-repmat(D1(:,i),[1 length(Ipts2)])).^2,1);
    [err(i),cor2(i)]=min(distance);
end
count=0;
for i=1:length(Ipts1)
    if(err(i)<0.3)
        count=count+1;
    end
end

% Sort matches on vector distance
%[err, ind]=sort(err);
%cor1=cor1(ind);
%cor2=cor2(ind);

% Make vectors with the coordinates of the best matches
%Pos1=[[Ipts1(cor1).y]',[Ipts1(cor1).x]'];
%Pos2=[[Ipts2(cor2).y]',[Ipts2(cor2).x]'];
%Pos1=Pos1(1:30,:);
%Pos2=Pos2(1:30,:);

% Show both images
%I = zeros([size(I1,1) size(I1,2)*2 size(I1,3)]);
%I(:,1:size(I1,2),:)=I1; I(:,size(I1,2)+1:size(I1,2)+size(I2,2),:)=I2;
%figure, imshow(I); hold on;

% Show the best matches
%plot([Pos1(:,2) Pos2(:,2)+size(I1,2)]',[Pos1(:,1) Pos2(:,1)]','-');
%plot([Pos1(:,2) Pos2(:,2)+size(I1,2)]',[Pos1(:,1) Pos2(:,1)]','o');

% Calculate affine matrix
%Pos1(:,3)=1; Pos2(:,3)=1;
%M=Pos1'/Pos2';

% Add subfunctions to Matlab Search path
functionname='OpenSurf.m';
functiondir=which(functionname);
functiondir=functiondir(1:end-length(functionname));
addpath([functiondir '/WarpFunctions'])

% Warp the image
%I1_warped=affine_warp(I1,M,'bicubic');

% Show the result
%figure,
%subplot(1,3,1), imshow(I1);title('Figure 1');
%subplot(1,3,2), imshow(I2);title('Figure 2');
%subplot(1,3,3), imshow(I1_warped);title('Warped Figure 1');
%display(det(M));
%count
%length(Ipts1)

count/length(Ipts1)
result(p)=count/length(Ipts1);
p=p+1;

end
rank_SURF(result,path);

end