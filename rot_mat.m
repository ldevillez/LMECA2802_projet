function [A] = rot_mat(i,q)
    switch i
        case 1
            A = [1, 0, 0;0, cos(q), sin(q); 0, -sin(q), cos(q)];
        case 2
            A = [cos(q), 0, sin(q);0, 1, 0; -sin(q), 0, cos(q)];
        case 3
            A = [cos(q), sin(q), 0;-sin(q), cos(q), 0; 0, 0, 1];
        otherwise
            A = [1, 0, 0;0, 1, 0; 0, 0, 1];
    end
end