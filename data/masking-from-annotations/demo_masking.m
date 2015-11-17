svs_file='63_LLM_YR4_001.svs';
xml_file='63_LLM_YR4_001.xml';


xDoc = xmlread(xml_file);
Regions=xDoc.getElementsByTagName('Region'); % get a list of all the region tags
for regioni = 0:Regions.getLength-1
    Region=Regions.item(regioni);  % for each region tag
    verticies=Region.getElementsByTagName('Vertex'); %get a list of all the vertexes (which are in order)
    xy{regioni+1}=zeros(verticies.getLength-1,2); %allocate space for them
    for vertexi = 0:verticies.getLength-1 %iterate through all verticies
        x=str2double(verticies.item(vertexi).getAttribute('X')); %get the x value of that vertex
        y=str2double(verticies.item(vertexi).getAttribute('Y')); %get the y value of that vertex
        xy{regioni+1}(vertexi+1,:)=[x,y]; % finally save them into the array
    end 
end

figure,hold all
set(gca,'YDir','reverse'); %invert y axis
for zz=1:length(xy)
    plot(xy{zz}(:,1),xy{zz}(:,2),'LineWidth',12)
end

svsinfo=imfinfo(svs_file);

s=1; %base level of maximum resolution
s2=2; % down sampling of 1:32
%hratio=svsinfo(s2).Height/svsinfo(s).Height;  %determine ratio
%wratio=svsinfo(s2).Width/svsinfo(s).Width;

hratio=1;
wratio=1;

nrow=svsinfo(s2).Height;
ncol=svsinfo(s2).Width;
mask=zeros(nrow,ncol, 3); %pre-allocate a mask
for zz=1:length(xy) %for each region
    smaller_x=xy{zz}(:,1)*wratio; %down sample the region using the ratio
    smaller_y=xy{zz}(:,2)*hratio;
    im = zeros(nrow, ncol, 3);
    t = poly2mask(smaller_x,smaller_y,nrow,ncol);
    im(:,:,1) = rand*t;
    im(:,:,2) = rand*t;
    im(:,:,3) = rand*t;
    mask=mask+im; %make a mask and add it to the current mask
    %this addition makes it obvious when more than 1  layer overlap each
    %other, can be changed to simply an OR depending on application.
end

io=imread(svs_file,'Index',s2);
subplot(1,2,1)
imshow(io)
subplot(1,2,2)
%mask=uint8(mask);
imshow(mask)