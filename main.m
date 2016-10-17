% Nima Ghaviha (nima.ghaviha@mdh.se)
% 2016-10-17

% This function is the main optimization function which is done offline. It
% calculates the optimum decision for all the possible states of the
% train. The results are later on saved (using another function) to be used
% onboard the train for the online advisory system. 

function [VopOut, CalTime, SpeedLimit2, Elevations2] = main(t,x, vS, InputTime, InputDistance, RRA, RRB, RRC, Mass, TracEffort, BrakeEffort, BrPoint, MaxSpeedi, elev, sl, minusT, plusT, ACMPower)

tic
h = waitbar(0, 'Calculating the general solution, please wait ... ');

m = Mass;
aRR = RRA;
b = RRB;
c = RRC;


P1 = inf;   
P2 = inf;
P3 = inf;   
P4 = inf;   
P5 = inf;   
P6 = inf;   
P7 = inf;   
P8 = inf;   
P9 = inf; 
P10 = 100000000000000000000000000000000000000000;
P_opt = inf;    
Pi = 100000000000000000000000000000000000000000;
Pi = inf;
Pj = 1;
Pk = 10000000000000000000000000000000000000;

Max_speed = vS;
TripTime = InputTime;
TripDistance = InputDistance;

NoT = t+1;
NoX = x+1;
NoV =  Max_speed + 1;

tstep = TripTime / (NoT - 1);      
xstep = TripDistance / (NoX - 1);
vstep = MaxSpeedi / (NoV - 1);

plusTstep = round(plusT / tstep);
minusTstep = round(minusT/ tstep);

NoT2 = NoT + plusTstep;

MechVelocity = 6/vstep;

J = zeros(NoT2, NoX, NoV);

SpeedLimit = zeros (NoX,1);
SpeedLimit_i = zeros (NoX,1);
SpeedLimit_ms = zeros (NoX,1);
SpeedLimit_temp = zeros (NoX,1);
Elevations = zeros (NoX,1);
ElevF_Accum = zeros(NoX, 1);
Temp1 = zeros (NoX,1);
Temp2 = zeros (NoX,1);

Vop = ones([NoT2 NoX NoV]);

U = zeros(NoT2, NoX, NoV);


Fa_S = zeros(NoX, 1);
S2_S = zeros(NoX, 1);
S2 = zeros(NoX, 1);
%%%%%%Variables for calculations of max tractive effort available%%%%%%%%%%
Break_point = BrPoint;
Max_Acc = TracEffort;
Max_Dec = BrakeEffort;


Power_Acc = Break_point * Max_Acc;   %Power at brake point for acceleration
Power_Dec = Break_point * Max_Dec;   %Power at brake point for deceleration

AccEffort = 0;            %max tractive effort for acceleration(output) [N]
DecEffort = 0;            %max tractive effort for deceleraion (output) [N]
v_avg = 0;

MaxA = Max_Acc/m;                                                  %[m/s^2]
MaxD = Max_Dec/m;                                                  %[m/s^2]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%Jerk Rate Variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%
JerkRate = 10;                                           %Jerk rate [m/x^3]
Max_dF = m * JerkRate * tstep;                                    %delta FA
F = zeros(NoT2, NoX, NoV);          %To save the Acceleration Force 
dF = 0;
temp_F = zeros(NoV,1);       
F_temp = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ACM Variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ACM_power = ACMPower;    %[kW] obtained from TEP results!
ACM_energy = (ACM_power * tstep / 3600)*3600000;    %[kW]*[h]*3600000 = [J]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SpeedLimit = adjust_speed(TripDistance, xstep, sl);
Elevations = adjust_elevations(TripDistance, xstep, elev);

SpeedLimit_i = SpeedLimit / vstep + 1;
SpeedLimit_ms = SpeedLimit * (10/36);
Elevations_F = m * 10 * Elevations/1000;
ElevF_Accum(1, 1) = Elevations_F(1, 1);
for l = 2 : NoX
    ElevF_Accum(l, 1) = ElevF_Accum(l - 1, 1) + Elevations_F(l, 1);
end


J(NoT, NoX, 1) = 0;
F(NoT2, NoX, 1) = 0;                                              

for ti = NoT - minusTstep : NoT
    J(ti, NoX, 1) = Pj * (NoT - ti);
end

for ti = NoT : NoT2
    for vi = 2 : Max_speed + 1
        for xi = 1 : NoX - 1
            J(ti, xi, vi) = Pk * (ti - NoT);
        end
    end
end

for xi = 1 : NoX - 1
    for vi = 1 : Max_speed + 1
        J(NoT2, xi, vi) = P1;
    end
end

for vi = 2 : Max_speed + 1
    for xi = 1 : NoX
        J(NoT2, xi, vi) = P2;
    end
