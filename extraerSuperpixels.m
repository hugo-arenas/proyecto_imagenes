%Función extraerSuperpixeles con entradas imagen, labels y numlabels.
%Retorna una matriz, o vector de vectores.
function superpixels = extraerSuperpixels(imagen,labels,numlabels)
    %Obtiene cantidad de filas y columnas de labels.
    [filas,columnas]=size(labels);
    %Se crear un vector vacío.
    superpixels = [];
    %Por cada label hasta la cantidad máxima de estos
    for label=0:(numlabels-1)
        %Se genera un vector vacío.
        group = [];
        %Por cada posición en las filas.
        for y=1:filas
            %Por cada posición en las columnas.
            for x=1:columnas
                %Si la posición (y,x) en labels corresponde a un label,
                %entonces:
                if labels(y,x)==label
                    %Se agrega al vector group el color rojo, verde y
                    %azul de la posición (y,x) de la imagen.
                    group = [group; imagen(y,x,1) imagen(y,x,2) imagen(y,x,3)];
                end
            end
        end
        %Se agrega el resultado de aplicar la función calcularSuperpixels
        %en group al vector superpixels.
        superpixels = [superpixels; calcularSuperpixels(group)];
    end
end
