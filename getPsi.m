function [vect] = getPsi(index)
    switch index
        case 4
            vect = [1, 0, 0];
        case 5
            vect = [0, 1, 0];
        case 6
            vect = [0, 0, 1];
        otherwise
            vect = [0, 0, 0];
    end
end