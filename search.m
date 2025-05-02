function [Te] = search(array, input, load)
    if load ~=0
        array=load*array;
        [~, idx] = sort(abs(array(:,1) - input));
        X = [array(idx(1),1); array(idx(2),1)];
        Y = [array(idx(1),2); array(idx(2),2)];
        Te = interp1(X, Y, input, 'linear', 'extrap');
        if Te<0
            Te=0;
        end
    else
        Te=0;
    end
end
