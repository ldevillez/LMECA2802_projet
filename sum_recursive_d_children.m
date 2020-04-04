function [vect] = sum_recursive_d_children(a,i)
global data % global declaration required for the integrator (Matlab "limitation")

vect = [0;0;0];
indices = find(data.in_body == i);
for j = indices
    vect = vect + tilde(get_d(j,i)) * a(:,j)
end

end