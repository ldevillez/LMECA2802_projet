function [vect] = sum_recursive_children(a,i)
global data % global declaration required for the integrator (Matlab "limitation")

vect = [0;0;0];
% Get children of i
vect = sum(a(:,data.in_body == i)')';

end