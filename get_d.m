function [d] = get_d(h,i)
global data % global declaration required for the integrator (Matlab "limitation")
    if h == i
        d = data.mass_center(:,i) - data.joint_pos(:,h) - getPsi(data.joint_type(i))*data.q(i);
    else
        d = data.joint_pos(:,i) - data.joint_pos(:,h);
    end
end