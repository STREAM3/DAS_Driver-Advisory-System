% Nima Ghaviha (nima.ghaviha@mdh.se)
% 2016-10-17

% This function is used to import the data binary file to be used on the
% train for the online advisory system. 
function [VopOut, t, x, vS, TripTime, TripDistance, MaxSpeed, Mass, SL, Elev, minusT, plusT, Arr, Brr, Crr, ACMPower, MaxTrac, MaxBrake, BRPoint] = import_file_int(GS)


F_GS = fopen(GS, 'r');
var_temp = fread(F_GS, [16,1], 'double');
tS = var_temp(1,1);
xS = var_temp(2,1);
TTime = var_temp(3,1);
TDistance = var_temp(4,1);
Max_speedR = var_temp(5,1);
TMass = var_temp(6,1);
vS = var_temp(7,1);
minusT = var_temp(8,1);
plusT = var_temp(9,1);
Arr = var_temp(10,1);
Brr = var_temp(11,1);
Crr = var_temp(12,1);
ACMPower = var_temp(13,1);
MaxTrac = var_temp(14,1);
MaxBrake = var_temp(15,1);
BRPoint = var_temp(16,1);


tstep = TTime / tS;
plusTstep = round(plusT / tstep);
NoT = tS + 1;
NoX = xS + 1;
NoT2 = NoT + plusTstep;
SpeedL = zeros(xS+1, 1);
Elevations = zeros(xS+1, 1);
SL = zeros(xS+1, 1);
Elev = zeros(xS+1, 1);

SpeedL = fread(F_GS, [xS+1,1], 'double');
Elevations = fread(F_GS, [xS+1,1], 'double');

Vop = ones([NoT2 NoX vS + 1]);

%%%%%%%%%%%%%
for j = 1 : vS + 1
    Vop(:,:,j) = fread(F_GS, [NoT2, NoX], 'short');
end

%%%%%%%%%%%%%
fclose(F_GS);

t = tS;
x = xS;
TripTime = TTime;
TripDistance = TDistance;
MaxSpeed = Max_speedR;
Mass = TMass;
SL = SpeedL;
Elev = Elevations;

VopOut = Vop;
end