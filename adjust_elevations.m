% Nima Ghaviha (nima.ghaviha@mdh.se)
% 2016-10-17
function Elevation = adjust_elevations(TDist, X, dest2)


Elev1 = xlsread(dest2, 'A1:B161'); 
T1 = size(Elev1);
SizeElev = T1(1,1);
xstep = X;
TotalDist = TDist;
Num = TotalDist/xstep + 1;
Elev3 = zeros(Num,2);
Elev2 = zeros(SizeElev(1,1)+1,2);
Elevation = zeros(Num,1);
ElevFinal = zeros(Num,1);

for i = 1 : SizeElev
    Elev2(i,1) = (floor(Elev1(i,1)/xstep)+1);
    Elev2(i,2) = Elev1(i,2);
    
end


for j = 1 : Num
    Elev3(j,1) = j;
end

for k = 1 : SizeElev
    Elev3(Elev2(k,1),2) = Elev2(k,2);
    ElevFinal(Elev2(k,1),1) = Elev2(k,2);
end



temp = Elev2(1,2);
count = Elev2(2,1);
u = 2;

for p = 1 : Num
    
    
    
    if p ~= count
        Elev3(p,2) = temp;
        ElevFinal(p,1) = temp;
    else
        
        temp = Elev2(u,2);
        count = Elev2(u+1,1);
        u = u + 1;
    end
    
    
end
    
Elevation = ElevFinal;

end