%i=imread('datos prueba\RGB-Images\Placa1-imagen1.jpg');
i=imread('celulas_cancer.png');
%i=imread('cancer\162-CPDAI-13-IDA-3-30.jpg');
ir = i(:,:,1);
ig = i(:,:,2);
ib = i(:,:,3);
icolor = 255 - (ib - fix(ir/2) - fix(ig/2));
ig = rgb2gray(i);
ig2 = 255 - ig;
%se = strel('disk',3);
%ie = imerode(ig,se);
icon = adapthisteq(ig,'clipLimit',0.02,'Distribution','rayleigh');
icon2 = adapthisteq(ig2,'clipLimit',0.02,'Distribution','rayleigh');
umbral=graythresh(icon);
ib=imbinarize(icon,umbral);
umbral2=graythresh(icon2);
ib2=imbinarize(icon2,umbral2);
ibf = (1 - ib)- ib2;
%se = strel('disk',4);
%ie = imerode(ib,se);
ib5 = edge(icon,'Sobel');
%se = strel('disk',4);
%ie = imdilate(ib5,se);
%ie = imerode(ie,se);
%ie = bwmorph(ib5,'bridge');
%ie = ib - ie;

%iGT1 = imread('datos prueba\Acrosome-Masks\Placa1-imagen1.jpg');
%iGT2 = imread('datos prueba\Head-Masks\Placa1-imagen1.jpg');
%iGT3 = imread('datos prueba\Nucleus-Masks\Placa1-imagen1.jpg');
%umbral=graythresh(ig);
%iSeg=imcomplement(im2bw(ig,umbral));
%iSeg2 = imbinarize(ig,umbral);
%sim=dice(iSeg,iGT1);

figure, 
subplot(1,2,1), imshow(ib), title('original'); 
titulo=['umbral Otsu = ' int2str(umbral*255)];
subplot(1,2,2), imshow(ib2), title(titulo);

