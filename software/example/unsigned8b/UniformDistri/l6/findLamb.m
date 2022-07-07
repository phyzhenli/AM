clc;
clear;

load('objectMat_l6.mat');
bit = [8 8];
l = 6;
areaR = 0.3;

objectFun = @(x) sum( sum( diag([1 x])*objectMat*diag([1 x]) ) );

rows = size(objectMat, 1);
nVars = rows - 1;
Lb = zeros(1, nVars);
Ub = ones(1, nVars);
IntCon = 1:nVars;

terms = nVars;
M = floor( l*bit(2) - bit(1) * bit(2) * areaR );

lamb = 1;
while terms > M
    lamb = lamb * 10;
    disp(lamb);
    fun = @(x) objectFun(x) + x*ones(nVars, 1)*lamb;
    [x, fval] = ga(fun, nVars, [], [], [], [], Lb, Ub, [], IntCon);
    terms = sum(x);
end

disp("lamb: ");
disp(lamb / 2);