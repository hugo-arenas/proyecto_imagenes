%Función calcularSuperpixels, que recibe de entrada una vector group.
%Retorna un vector superpixel.
function superpixel = calcularSuperpixels(group)
    %Se obtiene cantidad de filaz y columnas de group.
    [f,c]=size(group);
    %Se crea un vector vacío.
    superpixel = [];
    %Se agrega a superpixel el promedio y desviación estándar el color rojo
    %almacenado.
    mean_r = mean(group(:,1));
    superpixel = [superpixel mean_r];
    superpixel = [superpixel std(double(mean_r))];
    %Se agrega a superpixel el promedio y desviación estándar el color
    %verde almacenado.
    mean_g = mean(group(:,2));
    superpixel = [superpixel mean_g];
    superpixel = [superpixel std(double(mean_g))];
    %Se agrega a superpixel el promedio y desviación estándar el color azul
    %almacenado.
    mean_b = mean(group(:,3));
    superpixel = [superpixel mean_b];
    superpixel = [superpixel std(double(mean_b))];
    %Se agrega la versión a escala de grises, agregando también a
    %superpixel el promedio y desviación estándar de la intesidad por
    %escala de grises.
    group_g = group(:,1)*0.299 + group(:,2)*0.587 + group(:,3)*0.114;
    mean_gray = mean(group_g);
    superpixel = [superpixel mean_gray];
    superpixel = [superpixel std(double(group_g))];
    %Se obtiene promedio de colores para una escala de grises diferente.
    group_t = group(:,1)*0.333 + group(:,2)*0.333 + group(:,3)*0.334;
    %Se obtiene el promedio total de colores.
    mean_t = sum(sum(group))/(f*c);
    %Se agrega a superpixel el promedio de colores y la desviación estándar
    %de estos mismos en total.
    superpixel = [superpixel mean_t];
    superpixel = [superpixel std(double(group_t))];
    
end