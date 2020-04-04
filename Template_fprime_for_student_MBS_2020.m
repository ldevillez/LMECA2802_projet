function [yp] = Template_fprime_for_student_MBS_2020(t, y)

global data % global declaration required for the integrator (Matlab "limitation")

% Variable substitution (from Integrator to MBS)

%data.q = y(1);
%data.qd = y(2);
data.q = y(1:data.n);
data.qd = y(data.n+1:end);


% 3.58
omega = zeros(3,data.n);
omega(:,1) = getPhi(data.joint_type(1))*data.qd(1);

% 3.59
omegadc = zeros(3,data.n);
omegadc(:,1) = tilde(omega(:,1)) * getPhi(data.joint_type(1))*data.qd(1);

% 3.60
betac = zeros(3, 3, data.n);
betac(:,:,1) = tilde(omegadc(:,1)) + tilde(omega(:,1)) * tilde(omega(:,1));

alphac = zeros(3, data.n);
alphac(:,1) = -data.gravity + 2 * tilde(omega(:,1)) * getPsi(data.joint_type(1)) * data.qd(1);

O = zeros(3, data.n, data.n);
O(:,1,1) = getPhi(data.joint_type(1));
A = zeros(3, data.n, data.n);
A(:,1,1) = tilde(O(:,1,1)) * get_d(1, 1) + getPsi(data.joint_type(1));

for i = 2:data.n
    h = data.in_body(i);
    % 3.58
    omega(:,i) = omega(:,h) + getPhi(data.joint_type(i))*data.qd(i);
    % 3.59
    omegadc(:,i) = omegadc(:,h) + tilde(omega(:,1)) * getPhi(data.joint_type(i))*data.qd(i);
    % 3.60
    betac(:,:,i) = tilde(omegadc(:,i)) + tilde(omega(:,i)) * tilde(omega(:,i));
    % 3.61
    alphac(:,i) = alphac(:,h) + betac(:,:,h) * get_d(h,i) + 2 * tilde(omega(:,i)) * getPsi (data.joint_type(i)) * data.qd(i);
    for k = 1:i
        O(:,i,k) = O(:,h,k) + (k == i)*getPhi(data.joint_type(i));
        A(:,i,k) = A(:,h,k) + tilde(O(:,h,k)) * get_d(h, i) + (k == i) * getPsi(data.joint_type(i));
    end
end

Wc = zeros(3, data.n);
Fc = zeros(3, data.n);
Lc = zeros(3, data.n);

Wm = zeros(3, data.n, data.n);
Fm = zeros(3, data.n, data.n);
Lm = zeros(3, data.n, data.n);

for i = data.n:-1:1
   % 3.73
   Wc(:,i) = data.mass(i) * (alphac(:,i) + betac(:,i).*get_d(i,i)) - data.Fext(:,i);
   if i == 1
      % 3.74
      Fc(:,i) = Wc(:,i);
      % 3.75
      % TODO: fix calcul inertie
      Lc(:,i) = tilde(get_d(i,i)) * Wc(:,i) - data.Lext(:,i) + data.inertia(:,:,i) * omegadc(:,i) + tilde(omega(:,i)) * data.inertia(:,:,i) * omega(:,i) ;
   else
      % 3.74
      Fc(:,i) = sum_recursive_children(Fc,i) +  Wc(:,i);
      % 3.75
      % TODO: fix calcul inertie
      Lc(:,i) = sum_recursive_children(Lc,i)+ sum_recursive_d_children(Fc,i) + tilde(get_d(i,i)) * Wc(:,i) - data.Lext(:,i) + data.inertia(:,:,i) * omegadc(:,i) + tilde(omega(:,i)) * data.inertia(:,:,i) * omega(:,i);
   end
   
   for k = 1:i
       % 3.76
        Wm(:,i,k) = data.mass(i) * (A(:,i,k) + tilde(O(:,i,k)) * get_d(i,i));
        % 3.77
        Fm(:,i,k) = sum_recursive_children(Fm(:,:,k),i) + Wm(:,i,k);
        % 3.78
        Lm(:,i,k) = sum_recursive_children(Lm(:,:,k),i) + sum_recursive_d_children(Fm(:,:,k),i) + tilde(get_d(i,i)) * Wm(:,i,k) + data.inertia(:,:,i) * O(:,i,k);
   end
end

% 3.80
c = zeros(data.n,1);
% 3.81
M = zeros(data.n,data.n);
% 3.79
Q = zeros(data.n,1);
for i = 1:data.n
    % 3.80
    c(i) = getPsi(data.joint_type(i))' * Fc(:,i) + getPhi(data.joint_type(i))' * Lc(:,i);
   for j = 1:i
       % 3.81
        M(i,j) = getPsi(data.joint_type(i))' * Fm(:,i,j) + getPhi(data.joint_type(i))' * Lm(:,i,j);
   end
end

% Q vector

% [Q] = Joint_forces(data.q, data.qd, data); % up to you : function 'Joint_forces' to program (if needed)
Q = 0;


F = Q - c;


% Variable substitution (from  MBS to Integrator)
yp = zeros(2*data.n,1);
yp(1:data.n) = y(data.n+1:end);
yp(data.n+1:end) = M \F;
%yp(1) = y(2);
%yp(2) = M\F; % solution of linear system ("Ax = b")

end