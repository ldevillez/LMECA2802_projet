function [vect] = sum_recursive_children(a,i)
global data % global declaration required for the integrator (Matlab "limitation")

vect = [0;0;0];
indices = find(data.in_body == i);
for j = indices
    vect = vect + rot_mat(data.joint_type(j),data.q(j)) * a(:,j);
end

end