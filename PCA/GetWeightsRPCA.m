function [Weights] = GetWeightsRPCA(Data , EigenVecs , MeanVal)
% GetWeights Summary 
%  A function to get the weight vector given the Eigen Vectors and Data. Designed to be used with RPCA by RD on April 9, 2013
%   INPUTS:
        % Data : [N x K] Matrix containing Data to be projected 
        %               where   N: Dimension of the features 
        %                       K: Number of Instances (or data samples)
        % EigenVecs : [N x F] Matrix contaning Eigen Vecors 
        %               where   N: Dimension of the features
        %                       F: Number of factors or the number of
        %                       principal compoennts. 
        % MeanVal : The mean Value of the Traning data (an output of RPCA function)

%   OUTPUTS:
        % Weights : [F x K] Matrix with Weights corresponding to Data given
        %               Here F and K follow the same notation as INPUTS
% 



%%% CHECKING THE INPUTS 
Number_of_inputs = 3;

if nargin == Number_of_inputs
    disp(' ')
else
    error('Please give the inputs, as: Data, EigenVecs, MeanVal')
end 


if size(Data,1) ~= size(EigenVecs,1)
   error('The Dimentions of the Feature both in Data and Eigenvectos has to match!') 
end


%%% ARRANGING THE INPUT DATA


K = size(Data,2);


MeanMat = repmat(MeanVal,1,K);

Normalized_Data = Data - MeanMat;

Weights = (EigenVecs)'*Normalized_Data;