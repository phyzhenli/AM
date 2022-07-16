clc;
clear;

width = [8 8];
g = width(1);
h = width(2);
l = 6;
sign = 0;
areaR = 0.3;

if sign == 0
    mat_file = "unsigned_";
else
    mat_file = "signed_";
end
mat_file = mat_file + string(g) + "x" + string(h) + "_l" +string(l);
load(mat_file);

objectFun = @(x) sum( sum( diag([1 x])*objectMat*diag([1 x]) ) );

Z = ( 3*h - 2) * l;
Lb = zeros(1, Z);
Ub = ones(1, Z);
IntCon = 1:Z;

terms = Z;
M = floor( l*h - g*h*areaR );

lamb = 1;
while terms > max{M, 0}
    disp(lamb);
    fun = @(x) objectFun(x) + x*ones(Z, 1)*lamb;
    [x, fval] = ga(fun, Z, [], [], [], [], Lb, Ub, [], IntCon);
    terms = sum(x);
    lamb = lamb * 10;
end

disp("lamb: ");
disp(lamb / 10);
