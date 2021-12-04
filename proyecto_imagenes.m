i=imread('datosPrueba\imgs\3+_16_0_200_400_600.png');
i2=imread('datosPrueba\masks\3+_16_mask_0_200_400_600.png');
ired = i(:,:,1);
igreen = i(:,:,2);
iblue = i(:,:,3);
icolor = (255 - iblue) - ired/2 - igreen/2;
icon = adapthisteq(icolor,'clipLimit',0.02,'Distribution','rayleigh');
%icon = imlocalbrighten(icon,0.2);
umbral=graythresh(icon);
ib=imbinarize(icon,umbral);

%umbral=adaptthresh(icon,'NeighborhoodSize',[5 5]);
%ib=imbinarize(icon,umbral);
se = strel('disk',4);
ie = imerode(ib,se);

%iGT1 = imread('datos prueba\Acrosome-Masks\Placa1-imagen1.jpg');
%iGT2 = imread('datos prueba\Head-Masks\Placa1-imagen1.jpg');
%iGT3 = imread('datos prueba\Nucleus-Masks\Placa1-imagen1.jpg');
%umbral=graythresh(ig);
%iSeg=imcomplement(im2bw(ig,umbral));
%iSeg2 = imbinarize(ig,umbral);
%sim=dice(iSeg,iGT1);

figure,
subplot(1,3,1), imshow(i), title('original');
subplot(1,3,2), imshow(ie), title('procesada'); 
titulo=['mascara original'];
subplot(1,3,3), imshow(i2), title(titulo);

