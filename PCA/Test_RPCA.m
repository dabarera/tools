% Test RPCA code

N = 20; % dim 
M = 10; % Instances 
A = rand(N,M); % N-dim , M - instances

[EigVecs, EigVals, MeanVal] = RPCA(A);

disp(EigVals);
disp(EigVecs);
disp(MeanVal);

Weights = GetWeightsRPCA(A, EigVecs,MeanVal);

