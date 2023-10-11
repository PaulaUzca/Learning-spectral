% aplicar filtros
function firma_filtrada = filtro(firma)
    firma_filtro1 = hampel(firma); % eliminar valores atipicos (pixeles calientes)
    firma_filtrada = movmedian(firma_filtro1, 5);
end