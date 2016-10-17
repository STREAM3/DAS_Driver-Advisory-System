% Nima Ghaviha (nima.ghaviha@mdh.se)
% 2016-10-17

% This function is used for online calculation. This is what is done on the
% train for the online advisory system
function [Vout2, Xout2, DistOpout2, EffortOpout2, FAccOpout2,FROpout2, Eopout2, Gopout2, Loss, DrivingEnergy2, BrakingEnergy2, Power, Current] = find_n(Vop, t, x, vS, IT, IX, IX_R, IV, IV_R, TTime, TDistance, MaxSpeed, MinusT, PlusT, SpeedLimits, Elevations, Arr, Brr, Crr, m, ACMPower, MaxTrac, MaxBrake, BRPoint)

clc
tic
DrivingEnergy = 0;
BrakingEnergy = 0;
NoT = t+1;
NoX = x+1;
TripTime = TTime;
TripDistance = TDistance;
tstep= TripTime / (NoT-1);      
xstep= TripDistance / (NoX-1);
vstep = MaxSpeed / vS;
MinusTstep = round(MinusT / tstep);
PlusTstep = round(PlusT / tstep);

Pi = 100000000000000;
Pj = 1;
Pk = 10000000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ACM Variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ACM_power = ACMPower;    %[kW] obtained from TEP results!
ACM_energy = (ACM_power * tstep / 3600)*3600000;    %[kW]*[h]*3600000 = [J]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Voltage = 750;          %[V] DC for now 


Elevations_F = m * 10 * Elevations/1000;
MechVelocity = 6/vstep;
NoT2 = NoT + PlusTstep;

DistOp = zeros(NoT2, 1);
FROp = zeros(NoT2, 1);
FAccOp = zeros(NoT2, 1);
EffortOp = zeros(NoT2, 1);
Effort_percentage = zeros(NoT2, 1);
Power = zeros(NoT2, 1);
Current = zeros(NoT2, 1);
V = zeros(NoT2, 1);
X = zeros(NoT2, 1);
Eop = zeros(NoT2, 1);
Gop = zeros(NoT2, 1);
Loss = zeros(NoT2, 1);


DrivingEnergy2 = 0;
BrakingEnergy2 = 0;

%%%%%%%%%%
Point_temp = zeros(2, 2);
V_temp = zeros(2, 2);
X_temp = zeros(2, 2);
Vop_temp = zeros(2, 2);
A = 0;
B = 0;

X_inter = 1 : NoX;
V_inter = 1 : (vS + 1);
Vop_inter = zeros(NoX, vS + 1);


%%%%%%%%%%

V(IT) = IV;
V_R(IT) = IV_R;
X(IT) = IX;
X_R(IT) = IX_R;
PJ = 0;

count = 0;
PJ = 0;

