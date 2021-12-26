%PROYECTO - PROCESAMIENTO Y ANÁLISIS DE IMÁGENES
%INTEGRANTES: HUGO ARENAS
%             CARLOS HENRÍQUEZ
%             JUAN ARREDONDO
%             MATEO SEPÚLVEDA
%##########################################################################
%Se lee la imagen original a evaluar.
i=imread('datosPrueba\imgs\3+_16_0_200_400_600.png');

%Se lee la imagen correspondiente a la máscara de segmentación.
i2=imread('datosPrueba\masks\3+_16_mask_0_200_400_600.png');

%Se extraen los canales de colores de la imagen original.
%Se extrae el canal rojo.
ired = i(:,:,1);

%Se extrae el canal verde.
igreen = i(:,:,2);

%Se extrae el canal azul.
iblue = i(:,:,3);

%Se resta el inverso del canal azul menos la cuarta para del canal rojo y
%verde. Este se hace para resaltar el color azul, que es el color que se
%quiere utilizar para la segmentación.
icolor = (255 - iblue) - ired/4 - igreen/4;

%Se realiza un contraste adaptativo para destacar las partes con menor
%intensidad.
icon = adapthisteq(icolor,'clipLimit',0.1,'Distribution','rayleigh');

%Se mejora el brillo de la imagen contrastada.
ibright = imlocalbrighten(icon,0.2);

%Para eliminar secciones de la imagen preprocesada que se consideran
%sobrantes, se utilizan morfologías para eliminarlas.
%Se crea una máscara de forma de diamante de tamaño 1 y luego, usándola, se
%aplica una erosión sobre la imagen preprocesada.
se = strel('diamond',1);
ie = imerode(ibright,se);

%Para obtener la segmentación, se utiliza el método de la segmentación
%por umbralización. Para ello, se obtiene la máscara de umbralización con 2
%divisiones de intensidad.
umbrales=multithresh(ie,2);

%Luego, se aplica la segmentación con la máscara de umbrales obtenida.
seg_I=imquantize(ie,umbrales);

%Se realiza una copia de la imagen original de entrada.
i_f = i;

%Se extrae el largo y ancho de la imagen erosionada.
[f,c] = size(ie);

%Se crea una máscara resultante de ceros del largo y ancho extraida.
mask_result = zeros(f,c);

%Dado de que seg_I posee 3 labels, el primer label es azul, el segundo
%label es celeste y el tercer label es amarillo, lo que interesa es obtener
%el color amarillo, dado que es lo más cercano para obtener la máscara de
%segmentación. Para eso, se realiza un doble ciclo for para recorrer seg_I.
%Si la posición corresponde al valor 3, equivalente al amarillo, entonces
%en la misma posición de la imagen copiada de la original se pinta de color
%púrpura para destacar el área segmentada y también se pone en la misma
%posición de la máscara resultante un valor 1.
for x=1:c
    for y=1:f
        if seg_I(y,x) == 3
            i_f(y,x,1) = 255;
            i_f(y,x,2) = 0;
            i_f(y,x,3) = 255;
            mask_result(y,x)=1;
        end
    end
end

%Se obtiene el índice de Dice entre la máscara resultante y la máscara
%original de segmentación, con tal de comparar la efectividad del método de
%segmentación.
sim=dice(logical(mask_result),logical(i2))

%Se muestran las imágenes por pantalla de la imagen original, la máscara
%original de segmentación, las máscara procesada y el resultado, que
%corresponde a la imagen original con la máscara superpuesta en púrpura.
figure,
subplot(2,2,1), imshow(i), title('original');
subplot(2,2,2), imshow(i2), title('máscara original'); 
subplot(2,2,3), imshow(mask_result), title('mascara procesada');
subplot(2,2,4), imshow(i_f), title('resultado');