%By Diego Lopez

close all
clear all
clc

nodos = 978;
E = 72e9; % (Pa)
th = 5e-3; % (m)
poi = 0.33;

D = (E*th^2)/(12*(1-po^2));
q = 33.6e3; %(N/m)

%delta x  = delta y = h

h = 15e-3; % (m)

global Z;
global U;
Z = zeros(nodos-2);
U = zeros(nodos-2);

%BC
U(1,1) = 0;
U(1,end) = 0;

for i=1:nodos
  if i~=[1 32] %contrains
    U(i,i) = -4;%center
    sector = locator(i);
    if ~isVoidRight(i,sector)
      U(i,i+1) = 1;%right
    end
    U(i, i+stepToAbove(i, sector)) = 1; %above
end

function sector = locator(i)
  %  Returns the sector where a given i is located.
  if i <= 704 %sector 1
    sector = 1;
  elseif i <= 794 %sector 2
    sector = 2;
  elseif i <= 850 %sector 3
    sector = 3;
  elseif i <= 876 %sector 4
    sector = 4;
  elseif i <= 900 %sector 5
    sector = 5;
  elseif i <= 922 %sector 6
    sector = 6;
  elseif i <= 942 %sector 7
    sector = 7;
  elseif i <= 958 %sector 8
    sector = 8;
  elseif i <= 970 %sector 9
    sector = 9;
  else %sector 10
    sector = 10;
  end
end

function out = isVoidRight(i, sector)
  switch sector
    case 1
      out = mod(i,32) == 0;
    case 2
      out = i==734:30:794;
    case 3
      out = i==[822 850];
    case 4
      out = i==876;
    case 5
      out = i==900;
    case 6
      out = i==922;
    case 7
      out = i==942;
    case 8
      out = i==958;
    case 9
      out = i==970;
    case 10
      out = i==978;
  end
end

function out = isVoidAbove(i, sector)
  switch sector
    case 1
      out = i==[673 704];
    case 2
      out = i==[765 794];
    case 3
      out = i==[823 850];
    case 4
      out = i==[851 876];
    case 5
      out = i==[877 900];
    case 6
      out = i==[901 922];
    case 7
      out = i==[923 924 941 942];
    case 8
      out = i==[943 944 957 958];
    case 9
      out = i==[959 960 969 970];
    case 10
      out = 1;
  end
end

function step = stepToAbove(i, sector)
  if ~isVoidAbove(i,sector)
    switch sector
      case 1
        if i==[674:703]
          step = 31;
        else
          step = 32;
        end
      case 2
        if i==[766:793]
          step = 29;
        else
          step = 30;
        end
      case 3
        if i==[824:849]
          step = 27;
        else
          step = 28;
        end
      case 4
        step = 25;
      case 5
        step = 23;
      case 6
        step = 21;
      case 7
        step = 18;
      case 8
        step = 14;
      case 9
        step = 10;
  end
end
