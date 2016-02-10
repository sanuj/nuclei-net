clc
clear all
% xml_file='78_RLM_YR4.xml';
xml_file='image_test.xml';
% origin_x = 10144; 78
% origin_y = 19261;
%th=50;
origin_x = 847;
origin_y = 397;
th = 0;


image = imread('image_test.jpg');
[im_height, im_width, im_channel] = size(image);
% return;
count=0;
xDoc = xmlread(xml_file);
Regions=xDoc.getElementsByTagName('Region'); % get a list of all the region tags
for regioni = 0:Regions.getLength-1
    Region=Regions.item(regioni);  % for each region tag
    verticies=Region.getElementsByTagName('Vertex'); %get a list of all the vertexes (which are in order)
    xy{regioni+1}=zeros(verticies.getLength-1,2); %allocate space for them
    for vertexi = 0:verticies.getLength-1 %iterate through all verticies
        x=str2double(verticies.item(vertexi).getAttribute('X')); %get the x value of that vertex
        y=str2double(verticies.item(vertexi).getAttribute('Y')); %get the y value of that vertex
        x = x-origin_x;
        y = y-origin_y;
        if (x+th>=0) && (x-th<=im_width) && (y+th>=0) && (y-th<=im_height)
            if(x<0) x=0; end
            if(y<0) y=0; end
            if(x>im_width) x=im_width; end
            if(y>im_height) y=im_height; end         
            xy{regioni+1}(vertexi+1,:)=[x,y]; % finally save them into the array
        end
    end 
end

figure,hold all
set(gca,'YDir','reverse'); %invert y axis
% for zz=1:length(xy)
%     plot(xy{zz}(:,1),xy{zz}(:,2),'LineWidth',12)
% end

% svsinfo=imfinfo(svs_file);

% s=1; %base level of maximum resolution
% s2=2; % down sampling of 1:32
%hratio=svsinfo(s2).Height/svsinfo(s).Height;  %determine ratio
%wratio=svsinfo(s2).Width/svsinfo(s).Width;
%SE = strel('diamond', 5);
SE=[0 1 0 ; 1 1 1 ; 0 1 0 ];
nrow=im_height;
ncol=im_width;
mask1=zeros(nrow,ncol); %pre-allocate a mask
mask2=zeros(nrow,ncol); %pre-allocate a mask
final=zeros(nrow,ncol); %pre-allocate a mask
for zz=1:length(xy) %for each region
    count=count+1;
    smaller_x=xy{zz}(:,1); %down sample the region using the ratio
    smaller_y=xy{zz}(:,2);
    im = zeros(nrow, ncol);
    t = poly2mask(smaller_x,smaller_y,nrow,ncol);
    t_d=imdilate(t,SE);
    t_e=imerode(t,SE);
    mask1=mask1+t_d-t_e; %to get the boundary
    mask2=mask2+t;%make a mask and add it to the current mask
    %this addition makes it obvious when more than 1  layer overlap each
    %other, can be changed to simply an OR depending on application.
end
% for i=1:im_height
%     for j=1:im_width
%         if mask1(i,j) > 0
%             mask1(i,j)=.5;
%         end
%     end
% end

for i=1:im_height
    for j=1:im_width
        if (mask1(i,j) > 0 & mask2(i,j) > 0)
            final(i,j)=.5;
        elseif(mask1(i,j) > 0 & mask2(i,j) == 0)
            final(i,j)=.5;
        elseif (mask2(i,j) >0 & mask1(i,j)==0)
            final(i,j)=1;
        
        else final(i,j)=0;
        end
    end
end
% img(:,:,1)=final;
% img(:,:,2)=final;
% img(:,:,3)=final;
imwrite(final,'ternary_map.png');



