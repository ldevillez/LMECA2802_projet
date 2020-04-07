function [vect] = sum_recursive_d_children(a,i,data)

vect = [0;0;0];
indices = find(data.in_body == i);
for j = indices
    vect = vect + rot_mat(data.joint_type(j),data.q(j)) *tilde(get_d(i,j,data)) * a(:,j);
end

end