clear;
clc;

tStart = tic;
bit = ; % width of the multiplier

% data distributions
p1 = importdata("");
p2 = importdata("");

% modify p1 and p2 to be two 1D vectors for matrix calculation

%%
tFor = tic;
nVars = ; % the size of the matrix
tmpFun = zeros(nVars, nVars);
objectMat = zeros(nVars, nVars);

p = parpool(128); % parallel
% int32(-2^(bit-1)):int32(2^(bit-1)-1) signed mul
% 0:int32(2^bit-1)              unsigned mul
parfor idx = 0:int32(2^bit-1)
    tic;
    display(idx);
    n = zeros(nVars, 1);
    for jdx = 0:int32(2^bit-1)
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
            % end

            f = [f part_pro];
        end
        % f = [f 1 1]; % signed mul
        f = int64(f);

        n(1,1) = int64( (idx * jdx) ) - % the sum of the uncompressed partial products % ;

        % generated by gencode
        n(2,1) = ;
        .
        .
        .
        n() = ;
        
        n = n * ((p1(1, idx+1) / total_p1 )^(0.5)) * ( (p2(1, jdx+1)/ total_p2 )^(0.5)); % unsigned mul
        % n = n * ((p1(1, idx + 2^(bit-1) + 1) / total_p1 )^(0.5)) * ((p2(1, idx + 2^(bit-1) + 1) / total_p2 )^(0.5)); % signed mul

        %%%%%%%%%%%%%%% swap p1 and p2 %%%%%%%%%%%%

        tmpFun = n * n.';
        objectMat = objectMat + tmpFun;
    end
    toc;
end
delete(p);
display(toc(tFor));

save('objectMat.mat', 'objectMat');

% quit;

