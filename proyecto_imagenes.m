i=imread('cancer_celulas.png');
ig = rgb2gray(i);
%umbral=graythresh(ig);
%ib=imbinarize(ig,0.3);
%ib = 1 - ib;
%se = strel('disk',4);
%ie = imerode(ib,se);
%ib5 = edge(ib,'Canny');
%se = strel('disk',4);
%ie = imdilate(ib5,se);
%ie = imerode(ie,se);
%ie = bwmorph(ib5,'bridge');
%ie = ib - ie;
iGT = imread('hands1-mask.png');

umbral=graythresh(ig);
iSeg=imcomplement(im2bw(ig,umbral));

sim=dice(iSeg,iGT);

figure, 
subplot(1,2,1), imshow(i), title('original'); 
titulo=['umbral Otsu = ' int2str(umbral*255)];
subplot(1,2,2), imshow(ie), title(titulo);

