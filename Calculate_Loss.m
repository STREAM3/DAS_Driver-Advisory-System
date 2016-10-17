% Nima Ghaviha (nima.ghaviha@mdh.se)
% 2016-10-17

% Thi function can be used to calculate dynamic loss based on Tractive
% Effort (Ft) and Velocity (V). The loss is calculated using a polynomial.
% The constants for the polynomial is based on the train configuration. 
function [ loss ] = Calculate_Loss( V, Ft, tstep)

x = V;
y = Ft;

loss_W = p00 + p10*x + p01*y + p20*x^2 + p11*x*y + p02*y^2 + p30*x^3 + p21*x^2*y + p12*x*y^2 + p40*x^4 + p31*x^3*y + p22*x^2*y^2; % Power [W]
loss = loss_W * tstep; %loss energy in one time step [j]
 
end

