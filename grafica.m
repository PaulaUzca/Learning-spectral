r = readmatrix("analisis.csv");

l1 = r(1:80,4); % put your T.ConstructionYear data here
l2 = r(81:160,4);
l3= r(161:240,4);
l4 = r(241:320, 4);

myColor = rand(4,3); % 10 bins/colors with random r,g,b for each

hold on

d2 = histcounts(l1);
b = bar(l1, d2);
b.CData = myColor(1, :);


d2 = histcounts(l2);
b = bar(l2, d2);
b.CData = myColor(2, :);

b.BarWidth = 0.4;
xlabel('Indice de coincidencia');
ylabel('Numero de firmas');
title('Firma con la que coincide la muestra');
legend('HDPE', 'LDPE', 'PP', 'PET')
hold off

