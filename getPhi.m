function [vect] = getPhi(index)
    switch index
        case 1
            vect = [1; 0; 0];
        case 2
            vect = [0; 1; 0];
        case 3
            vect = [0; 0; 1];
        otherwise
            vect = [0; 0; 0];
    end
end

