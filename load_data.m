
function [data] = load_data()
data = struct();


text = fileread('data.txt');
t = strsplit(text,'\n');

flag = 0;
i = 1;
line = t(i);
if flag == 0 && strcmp(line,'=== NBODY ===')
    i = i + 1;
    line = t(i);
    data.n = str2double(line{1});
    flag = 1;
    i = i + 1;
    line = t(i);
else
    assert(flag ~= 0, 'Il manque la section NBODY')
end

if flag == 1 && strcmp(line,'=== INBODY ===')
    i = i + 1;
    line = t(i);
    data.in_body = str2double(strsplit(line{1}));
    flag = 2;
    i = i + 1;
    line = t(i);
else
    assert(flag ~= 1, 'Il manque la section INBODY')
end


% R1 -> 1
% R2 -> 2
% R3 -> 3
% T1 -> 4
% T2 -> 5
% T3 -> 6
if flag == 2 && strcmp(line,'=== JOINT TYPE ===')
    i = i + 1;
    line = t(i);
    data.joint_type = str2double(strsplit(line{1}));
    flag = 3;
    i = i + 1;
    line = t(i);
else
    assert(flag ~= 2, 'Il manque la section JOINT TYPE')
end

if flag == 3 && strcmp(line,'=== JOINT POSITIONS ===')
   
    data.joint_pos = zeros(3,data.n);
    for j = 1:data.n
        line = t(i + j);
        data.joint_pos(:,j) = str2double(strsplit(line{1}))';
    end
    
    flag = 4;
    i = i + j + 1;
    line = t(i);
else
    assert(flag ~= 3, 'Il manque la section JOINT POSITIONS')
end

if flag == 4 && strcmp(line,'=== MASS CENTER ===')
   
    data.mass_center = zeros(3,data.n);
    for j = 1:data.n
        line = t(i + j);
        data.mass_center(:,j) = str2double(strsplit(line{1}))';
    end
    
    flag = 5;
    i = i + j + 1;
    line = t(i);
else
    assert(flag ~= 4, 'Il manque la section MASS CENTER')
end

if flag == 5 && strcmp(line,'=== MASS ===')
    i = i + 1;
    line = t(i);
    data.mass = str2double(strsplit(line{1}));
    flag = 6;
    i = i + 1;
    line = t(i);
else
    assert(flag ~= 5, 'Il manque la section MASS')
end

if flag == 6 && strcmp(line,'=== INERTIA MOMENTS ===')
   
    data.inertia = zeros(3,3,2);
    for j = 1:data.n
        line = t(i + j);
        data.inertia(:,:,j) = diag(str2double(strsplit(line{1}))');
    end
    
    flag = 7;
    i = i + j + 1;
    line = t(i);
else
    assert(flag ~= 6, 'Il manque la section INERTIA MOMENTS')
end

if flag == 7 && strcmp(line,'=== INERTIA PRODUCTS ===')

    for j = 1:data.n
        line = t(i + j);
        At = str2double(strsplit(line{1})).';
        data.inertia(1,2:3,j) = At(1:2);
        data.inertia(2,3,j) = At(3);
        data.inertia(2,1,j) = At(1);
        data.inertia(3,1:2,j) = At(2:3);
    end
    
    flag = 8;
    i = i + j + 1;
    line = t(i);
else
    assert(flag ~= 7, 'Il manque la section INERTIA PRODUCTS')
end

if flag == 8 && strcmp(line,'=== GRAVITY ===')
    i = i + 1;
    line = t(i);
    data.gravity = str2double(strsplit(line{1}))';
    flag = 9;
    i = i + 1;
    line = t(i);
else
    assert(flag ~= 8, 'Il manque la section GRAVITY')
end

if flag == 9 && strcmp(line,'=== Fext ===')
   
    data.Fext = zeros(3,data.n);
    for j = 1:data.n
        line = t(i + j);
        data.Fext(:,j) = str2double(strsplit(line{1}))';
    end
    
    flag = 10;
    i = i + j + 1;
    line = t(i);
else
    assert(flag ~= 9, 'Il manque la section Fext')
end

if flag == 10 && strcmp(line,'=== Lext ===')
   
    data.Lext = zeros(3,data.n);
    for j = 1:data.n
        line = t(i + j);
        data.Lext(:,j) = str2double(strsplit(line{1}))';
    end
    
    flag = 11;
    i = i + j + 1;
    line = t(i);
else
    assert(flag ~= 10, 'Il manque la section Lext')
end

if flag == 11 && strcmp(line,'=== Q QD ===')
    i = i + 1;
    line = t(i);
    data.q = str2double(strsplit(line{1}));
    i = i + 1;
    line = t(i);
    data.qd = str2double(strsplit(line{1}));
    flag = 12;
    i = i + 1;
    line = t(i);
else
    assert(flag ~= 12, 'Il manque la section Q QD')
end

if flag == 12 && strcmp(line,'=== JOINT FORCES ===')
    data.joint_forces = cell(1,data.n);
    for j = 1:data.n
        line = t(i + j);
        data.joint_forces{j} = strsplit(line{1});
    end
    
    flag = 10;
    i = i + j + 1;
    line = t(i);
else
    assert(flag ~= 12, 'Il manque la section JOINT FORCES')
end


end