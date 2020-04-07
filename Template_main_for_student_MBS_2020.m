function [t,y] = Template_main_for_student_MBS_2020(varargin)
    global data % Global structure that contains all the data (data.m, data.d, data.g, ...)

    [data] = load_data(); % Loading of the data from the data file (up to you!)

    switch nargin
        case 0
            tspan = 0:0.01:15;
        case 1
            tspan = varargin{1};
            data.q = varargin{2};
        case 2
            tspan = varargin{1};
            data.q = varargin{2};
            data.qd = varargin{3};
        otherwise
            assert(false, 'Too many argument')
    end

    % Variable substitution for an order-1 integrator (ode45)
    y0 = [data.q; data.qd];



    % Time integration
    % MBS model to be programmed in the external function :
    % yd = Template_fprime_for_student_MBS_2020(t,y)
    tic();
    [t, y] = ode45('Template_fprime_for_student_MBS_2020', tspan, y0);
    b = toc();
    disp(['Temps d integration: ', num2str(b), ' sec'])
    % Plot of results ...
    
    for j = 1:data.n
        figure()
        subplot(2,1,1)
        plot(t, y(:,-1+2*j));grid on;title(['q ', num2str(j)]);hold on;
        subplot(2,1,2)
        plot(t, y(:,2*j));grid on;title(['qd ', num2str(j)]);hold on;
    end

    % Happy end !

    %load handel;
    %sound(y,Fs);

    %
end
