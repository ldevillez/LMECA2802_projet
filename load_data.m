
function [data] = load_data()
%TODO load file
data = struct();

data.n = 2;
data.in_body = [0, 1];

% R1 -> 1
% R2 -> 2
% R3 -> 3
% T1 -> 4
% T2 -> 5
% T3 -> 6

data.joint_type = [2, 6];
data.joint_pos = [
    [0; 0; 0], [0; 0; 0.5]];

data.mass_center = [
    [0; 0; 0.4], [0; 0; 0.5]];

data.mass = [
    5, 2
    ];

data.inertia = zeros(3,3,2);
data.inertia(:,:,1) = [0, 0, 0; 0, 0.1, 0; 0, 0, 0];
data.inertia(:,:,2) = [0, 0, 0; 0, 0, 0; 0, 0, 0];


data.gravity = [
    0; 0; 9.81
    ];

data.q = [1, 0.2];
data.qd = [0, 0];

data.Fext = [
    [0; 0; 0], [0; 0; 0]
];

data.Lext = [
    [0; 0; 0], [0; 0; 0]
];


end