function [yp] = Template_fprime_for_student_MBS_2020(t, y)

global data % global declaration required for the integrator (Matlab "limitation")

% Variable substitution (from Integrator to MBS)

data.q = y(1);
data.qd = y(2);

% Q vector

[Q] = Joint_forces(data.q, data.qd, data); % up to you : function 'Joint_forces' to program (if needed)

% Mass matrix M and c term

[M, c] = dirdyn(data.q, data.qd, data); % up to you : function 'dirdyn to program (NER method) <== MECA2802 :-)

F = Q - c;

% Variable substitution (from  MBS to Integrator)

yp(1) = y(2);
yp(2) = M\F; % solution of linear system ("Ax = b")
