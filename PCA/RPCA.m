function [ EigenVecs , EigenVals , MeanVal ] = RPCA( B , Factors )
%RPCA Summary of the function
%  Generalised PCA by RD on April 5, 2013
%   INPUTS: 
        % A : [N by M] Matrix containing values 'double'
        %       where N: dimension of features (for image it's the number of pixels etc...)    
        %             M: Number of instances (say how many traning samples)
        % Factors (optional): Number of Principal components to return
        % 
%   OUTPUTS:
        % EigenVecs : Eigenvectors corresponding to eigenvalues ordered
                % descendingly. If the input 'Factors' given, then the
                % number of 'EigenVecs' will be similar to 'Factors'
        % EigenVals : the Eigen Values corresponding to EigenVecs.
        % MeanVal: Mean Value of the samples given 
% For more details Read : Eigenfaces for Recognition: Turk and Pentland
% Further Questions or bugs: write to ranga@miami.edu



%%% CHECKING THE INPUT ARGUMENTS 
    Number_of_inputs = 2;

    if nargin == 1

        Factors = 0;
    elseif (nargin<1 || nargin >Number_of_inputs) 
        error(' Please give the correct number of inputs... You cant Do this OSCAR! :D I quit ... ');
    end

%%% Modifying the B for any variable differences 

B(isnan(B)) = 0 ; % Changing NaN values to zero 
B = double(B); % Making all values Numeric
    
    
%%% CHECKING THE TYPE OF PCA via MATRIX DIMENSIONS 
    [N M] = size(B); 

    Eigenface_FLAG = 0; % FLAG for Eigenfaces. If the dimentions of features are higher then we follow the Eigenface Approach

    if N>M
        disp('The Feature Dimentions are higher compared to sample instances, So we use approch in Eigenface');
        Eigenface_FLAG = 1;
        if Factors>M
            error('The Number of Factors has to be less than or equal to Number of Instances. (Even Spetember Knows that!)');
        end
    else
        disp('We use General PCA, assuming there samples and features are independed from each other'); 
        if Factors>N
            error('The Number of Factors has to be less than or equal to Number of Features. (We Cant do this Martinez!) ');
        end

    end
    
    
    
%%% Starting the Business with 'eig' Function in Matlab


MeanVal = mean(B,2);

A = zeros(size(B));

for i = 1:M
    A(:,i) = (B(:,i) - MeanVal);    % Adjusting for the Bias 
end


if Eigenface_FLAG
    disp('Performing Dimentionality reduction via Eigenfaces...');
    
    L = A'*A;  % MxM Matrix
    [V D] = eig(L);
    
    
   
    
    
    EigenVals_Temp = diag(D);
    [EigenVals_FULL IX] = sort(EigenVals_Temp ,'descend');


    EigenVecs_Temp = V(:,IX);
    EigenVecs_FULL = A*EigenVecs_Temp; 
    
     
     if Factors == 0
         EigenVecs = EigenVecs_FULL(:,(EigenVals_FULL >1));
         EigenVals = EigenVals_FULL(EigenVals_FULL>1);
     else
         
         EigenVals = EigenVals_FULL(1:Factors);
         EigenVecs = EigenVecs_FULL(:,1:Factors);
     end
    
else
    disp('Performing Dimentionality reduciton via general PCA');
    
    C = A*A';
    [V D] = eig(C);
    
    
    EigenVals_Temp = diag(D);
    [EigenVals_FULL IX] = sort(EigenVals_Temp ,'descend');

    EigenVecs_FULL = V(:,IX); 
    
    
     if Factors == 0
         EigenVecs = EigenVecs_FULL(:,(EigenVals_FULL >1));
         EigenVals = EigenVals_FULL(EigenVals_FULL>1);
     else
         
         EigenVals = EigenVals_FULL(1:Factors);
         EigenVecs = EigenVecs_FULL(:,1:Factors);
     end
    
    
end

 
 
 disp('Dimensionality Reduction Successful.')
 
end

