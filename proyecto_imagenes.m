i=imread('datosPrueba\imgs\3+_16_0_200_400_600.png');
i2=imread('datosPrueba\masks\3+_16_mask_0_200_400_600.png');
ired = i(:,:,1);
igreen = i(:,:,2);
iblue = i(:,:,3);
icolor = (255 - iblue) - ired/4 - igreen/4;
icon2 = adapthisteq(icolor,'clipLimit',0.02,'Distribution','rayleigh');
icon = imlocalbrighten(icon2,0.2);
%umbral=graythresh(icon);
%ib=imbinarize(icon,umbral);
se2 = strel('diamond',1);
ie2 = imerode(icon,se2);
se = strel('disk',1);
ie = imerode(ie2,se);
umbrales=multithresh(ie,2);
seg_I=imquantize(ie,umbrales);
regiones=label2rgb(seg_I);
%i_f = i;
%[f,c] = size(ie);
%for x=1:c
%    for y=1:f
%        if ie(y,x) == 1
%            i_f(y,x,1) = 255;
%            i_f(y,x,2) = 0;
%            i_f(y,x,3) = 255;
%        end
%    end
%end
%sim=dice(ie,logical(i2))

figure,
subplot(2,2,1), imshow(i), title('original');
subplot(2,2,2), imshow(regiones), title('procesada'); 
titulo=['mascara original'];
subplot(2,2,3), imshow(i2), title(titulo);
subplot(2,2,4), imshow(ie), title('marcada');

