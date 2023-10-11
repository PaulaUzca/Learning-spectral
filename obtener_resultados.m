analisis = readmatrix("analisis.csv");
coincidencias = 0;
fallos = 0;
for i = 1: size(analisis,1)
    if(analisis(i,1) == analisis(i,2))
        coincidencias = coincidencias +1;
    else
        fallos = fallos + 1;
    end
end
disp("coincidencias "+coincidencias);
disp("fallos " + fallos);