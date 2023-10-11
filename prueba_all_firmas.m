sin_datos = readmatrix("..\biblioteca2\sin.csv");
box = readmatrix("firmas\firmas_box_360-884_41.csv");

hdpe_firma = readmatrix("firmas\hdpe_firma.csv");
ldpe_firma = readmatrix("firmas\ldpe_firma.csv");
pp_firma = readmatrix("firmas\pp_firma.csv");
pet_firma = readmatrix("firmas\pet_firma.csv");

path = "..\test\";
pruebas = ["hdpe_1.csv","hdpe_2.csv","hdpe_3.csv","hdpe_4.csv",...
    "ldpe_1.csv","ldpe_2.csv","ldpe_3.csv","ldpe_4.csv",...
    "pp_1.csv","pp_2.csv","pp_3.csv","pp_4.csv",...
    "pet_1.csv","pet_2.csv","pet_3.csv","pet_4.csv",...
    ];
d = dictionary(pruebas, [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4]);
% nos interesan longitudes de onda de 455 a 920
start_index = 849;
end_index = 3648; 
wavelengths = sin_datos(start_index:end_index, 1);
sin_datos = sin_datos(start_index:end_index,2:end);
c = size(box,2);

analisis = zeros(size(pruebas,2)*20, 4);
m = 1;
for k=1:size(pruebas,2)
    prueba = readmatrix(path + pruebas(k));
    spectral_data = prueba(:,2:end);
    
    spectral_data = spectral_data(start_index:end_index,:);
    
    %sacar firma de absorbancia
    spectral_firma = -log10(spectral_data./sin_datos); 
    
    %aplicando filtros a las firmas
    spectral_firma= filtro(spectral_firma);
    
    n = size(spectral_data,2);
    sambox = zeros(n,c);
    for i = 1: n
        test_spectral = spectral_firma(:,i);
        for j = 1: c
            sambox(i,j) = sam(test_spectral, box(:,j));
        end
    end
    
    resultados = min(sambox, [], 2);
    for e =1: size(resultados,1)
        resultado = resultados(e);
        [w,index] = find(sambox == resultado);
        %fprintf("Resultado de SAM: %.8f \n", resultado);
        for i = 1: size(index,1)
            r = comparacionFirma(index(i));
        end
        if(size(index,1) > 1)
             %r = "Resultado no concluyente :c";
             r = 0;
        end
        analisis(m,:,:,:) = [r, d(pruebas(k)), resultado, index ]; 
        m = m+1;
    end
end


function r = comparacionFirma(index)
    r = 0;
    if(index < 42)
        r = 1;
    else 
        if(index > 41 && index < 83)
            r = 2;

        else
            if(index > 82 && index < 124)
                r = 3;

            else
                if(index > 123)
                    r = 4;

                end
            end
        end
    end
end