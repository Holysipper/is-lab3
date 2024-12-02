clear;

% Sukurti spindulio tipo baziniu funkciju tinkla
% vienas iejimas

x = 0.1:1/22:1;

% isejimas

y = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2;

% neuronu tinklas su vienu iejimu, du neuronai pasleptame sluoksnyje,
% spindulio funkcija - Gauso . Isejime - vienas neuronas,
% kurio aktyvavimo funkcija - tiesine.


w11_2 = randn(1);
w12_2 = randn(1);
w0 = randn(1);


fplot(@(x) (1 + 0.6*sin(2*pi*(x)/0.7) + 0.3*sin(2*pi*(x)))/2, [0.1 1], 'r');
hold on;
c1 = 0.2; c2 = 0.9;
r1 = 0.16; r2 = 0.16;

% Mokymo zingsnis
zingsnis = 0.1;
% ciklas visoms vertems
for i = 1:length(x)
    % Gauso funkcijos
    fi_1 = exp(-((x(i)-c1)^2)/(2*r1^2));
    fi_2 = exp(-((x(i)-c2)^2)/(2*r2^2));
        
    v1_2 = w11_2*fi_1+w12_2*fi_2 + w0;
    y1_2(i) = v1_2;

    E(i) = y(i) - y1_2(i);
    w11_2 = w11_2 + zingsnis * E(i) * fi_1;
    w12_2 = w12_2 + zingsnis * E(i) * fi_2;
    w0  = w0 + zingsnis * E(i);
end


% Kartojame mokyma, kad kalida butu kuo mazesne, daugiau iteraciju -
% mazesne klaida
for iterations = 1: 1000000
    for i = 1:length(x)
    % Gauso f-jos
    fi_1 = exp(-((x(i)-c1)^2)/(2*r1^2));
    fi_2 = exp(-((x(i)-c2)^2)/(2*r2^2));
    
    % pasvertoji suma isejimo neuronui
    
    v1_2 = w11_2*fi_1+w12_2*fi_2 + w0;
    y1_2(i) = v1_2;
    
    E(i) = y(i) - y1_2(i);
    w11_2 = w11_2 + zingsnis * E(i) * fi_1;
    w12_2 = w12_2 + zingsnis * E(i) * fi_2;
    w0  = w0  + zingsnis * E(i);
    end
end

plot(x,y1_2,'bO');
hold on;
legend("Originali sinusoide","SBF tinklo aproksimacija");

x = 0.1:1/25:1;

% isejimas

y = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2;

for i = 1:length(x)
    % Gauso f-jos
    fi_1 = exp(-((x(i)-c1)^2)/(2*r1^2));
    fi_2 = exp(-((x(i)-c2)^2)/(2*r2^2));
    
    % pasvertoji suma isejimo neuronui
    
    v1_2 = w11_2*fi_1+w12_2*fi_2 + w0;
    y1_2(i) = v1_2;
end

figure;
fplot(@(x) (1 + 0.6*sin(2*pi*(x)/0.7) + 0.3*sin(2*pi*(x)))/2, [0.1 1], 'r');
hold on;
plot(x, y1_2, '--r');
legend("Nauja sinusoide", "Aproksimacija");
title('testas');