xml_file='78_RLM_YR4.xml';
origin_x = 10144;
origin_y = 19261;
th = 50;

image = imread('78_RLM_YR4.jpg');
[im_height, im_width, im_channel] = size(image);
% return;

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

nrow=im_height;
ncol=im_width;
mask=zeros(nrow,ncol); %pre-allocate a mask
for zz=1:length(xy) %for each region
    smaller_x=xy{zz}(:,1); %down sample the region using the ratio
    smaller_y=xy{zz}(:,2);
    im = zeros(nrow, ncol);
    t = poly2mask(smaller_x,smaller_y,nrow,ncol);
    mask=mask+t; %make a mask and add it to the current mask
    %this addition makes it obvious when more than 1  layer overlap each
    %other, can be changed to simply an OR depending on application.
end

% subplot(1,2,1)
% imshow(image)
% subplot(1,2,2)
%mask=uint8(mask);
imshow(mask)
imwrite(mask, 'bm_78_RLM_YR4.jpg');