end

for vi = 2 : Max_speed + 1
    for ti = 1 : NoT2
        J(ti, NoX, vi) = P3;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ti = 1 : NoT2
    x_2 = NoX - ceil(0.5 * MaxD * (((NoT2 - t) * tstep)^2)/xstep);
    x_Min = max(x_2, 1);
    if x_Min ~= 1
        for xi = 1 : x_Min
            for vi = 1 : Max_speed + 1
                J(ti, xi, vi) = P_opt;
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for ti = 1 : NoT - minusTstep - 1
    for vi = 1 : Max_speed + 1
        J(ti, NoX, vi) = P4;
    end
end

for ti = 2 : NoT - minusTstep - 1
    for xi = 1 : NoX
        J(ti, xi, 1) = (NoT - ti) * Pi;
        %J(ti, xi, 1) = Pi;
    end
end


%max dv in one time step while decelerating[vstep]
Max_dV_d = ceil(((MaxD * tstep)*3.6)/vstep);   
%max dv in one time step while accelerating[vstep]
Max_dV_a = ceil(((MaxA * tstep)*3.6)/vstep);   


for t = NoT2 : -1 : 2
    waitC = t - 2; 
    waitbar((NoT2 - 2 - waitC)/(NoT2 - 2))
    x_1 = ceil(0.5 * MaxA * ((t * tstep)^2)/xstep);
    x_2 = NoX - ceil(0.5 * MaxD * (((NoT2 - t) * tstep)^2)/xstep) - 10;
    x_Max = min(x_1, NoX);
    x_Min = max(x_2, 1);
    v1_1 = Max_dV_a * (t - 1);
    v1_M = min(v1_1, Max_speed + 1);

    for x1 = x_Max : -1 : x_Min
        for v1 = 1 : v1_M 
            Lv_temp = floor(v1 - Max_dV_d);
            Hv_temp = floor(v1 + Max_dV_a);            
           
            %%instead of the if statement up there%%%%%%%%%%%%%%%%%%%%%%%%% 
            Lv = max(Lv_temp, 1);     
            Hv = min(Hv_temp, Max_speed + 1);   
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            C = P10 * ones(Max_speed + 1, 1);
            F_temp = P10 * ones(Max_speed + 1, 1);
            for v2 = Lv : Hv
                v1ms = ((v1-1)*vstep)*10/36;    
                v2ms = ((v2-1)*vstep)*10/36;
                Fa = m*(v2ms-v1ms)/tstep;                    
                Frr = -(aRR + b * ((v1+v2-2)/2) * vstep + c * ((((v1+v2-2)/2) * vstep)^2 ));    %we use average transition speed to calculate rolling resistance
                xp2 = x1 + ((v1ms+v2ms)*tstep)/(2*xstep);
                x2 = round(xp2);
                    
                if xp2 <= NoX
                    dF = abs(F(t, x2, v2) - Fa);
                end
                if xp2 <= NoX && dF <= Max_dF
                    v_avg = ((v1 + v2-2)/2)*vstep;
                    dx = ((v1ms+v2ms)*tstep)/2;
                    Fg = -(ElevF_Accum(x2, 1) - ElevF_Accum(x1, 1))/(x2 - x1);
                    Ft = ( Fa - Frr - Fg);
                    
                    v1kmh = (v1 - 1) * vstep;
                    if v1kmh <= Break_point
                        AccEffort = Max_Acc;
                        DecEffort = -(Max_Dec);
                    else
                        AccEffort = Power_Acc / v1kmh;
                        DecEffort = -(Power_Dec / v1kmh);
                    end
                    
                    if Ft >= DecEffort && Ft <= AccEffort
                        S2 = zeros (NoX, 1);
                        flag = 0;  
                        S2(x1) = v1ms;
                        for p = x1 + 1 : x2
                            S2(p) = sqrt(2 * (Fa / m) * xstep + S2(p - 1)^2);
                        end


                        if S2(x1 : x2) - SpeedLimit_ms(x1 : x2) <= 0 
                            if Ft >= 0
                                e = 1.25 * Ft * dx + ACM_energy;
                            else 
                                e = 0.8 * Ft * dx + ACM_energy;
                            end
                            C(v2) = J(t, x2, v2) + e;
                            F_temp(v2) = Fa;
                        end 
                    end
                end
            end
            [A, I] = min(C);
            J(t-1, x1, v1) = A;
            F(t-1, x1, v1) = F_temp(I);
            Vop(t-1, x1, v1) = I;  

        end
    end
end

close(h)
waitbar(1, 'Done!')


VopOut = Vop;
SpeedLimit2 = SpeedLimit;
Elevations2 = Elevations;

CalTime = toc;
end
