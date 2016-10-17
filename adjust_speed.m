% Nima Ghaviha (nima.ghaviha@mdh.se)
% 2016-10-17
function Speed = adjust_speed(TDist, X, dest)

Sp1 = xlsread(dest, 'A1:B161'); 
T2 = size(Sp1);
SizeSp = T2(1,1);
xstep = X;
TotalDist = TDist;
Num = TotalDist/xstep + 1;
Sp3 = zeros(Num,2);
Sp2 = zeros(SizeSp(1,1)+1,2);
Speed = zeros(Num,1);
SpFinal = zeros(Num,1);

for i = 1 : SizeSp
    Sp2(i,1) = (floor(Sp1(i,1)/xstep)+1);
    Sp2(i,2) = Sp1(i,2);
    
end


for j = 1 : Num
    Sp3(j,1) = j;
end

for k = 1 : SizeSp
    Sp3(Sp2(k,1),2) = Sp2(k,2); 
    SpFinal(Sp2(k,1),1) = Sp2(k,2);
end



temp = Sp2(1,2);
count = Sp2(2,1);
u = 2;

for p = 1 : Num
    
    
    
    if p ~= count
        Sp3(p,2) = temp;
        SpFinal(p,1) = temp;
    else
        
        temp = Sp2(u,2);
        count = Sp2(u+1,1);
        u = u + 1;
    end
    
    
end
    
Speed = SpFinal;

end