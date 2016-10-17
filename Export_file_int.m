% Nima Ghaviha (nima.ghaviha@mdh.se)
% 2016-10-17

% This function is used for saving the results of the offline calculation
% to a binary file. 
function temp = Export_file_int(Vop, tS, xS, vS, TTime, TDistance, MaxSpeed, Mass, SpeedLimits, Elevations, GS_F, minusT, plusT, Arr, Brr, Crr, ACMPower, MaxTrac, MaxBrake, BRPoint)


var_temp = zeros(9, 1);
var_temp(1, 1) = tS;
var_temp(2, 1) = xS;
var_temp(3, 1) = TTime;
var_temp(4, 1) = TDistance;
var_temp(5, 1) = MaxSpeed;
var_temp(6, 1) = Mass;
var_temp(7, 1) = vS;
var_temp(8, 1) = minusT;
var_temp(9, 1) = plusT;
var_temp(10, 1) = Arr;
var_temp(11, 1) = Brr;
var_temp(12, 1) = Crr;
var_temp(13, 1) = ACMPower;
var_temp(14, 1) = MaxTrac;
var_temp(15, 1) = MaxBrake;
var_temp(16, 1) = BRPoint;

F_GS = fopen(GS_F, 'w');
fwrite(F_GS, var_temp, 'double');

fwrite(F_GS, SpeedLimits, 'double');

fwrite(F_GS, Elevations, 'double');

fwrite(F_GS, Vop, 'short');

fclose(F_GS);
temp = 0;

fclose(F_GS);
temp = 0;

end

