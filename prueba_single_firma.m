sin_datos = readmatrix("..\biblioteca2\sin.csv");
box = readmatrix("firmas\firmas_box_360-884_41.csv");
%hagamos una cosa rara
%box(:,41) = box(:,40);
%box(:,82) = box(:,81);
%box(:,123) = box(:,122);
%box(:,164) = box(:,163);

hdpe_firma = readmatrix("firmas\hdpe_firma.csv");
ldpe_firma = readmatrix("firmas\ldpe_firma.csv");
pp_firma = readmatrix("firmas\pp_firma.csv");
pet_firma = readmatrix("firmas\pet_firma.csv");


prueba = readmatrix("..\hans\m_4.csv");
spectral_data = prueba(:,2:end);

start_index = 849;
end_index = 3648; 
wavelengths = sin_datos(start_index:end_index, 1);
spectral_data = spectral_data(start_index:end_index,:);

%sacar firma de absorbancia
sin_datos = sin_datos(start_index:end_index,2:end);
spectral_firma = -log10(spectral_data./sin_datos); 

%aplicando filtros a las firmas
spectral_firma= filtro(spectral_firma);

c = size(box,2);
n = size(spectral_data,2);
sambox = zeros(n,c);
for i = 1: n
    test_spectral = spectral_firma(:,i);
    for j = 1: c
        sambox(i,j) = sam(test_spectral, box(:,j));
    end
end

resultados = min(sambox, [], 2);
analisis = zeros(size(resultado,2),3);
for k = 1: size(resultados, 1)
    resultado = resultados(k);
    [e,index] = find(sambox == resultado);
    for i = 1: size(index,1)
        comparacionFirma(index(i));
    end
    if(size(index,1) > 1)
         disp("Resultado no concluyente :c")
    end

    %fprintf("Resultado de SAM: %.8f \n", resultado);
end


%for i = 1: size(index,1)
%    comparacionFirma(index(i));
%end
%if(size(index,1) > 1)
%     disp("Resultado no concluyente :c")
%end


function comparacionFirma(index)
    if(index < 42)
        disp("HDPE!");
    else 
        if(index > 41 && index < 83)
            disp("LDPE!");
        else
            if(index > 82 && index < 124)
                disp("PP!");
            else
                if(index > 123)
                    disp("PET!");
                end
            end
        end
    end
end

