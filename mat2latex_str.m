function [ltStr] = mat2latex_str(vec, varargin)
%PRINT2LATEX Summary of this function goes here
%   Detailed explanation goes here
digits = 6;

if (nargin > 1)
   digits = varargin{1}; 
end

N = size(vec,1);
M = size(vec,2);

indent = '   ';

strings = cell(1, N*M + N + 2);
strings{1} = ['\begin{bmatrix}', char(10)];
currCell = 2;


for i = 1:N  
    strings{currCell} = indent;
    currCell = currCell+1;
    
    for j = 1:(M-1)
        strings{currCell} = [num2str(vec(i,j), digits), ' & '];
        currCell = currCell+1;
    end
   
    strings{currCell} = [num2str(vec(i,M), digits), ' \\', char(10)];
    currCell = currCell+1;
end

strings{end} = ['\end{bmatrix}', char(10)];

ltStr = char(cellstr(cell2mat(strings)));

end

