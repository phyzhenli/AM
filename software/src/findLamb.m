clc;
clear;

load('objectMat_l2.mat');
objectFun = @(x) sum( sum( diag([1 x])*objectMat*diag([1 x]) ) );

[rows, cols] = size(objectMat);
nVars = rows - 1;
Lb = zeros(1, nVars);
Ub = ones(1, nVars);
IntCon = 1:nVars;

terms = nVars;
M = 10;

lambda = 1;
while terms > M
    fun = @(x) objectFun(x) + x*ones(nVars, 1)*lambda;
    [x, fval] = ga(fun, nVars, [], [], [], [], Lb, Ub, [], IntCon);
    terms = sum(x);
    lambda = lambda * 10;
end