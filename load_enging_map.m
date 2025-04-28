function [engine_map] = load_enging_map(file_name)
    filename = file_name;  
    data = readmatrix(filename);
    engine_map = data;
end
