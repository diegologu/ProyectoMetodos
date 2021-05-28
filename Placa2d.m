%By Diego Lopez

close all
clear
clc

global nodes;
global constrains;
nodes = 978;
E = 69e9; % (Pa)
th = 5e-3; % (m)
po = 0.33;
D = (E*th^2)/(12*(1-po^2));
q = 3.35; %(KN/m^2)
q_D = ones(nodes-32,1) * (q/D);
d = 0;

constrains =  [1:32 33 64 65 96 97 128 129 160 161 192 193 224 225 256 257 ...
              288 289 320 321 352 353 384 385 416 417 448 449 480 481 512 ...
              513 544 545 576 577 608 609 640 641 672 673 704 705 734 735 ...
              764 765 794 795 822 823 850 851 876 877 900 901 922 923 942 ...
              943 958 959 970:978];

while d<0.1
  q = q+0.01;
  q_D = ones(nodes-length(constrains),1) * (q/D);
  u = solver(q_D);
  z = solver(u);
  d = max(z);
end
disp('Max q:')
disp(q)

function x = solver(B)
  % A*x = B
  global nodes;
  global constrains;
  A = zeros(nodes);
  for i=1:nodes
    if ~ismember(i,constrains)
      A(i,i) = -4;%center
      sector = locator(i);
      if ~isVoidRight(i,sector)
        A(i,i+1) = 1;%right
      end
      if ~isVoidAbove(i,sector)
        A(i, i+stepToAbove(i, sector)) = 1; %above
      end
      if ~isVoidLeft(i,sector)
        A(i,i-1) = 1;%left
      end
      if ~isVoidBelow(i,sector)
        A(i, i-stepToBelow(i, sector)) = 1; %below
      end
    end
  end
  A(constrains,:) = [];
  A(:,constrains) = [];
  x = A\B;
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
      out = ismember(i,734:30:794);
    case 3
      out = ismember(i,[822 850]);
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
      out = ismember(i,[673 704]);
    case 2
      out = ismember(i,[765 794]);
    case 3
      out = ismember(i,[823 850]);
    case 4
      out = ismember(i,[851 876]);
    case 5
      out = ismember(i,[877 900]);
    case 6
      out = ismember(i,[901 922]);
    case 7
      out = ismember(i,[923 924 941 942]);
    case 8
      out = ismember(i,[943 944 957 958]);
    case 9
      out = ismember(i,[959 960 969 970]);
    case 10
      out = 1;
  end
end

function step = stepToAbove(i, sector)
  step = 1;
  switch sector
    case 1
        if ismember(i,674:703)
          step = 31;
        else
          step = 32;
        end
    case 2
        if ismember(i,766:793)
          step = 29;
        else
          step = 30;
        end
    case 3
        if ismember(i,824:849)
          step = 27;
        else
          step = 28;
        end
    case 4
        step = 25;
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

function out = isVoidLeft(i, sector)
  switch sector
    case 1
      out = ismember(i,1:32:673);
    case 2
      out = ismember(i,705:30:765);
    case 3
      out = ismember(i,[795 822]);
    case 4
      out = i==851;
    case 5
      out = i==877;
    case 6
      out = i==901;
    case 7
      out = i==923;
    case 8
      out = i==943;
    case 9
      out = i==959;
    case 10
      out = i==971;
  end
end

function out = isVoidBelow(i, sector)
  switch sector
    case 1
      out = ismember(i,2:31);
    otherwise
      out = false;
  end
end

function step = stepToBelow(i, sector)
  switch sector
    case 1
        step = 32;
    case 2
        if ismember(i,705:734)
          step = 31;
        else
          step = 30;
        end
    case 3
        if ismember(i,795:822)
          step = 29;
        else
          step = 28;
        end
    case 4
        step = 27;
    case 5
        step = 25;
    case 6
        step = 23;
    case 7
        step = 21;
    case 8
        step = 18;
    case 9
        step = 14;
    case 10
        step = 10;
   end
end
