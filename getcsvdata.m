function data = getcsvdata(path)
    data = readmatrix(path);
    data = data(:,2:end);
end