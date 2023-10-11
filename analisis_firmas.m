%% implementacion
% obtener los datos de la bibliotaca #2
path = "..\biblioteca2\";
sin_datos = readmatrix( path + "sin.csv" );
wavelength = sin_datos(:,1);
sin_datos = [sin_datos(:,2:end) sin_datos(:,2:end)];
% obtener los datos sin las longitudes de onda
hdpe_datos = [  getcsvdata( path + "hdpe_1.csv" ) getcsvdata( path + "hdpe_2.csv") ];
pp_datos = [  getcsvdata( path + "pp_1.csv" ) getcsvdata( path + "pp_2.csv") ];
ldpe_datos = [  getcsvdata( path + "ldpe_1.csv" ) getcsvdata( path + "ldpe_2.csv") ];
pet_datos = [  getcsvdata( path + "pet_1.csv" ) getcsvdata( path + "pet_2.csv") ];

n = 40; % total de columnas (firmas)

%agregar el promedio al ultimo dato del cuadro
sin_datos(:,n+1) = sum(sin_datos,2)/n;
hdpe_datos(:,n+1) = sum(hdpe_datos,2)/n;
ldpe_datos(:,n+1) = sum(ldpe_datos,2)/n;
pp_datos(:,n+1) = sum(pp_datos,2)/n;
pet_datos(:,n+1) = sum(pet_datos,2)/n;

%eliminar la longitud de onda del cuadro
% solo nos importan longitudes de onda de 455 a 920
start_index = 849;
end_index = 3648; 
wavelength = wavelength(start_index:end_index,:);
sin_datos = sin_datos(start_index:end_index,:); 
hdpe_datos = hdpe_datos(start_index:end_index,:); 
ldpe_datos = ldpe_datos(start_index:end_index,:); 
pp_datos = pp_datos(start_index:end_index,:); 
pet_datos = pet_datos(start_index:end_index,:); 

%sacar firma de absorbancia
sin_firma = -log10(sin_datos./sin_datos);
hdpe_firma = -log10(hdpe_datos./sin_datos);
ldpe_firma = -log10(ldpe_datos./sin_datos);
pp_firma = -log10(pp_datos./sin_datos);
pet_firma = -log10(pet_datos./sin_datos);


% grafico de las firmas (solo promedios)
figure
hold on
plot(wavelength, sin_firma(:,n+1), 'Color', 'black', 'LineWidth', 1, 'DisplayName', 'sin')
hold on
plot(wavelength,hdpe_firma(:,n+1), 'Color', 'red', 'LineWidth', 1, 'DisplayName', 'hdpe')
hold on
plot(wavelength,ldpe_firma(:,n+1), 'Color', 'green', 'LineWidth', 1, 'DisplayName', 'ldpe')
hold on
plot(wavelength,pp_firma(:,n+1), 'Color', 'blue', 'LineWidth', 1, 'DisplayName', 'pp')
hold on
plot(wavelength,pet_firma(:,n+1), 'Color', 'magenta', 'LineWidth', 1, 'DisplayName', 'pet')
hold off
lgd = legend;
%xlim([450,800]);

%aplicamos filtros
sin_firma = filtro(sin_firma);
hdpe_firma = filtro(hdpe_firma);
ldpe_firma = filtro(ldpe_firma);
pp_firma = filtro(pp_firma);
pet_firma = filtro(pet_firma);

% grafico de las firmas (solo promedios)
figure
hold on
plot(wavelength, sin_firma(:,n+1), 'Color', 'black', 'LineWidth', 1, 'DisplayName', 'sin')
hold on
plot(wavelength,hdpe_firma(:,n+1), 'Color', 'red', 'LineWidth', 1, 'DisplayName', 'hdpe')
hold on
plot(wavelength,ldpe_firma(:,n+1), 'Color', 'green', 'LineWidth', 1, 'DisplayName', 'ldpe')
hold on
plot(wavelength,pp_firma(:,n+1), 'Color', 'blue', 'LineWidth', 1, 'DisplayName', 'pp')
hold on
plot(wavelength,pet_firma(:,n+1), 'Color', 'magenta', 'LineWidth', 1, 'DisplayName', 'pet')
hold off
lgd = legend;
%xlim([450,800]);

%juntar todas las formas en una gran caja 33 x 33

box = [hdpe_firma ldpe_firma pp_firma pet_firma];

% comparaciones de SAM
n = n +1;
c = n*4;
sambox = zeros(c, c);
for i = 1: c
    refspectral = box(:,i);
    for j = 1 : c
        sambox(i,j) = sam(box(:,j), refspectral);
    end
end

% imprimir cuadrito de SAM
figure
imagesc(sambox.^1)
colorbar
