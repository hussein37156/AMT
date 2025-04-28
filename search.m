function [Te] = search(array, input, load)
    array=load*array;
    % Sort by proximity to the input
    [~, idx] = sort(abs(array(:,1) - input));

    % Safely get the two closest data points
    X = [array(idx(1),1); array(idx(2),1)];
    Y = [array(idx(1),2); array(idx(2),2)];

    % Perform interpolation with extrapolation enabled
    Te = interp1(X, Y, input, 'linear', 'extrap') * load;

    if Te<0
        Te=0;
    end
end
