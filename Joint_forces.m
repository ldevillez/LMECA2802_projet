function [Q] = Joint_forces()
global data;

Q = zeros(data.n,1);
for j = 1:data.n
    line = data.joint_forces{j};
    id = line{1};
    switch id
        case '1'
            % Perfect Joint
        case '2'
            Q(j) = - ( str2double(line{2})*(data.q(j)-str2double(line{3})));
        case '3'
            Q(j) = - ( str2double(line{2})*(data.q(j)-str2double(line{3})) + str2double(line{4})*data.qd(j) );
        otherwise
            % Unknow joint
            disp(['Joint force for the joint ', num2str(j), ' is unknow'])
    end
end


end