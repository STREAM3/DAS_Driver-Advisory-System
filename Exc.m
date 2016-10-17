% Nima Ghaviha (nima.ghaviha@mdh.se)
% 2016-10-17

% This function is used to export the results in a excel file. 

function Export = Exc(V, X, DistOp, EffortOp, FAccOp, FROp, Eop, Gop, path, tS, tstep, xstep, vstep, Energy)
xlswrite(path, {'Time[s]'}, 'A1:A1');
xlswrite(path, {'Velocity[km/h]'}, 'B1:B1');
xlswrite(path, {'Distance[m]'}, 'C1:C1');
xlswrite(path, {'Real Distance'}, 'D1:D1');
xlswrite(path, {'Tractive Effort[kN]'}, 'E1:E1');
xlswrite(path, {'Acceleration Force[kN]'}, 'F1:F1');
xlswrite(path, {'Running Resistance[kN]'}, 'G1:G1');
xlswrite(path, {'Energy[J]'}, 'H1:H1');
xlswrite(path, {'Gradient Force[kN]'}, 'I1:I1');
xlswrite(path, {'Total Energy'}, 'J1:J1');
xlswrite(path, {'KwH'}, 'K2:K2');


for i = 1 : tS+1
    temp = strcat('A', num2str(i+1), ':A', num2str(i+1));
    xlswrite(path, (i - 1) * tstep, temp);
end


xlswrite(path, (V - 1) * vstep, 'B2:B162');
xlswrite(path, (X - 1) * xstep , 'C2:C162');
xlswrite(path, DistOp , 'D2:D162');
xlswrite(path, EffortOp, 'E2:E162');
xlswrite(path, FAccOp, 'F2:F162');
xlswrite(path, FROp, 'G2:G162');
xlswrite(path, Eop, 'H2:H162');
xlswrite(path, Gop, 'I2:I162');
xlswrite(path, Energy, 'J2:J2');


Export = 1;

end