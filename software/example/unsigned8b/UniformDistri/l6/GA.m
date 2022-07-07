clc;
clear;

load('objectMat_l6.mat');
bit = [8 8];
l = 6;
lambda = 50000;
signEn = 0;
dN = 20;
step = 20;

objectFun = @(x) sum( sum( diag([1 x])*objectMat*diag([1 x]) ) );

rows = size(objectMat, 1);
nVars = rows - 1;
Lb = zeros(1, nVars);
Ub = ones(1, nVars);
IntCon = 1:nVars;

fun = @(x) objectFun(x) + x*ones(nVars, 1)*lambda;

results = [];
counter = 0;
while counter < 100
    disp(counter);
    [x, fval] = ga(fun, nVars, [], [], [], [], Lb, Ub, [], IntCon);
    results = [results; [sum(x) fval x]];
    results = sortrows(results, 2);
    results = results(1:min(size(results,1), dN), :);
    if mod(counter, step) == 0
        for jdx = 1:min(size(results, 1), dN)
            genVerilog(bit, l, lambda, jdx, results(jdx, :), dN, signEn);
            genCpp(bit, l, lambda, jdx, results(jdx, :), dN, signEn);
        end
    end
    counter = counter + 1;
end

function [] = genVerilog(bit, l, lambda, file_number, result, dN, signEn)
    verilog = "";
    verilog = verilog + "// terms: " + string(result(1)) + newline;
    verilog = verilog + "// fval:  " + string(result(2)) + newline + newline;
    if signEn == 0
        mul_name = "ubit" + string(bit(1)) + "x" + string(bit(2)) + "_l" + string(l) + "_lamb" + string(lambda) + "_" + num2str(file_number-1, '%0' + string(ceil(log10(dN))) + 'd');
        verilog = verilog + "module " + mul_name + " (" + newline;
        verilog = verilog + char(9) + "input [" + string( bit(1)-1 ) + ":0] x," + newline;
        verilog = verilog + char(9) + "input [" + string( bit(2)-1 ) + ":0] y," + newline;
        verilog = verilog + char(9) + "output [" + string( bit(1)+bit(2)-1 ) + ":0] z" + newline + ");" + newline + newline;
        verilog = verilog + "wire [" + string( bit(2)+bit(1)-l-1 ) + ":0] tmp_z = y*x[" + string( bit(1)-1 ) + ":" + string(l) + "];" + newline + newline;
        for idx = 1 : l
            verilog = verilog + "wire [" + string( bit(2)-1 ) + ":0] part" + string(idx) + " =  y & {" + string(bit(2)) + "{x[" + string( idx-1 ) + "]}};" + newline;
        end
        
        contents = get_contents(bit, result, signEn);
        
        verilog = verilog + newline;
        [~, F] = mode(contents( : , 4));
        for idx = 1 : F % depth
            verilog = verilog + "wire [" + string( max(contents( : , 4)) ) + ":0] new_part" + string(idx) + ";" + newline;
            for jdx = 0 : max(contents( : , 4)) % length
                verilog = verilog + "assign new_part" + string(idx) + "[" + string(jdx) + "] = ";
                [Lia, Loc] = ismember(jdx, contents( : , 4));
                if Lia == 0
                    verilog = verilog + "0;";
                else
                    row_number = mode(Loc, size(contents, 1));
                    part_index = contents(row_number, 1);
                    bit_index = contents(row_number, 2);
                    operation = contents(row_number, 3);
                    verilog = verilog + "part" + string(part_index) + "[" + string(bit_index) + "]";
                    if operation == 0
                        verilog = verilog + ";";
                    elseif operation == 1
                        verilog = verilog + " & part" + string( part_index+1 ) + "[" + string( bit_index-1 ) + "];";
                    elseif operation == 2
                        verilog = verilog + " | part" + string( part_index+1 ) + "[" + string( bit_index-1 ) + "];";
                    elseif operation == 3
                        verilog = verilog + " ^ part" + string( part_index+1 ) + "[" + string( bit_index-1 ) + "];";
                    end
                    contents(row_number, : ) = [];
                end
                verilog = verilog + newline;
            end
            verilog = verilog + newline;
        end
        % assign z
        verilog = verilog + "assign z = {tmp_z, " + string(l) + "'d 0}";
        for idx = 1 : F
            verilog = verilog + " + new_part" + string(idx);
        end
        verilog = verilog + ";" + newline + "endmodule";
        
        fid=fopen(mul_name + ".v", "wt");
        fprintf(fid, '%s\n', verilog);
        fclose(fid);
    end
end