%%%%%%%%%%%%%%%%%%%%% Varaibles for calculating percentage %%%%%%%%%%%%%%%%
Break_point = BRPoint;
Max_Acc = MaxTrac;
Max_Dec = MaxBrake;
Power_Acc = Break_point * Max_Acc;   %Power at brake point for acceleration
Power_Dec = Break_point * Max_Dec;   %Power at brake point for deceleration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MaxA = Max_Acc/m;                                                  %[m/s^2]
MaxD = Max_Dec/m;                                                  %[m/s^2]
%max dv in one time step while decelerating[vstep]
Max_dV_d = ceil(((MaxD * tstep)*3.6)/vstep);   
%max dv in one time step while accelerating[vstep]
Max_dV_a = ceil(((MaxA * tstep)*3.6)/vstep);  
NoV = vS + 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for t=IT:NoT2-1
    if X(t) <= NoX
        count = count + 1; 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        v1_1 = Max_dV_a * (t - 1) + 1;
        v1_M = min(v1_1, NoV);
        v1_Lim = min(SpeedLimits(X(t)), v1_M); 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if V(t) <= v1_Lim 
            V(t+1) = Vop(t,X(t),V(t));                
            dxp =(((V(t)+V(t+1)-2))*vstep*(10/36)*tstep)/(2*xstep);
            X(t+1) = X(t) + round(dxp);
            DistOp(t+1) = X(t) + dxp;
            FAccOp(t) = m * ((V(t + 1) - V(t)) * vstep * 10) / (tstep * 36);
            FROp(t) = -(Arr + Brr * ((V(t)+V(t+1)-2)/2) * vstep + Crr * ((((V(t)+V(t+1)-2)/2) * vstep)^2 ));             
            Gop(t) = -(mean(Elevations_F(X(t) : X(t+1))));
            v_avg = ((V(t) + V(t + 1) - 2)/2)*vstep;
            %Loss(t) = Calculate_Loss(v_avg, EffortOp(t), tstep);
            EffortOp(t) = FAccOp(t) - FROp(t) - Gop(t);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            v1kmh = (V(t) - 1) * vstep; 
            if v1kmh <= Break_point
                AccEffort = Max_Acc;
                DecEffort = Max_Dec;
            else
                AccEffort = Power_Acc / v1kmh;
                DecEffort = Power_Dec / v1kmh;
            end
            if EffortOp(t) < -(DecEffort)
                EffortOp(t) = -(DecEffort);
                v1kmh = (V(t) - 1) * vstep;
                v1ms = v1kmh * 10/36;
                FROp(t) = -(Arr + Brr * v1kmh + Crr * (v1kmh ^ 2));
                Gop(t) = -(Elevations_F(X(t)));
                FAccOp(t) = EffortOp(t) + FROp(t) + Gop(t);
                v2ms = v1ms + (FAccOp(t) / m) * tstep; 
                v2kmh = v2ms * 3.6; 
                V(t + 1) = round(v2kmh / vstep) + 1;
                if V(t + 1) < 1
                    V(t + 1) = 1;
                end
                dxp =(((V(t)+V(t+1)-2))*vstep*(10/36)*tstep)/(2*xstep);
                X(t+1) = X(t) + round(dxp);
                DistOp(t+1) = X(t) + dxp;
            end
            
            if EffortOp(t) > 0
                Effort_percentage(t) = (EffortOp(t) / AccEffort) * 100;
            else
                Effort_percentage(t) = (EffortOp(t) / DecEffort) * 100;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            v1ms = ((V(t)-1)*vstep)*10/36;
            v2ms = ((V(t+1)-1)*vstep)*10/36;

            if EffortOp(t) > 0 
                Eop(t) = 1.25 *  EffortOp(t) * (((v1ms+v2ms)*tstep)/2) + ACM_energy;
            else
                Eop(t) = 0.8 *  EffortOp(t) * (((v1ms+v2ms)*tstep)/2) + ACM_energy;
            end
            Power(t) = Eop(t) / tstep; 
            Current(t) = Power(t) / Voltage; 
            if EffortOp(t) >= 0
                DrivingEnergy = DrivingEnergy + 1.25 *  EffortOp(t) * (((v1ms+v2ms)*tstep)/2);
            else
                BrakingEnergy = BrakingEnergy + 0.8 *  EffortOp(t) * (((v1ms+v2ms)*tstep)/2);
            end
        else 
            v1kmh = (V(t) - 1) * vstep;
            v1ms = v1kmh * 10/36;
            if v1kmh <= Break_point
                DecEffort = Max_Dec;
            else
                DecEffort = Power_Dec / v1kmh;
            end
            EffortOp(t) = -(DecEffort);
            Effort_percentage(t) = -100; 
            Gop(t) = -(Elevations_F(X(t)));
            FROp(t) = -(Arr + Brr * v1kmh + Crr * (v1kmh ^ 2));
            FAccOp(t) = EffortOp(t) + FROp(t) + Gop(t);
            v2ms = v1ms + (FAccOp(t) / m) * tstep; 
            v2kmh = v2ms * 3.6; 
            V(t + 1) = round(v2kmh / vstep) + 1;
            dxp =(((V(t)+V(t+1)-2))*vstep*(10/36)*tstep)/(2*xstep);
            X(t+1) = X(t) + round(dxp);
            DistOp(t+1) = X(t) + dxp;
            Eop(t) = 0.8 *  EffortOp(t) * (((v1ms+v2ms)*tstep)/2) + ACM_energy;
            Power(t) = Eop(t) / tstep; 
            Current(t) = Power(t) / Voltage;
            BrakingEnergy = BrakingEnergy + 0.8 *  EffortOp(t) * (((v1ms+v2ms)*tstep)/2);
        end
    else
        X(t) = NoX;
        V(t) = 1;
        break;
    end
end
toc
Vout2 = V;
Xout2 = X;
DistOpout2 = DistOp;
EffortOpout2 = EffortOp;
FAccOpout2 = FAccOp;
FROpout2 = FROp;
Eopout2 =  Eop;
Gopout2 = Gop;

DrivingEnergy2 = (DrivingEnergy*2.77777778)/(10^7);
BrakingEnergy2 = (BrakingEnergy*2.77777778)/(10^7);


end