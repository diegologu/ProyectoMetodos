%By Diego Lopez

close all
clear all
clc

E = 69e6; % (Pa)
th = 2e-3; % (m)
poi = 0.33;

D = (E*th^2)/(12*(1-po^2));
q = 33.6e3; %(N/m)

%delta x  = delta y = h

h = 15e-3; % (m)

global Z;
global U;
Z = zeros(940);
U = zeroz(940);

%Condiciones de frontera
U(1,1) = 0;
U(1,end) = 0;

for i=1:942
  if i~=1 || i~=942
    U(i,i) = -4;%centro
    U(i,i+1) = 1;%derecha
    U(i,i-1) = 1;%izquierda

    if i <= 682 %sector 1
      body
    elseif i <= 769 %sector 2
      body
    elseif i <= 823 %sector 3
      body
    elseif i <= 848 %sector 4
      body
    elseif i <= 871 %sector 5
      body
    elseif i <= 892 %sector 6
      body
    elseif i <= 911 %sector 7
      body
    elseif i <= 926 %sector 8
      body
    elseif i <= 938 %sector 9
      body
    else %sector 10
      body
    end


    U(i,i) = 1;%arriba
    U(i,i) = 1;%abajo
  end
end