function contents = get_contents(bit, result, signEn)
    x = result( 3 : size(result, 2) );
    if signEn == 0
        contents = [];
        for jdx = 1 : size(x, 2)
            if x(jdx) == 1
                if mod(jdx-1, (bit(2)-1)*6+2) == 0
                    part_index = 2*( floor( (jdx-1) / ((bit(2)-1)*6+2) ) ) + 1;
                    bit_index = 0;
                    operation = 0; % no operation
                    power = part_index - 1;
                elseif mod(jdx-1, (bit(2)-1)*6+2) == (bit(2)-1)*6+2 - 1
                    part_index = 2*( floor( (jdx-1) / ((bit(2)-1)*6+2) ) ) + 1 + 1;
                    bit_index = bit(2) - 1;
                    operation = 0; % no operation
                    power = part_index - 1 + bit(2) - 1;
                else
                    part_index = 2*( floor( (jdx-1) / ((bit(2)-1)*6+2) ) ) + 1;
                    bit_index = floor( ( mod(jdx-1, (bit(2)-1)*6+2) - 1 ) / 6 ) + 1;
                    operation = floor( mod( mod(jdx-1, (bit(2)-1)*6+2) - 1, 6 ) / 2) + 1; % 1: AND, 2: OR, 3: XOR
                    power = bit_index + (part_index - 1) + mod( mod( mod(jdx-1, (bit(2)-1)*6+2) - 1, 6 ), 2);
                end
                contents = [contents ; [part_index, bit_index, operation, power]];
            end
        end
    end
end

function [] = genCpp(bit, l, lambda, file_number, result, dN, signEn)
    cpp = "";
    cpp = cpp + "// terms: " + string(result(1)) + newline;
    cpp = cpp + "// fval:  " + string(result(2)) + newline + newline;
    cpp = cpp + "#include <bitset>" + newline;
    cpp = cpp + "#include <cmath>" + newline + newline;
    cpp = cpp + "using namespace std;" + newline + newline;
    if signEn == 0
        mul_name = "ubit" + string(bit(1)) + "x" + string(bit(2)) + "_l" + string(l) + "_lamb" + string(lambda) + "_" + num2str(file_number-1, '%0' + string(ceil(log10(dN))) + 'd');
        x_uint_width = 2^( ceil( log2( bit(1) ) ) );
        y_uint_width = 2^( ceil( log2( bit(2) ) ) );
        total_uint_width = 2^( ceil( log2(x_uint_width+y_uint_width) ) );
        cpp = cpp + "uint" + string(total_uint_width) + "_t " + mul_name + "(uint" + string(total_uint_width) + "_t i, uint" + string(total_uint_width) + "_t j) {" + newline + newline;
        cpp = cpp + "bitset<" + string( bit(1) ) + "> x = i;" + newline + newline;
        for idx = 1 : l
            cpp = cpp + "bitset<" + string( bit(2) ) + "> part" + string(idx) + " = j*x[" +  string(idx-1) + "];" + newline; 
        end
        
        cpp = cpp + newline + "uint" + string(total_uint_width) + "_t tmp_z = 0 ";
        for idx = l : bit(1)-1
            cpp = cpp + " + j*x[" + string(idx) + "]*pow(2, " + string(idx) + ")";
        end
        cpp = cpp + ";" + newline + newline;
        
        contents = get_contents(bit, result, signEn);
        
        cpp = cpp + "uint" + string(total_uint_width) + "_t z = tmp_z ";
        for row_number = 1 : size(contents, 1)
            part_index = contents(row_number, 1);
            bit_index = contents(row_number, 2);
            operation = contents(row_number, 3);
            power = contents(row_number, 4);
            
            cpp = cpp + " + (part" + string(part_index) + "[" + string(bit_index) + "]";
            if operation == 0
                cpp = cpp + "*pow(2, " + string(power) + "))";
            elseif operation == 1
                cpp = cpp + "&part" + string( part_index+1 ) + "[" + string( bit_index-1 ) + "])*pow(2, " + string(power) + ")";
            elseif operation == 2
                cpp = cpp + "|part" + string( part_index+1 ) + "[" + string( bit_index-1 ) + "])*pow(2, " + string(power) + ")";
            elseif operation == 3
                cpp = cpp + "^part" + string( part_index+1 ) + "[" + string( bit_index-1 ) + "])*pow(2, " + string(power) + ")";
            end
        end
        cpp = cpp + ";";
        cpp = cpp + newline + newline + "return z;" + newline + newline;
        cpp = cpp + "}";
        
        fid=fopen(mul_name + ".h", "wt");
        fprintf(fid, '%s\n', cpp);
        fclose(fid);
    end
end