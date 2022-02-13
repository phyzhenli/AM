clc
clear

fun = @ ; % add the objective function

nVars = ; %
Lb = zeros(1, nVars);
Ub = ones(1, nVars);

IntCon = 1:nVars;

range = : ; % add the range of the number of compressed terms
for count = range
    if eval(['exist("fval', num2str(count), '","file")']) == 0
        eval(['fval', num2str(count), '= ;']); % add the fval for initialization
    else
        eval(['fval', num2str(count), '= importdata("fval', num2str(count), '");']);
    end
    eval(['x', num2str(count), ' = ones(1, nVars);']);
    eval(['c', num2str(count), ' = 0;']);
end

for idx = 1: % add cycle number 
    [x_test, fval_test] = ga(fun, nVars, [], [], [], [], Lb, Ub, [], IntCon);
    for count = range
        if sum(x_test) == count
            eval(['c', num2str(count), ' = ', 'c', num2str(count), ' + 1;']);
            if fval_test <= eval(['fval', num2str(count)])
                eval(['fval', num2str(count), '= fval_test']);
                eval(['x', num2str(count), ' = string(x_test)']);
                
                fid=fopen(['fval', num2str(count)], "w");
                fprintf(fid,'%s\n', eval(['fval', num2str(count)]));
                fclose(fid);
                
                fid=fopen(['x', num2str(count), '_test.txt'], "w");
                fprintf(fid,'%s\n', eval(['x', num2str(count)]));
                fclose(fid);
            end
        end
    end

end
