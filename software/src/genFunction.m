clear;
clc;

bit = ; % width of the multiplier
bitN = bit; % unsigned mul
& bitN = bit - 1; % signed mul

% data distributions
p1 = importdata("");
p2 = importdata("");

% modify p1 and p2 to be two 1D vectors for matrix calculation

nVars = ; % the size of the matrix
n = zeros(nVars, 1);
a = zeros(nVars, nVars);
b = zeros(nVars, nVars);

% int32(-2^bitN):int32(2^bitN-1) signed mul
% 0:int32(2^bitN-1)              unsigned mul
for idx = 0:int32(2^bitN-1)
    for jdx = 0:int32(2^bitN-1)
        f = [];
        for cdx = 1:bit

            % unsigned mul
            part_pro = int32(jdx * bitget(idx, cdx));
            part_pro = bitget(part_pro, 1:1:bit);

            % signed mul
            % part_pro = int32(jdx * bitget(idx, cdx));
            % if cdx == bit
            %     part_pro = ~bitget(part_pro, 1:1:bit);
            %     part_pro(1, bit) = ~part_pro(1, bit);
            % else
            %     part_pro = bitget(part_pro, 1:1:bit);
            %     part_pro(1, bit) = ~part_pro(1, bit);
            end

            f = [f part_pro];
        end
        % f = [f 1 1]; % signed mul
        f = int64(f);

        n(1,1) = int64( (idx * jdx) ) - % the sum of the uncompressed partial products % ;

        % generated by gencode
        n(2,2) = ;
        .
        .
        .
        n() = ;
        
        n = n * ((p1(1, idx+1) / total_p1 )^(0.5)) * ( (p2(1, jdx+1)/ total_p2 )^(0.5)); % unsigned mul
        % n = n * ((p1(1, idx + 2^bitN + 1) / total_p1 )^(0.5)) * ((p2(1, idx + 2^bitN + 1) / total_p2 )^(0.5)); % signed mul

        %%%%%%%%%%%%%%% swap p1 with total_p1 and p2 with total_p2 will impact the result %%%%%%%%%%%%

        a = n * n.';
        b = b + a;
        
    end
end


b_test = b;
[r, c] = size(b_test);
for idx = 1:r
    for jdx = 1:c
        if idx < jdx
            b_test(idx, jdx) = b_test(idx, jdx) + b_test(jdx, idx);
        elseif jdx < idx
            b_test(idx, jdx) = 0;
        end
    end
end


b_str = string(b_test);
for jdx = 2:c
    eval(['b_str(1, jdx) = strcat(b_str(1, jdx), ', '"*x(', num2str(jdx-1), ')")', ';']);
end
for idx = 2:r
    for jdx = 2:c
        if idx <= jdx
            eval(['b_str(idx, jdx) = strcat(b_str(idx, jdx), ', '"*x(', num2str(idx-1), ')*x(', num2str(jdx-1), ')")', ';']);
        end
    end
end


b_sym = str2sym(b_str);
objective_function = string(sum(sum(b_sym)));


fid=fopen("objective_function.txt", "w");
fprintf(fid,'%s\n',objective_function);
fclose(fid);


disp("ok");