function [t,y] = Template_main_for_student_MBS_2020(param_in)

    % Project Template (MECA2802 - 2020)

    if nargin == 0
        param_in = 1; % If needed (input parameter(s))
        tspan = linspace(0,2,200);
    end

    global data % Global structure that contains all the data (data.m, data.d, data.g, ...)

    [data] = load_data(); % Loading of the data from the data file (up to you!)

    % Initial conditions for the time simulation(q and qdot at t = 0 sec)
    % Example for a 3 dof MBS

    %data.q = [0.0; 0.0]; % funny values
    %data.qd = [0.0; 0.0]; % ...

    % Variable substitution for an order-1 integrator (ode45)

    y0 = [data.q; data.qd];



    % Time integration
    % MBS model to be programmed in the external function :
    % yd = Template_fprime_for_student_MBS_2020(t,y)

    [t, y] = ode45('Template_fprime_for_student_MBS_2020', tspan, y0);

    % Plot of results ...

    figure(1)
    subplot(2,1,1)
    plot(t, -y(:,1));grid on;title('q T3');hold on;
    subplot(2,1,2)
    plot(t, -y(:,2));grid on;title('qd T3');hold on;

    % Happy end !

    %load handel;
    % sound(y,Fs);

    %
end
