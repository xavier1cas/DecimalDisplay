clc, clear, close all

sign = 1; % 1==yes, 0==no
N = 16;
Q = 0;

exp = 0:8;
test = -2.^exp - 1

hex(fi(test, sign, N, Q))


pw = 8e-6 % us
f = 125e6 % MHz

count = f*pw