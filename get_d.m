function [d] = get_d(h,i,data)
    if h == i
        d = (data.mass_center(:,i) + getPsi(data.joint_type(i))*data.q(i));
    else
        d = (getPsi(data.joint_type(h))*data.q(h) + data.joint_pos(:,i));
    end
end