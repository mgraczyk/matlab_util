function [ltStr] = printLatexTable(varargin)

% printLatexTabular Returns a string which is a latex tabular
%     represented by the data in varargin

if (nargin < 2)
   error('Cannot print zero columns');
end

if (rem(nargin,2) ~= 0)
   error('Do not pass an odd number of varargs');
end

digits = 8;
numCols = (nargin)/2;
nl = char(10);
indent = '   ';
data = [];

numRows = size(varargin{2},1);
if (numRows == 1)
   numRows = size(varargin{2},2);
end

sz = 6 + numCols + numCols*numRows;
strings = cell(1,sz);

strings{1} = ['\begin{tabular}{', repmat('l ',1,numCols),'}', nl, indent, '\hline', nl, indent];

currCell = 2;
for c = 1:2:(nargin - 3);
   strings{currCell} = ['\multicolumn{1}{c}{\pmb{', varargin{c}, '}} & '];
   currCell = currCell + 1; 
end

strings{currCell} = ['\multicolumn{1}{c}{\pmb{', varargin{end-1}, '}} \\', nl, indent, '\hline', nl];
currCell = currCell + 1;

for c = 2:2:nargin
   currColData = varargin{c};
   
   if (isrow(currColData))
      currColData = currColData';   
   end

   if (size(currColData,1) ~= numRows) 
      error(sprintf('data arg %d has the wrong size', c));
   end
   
   data = [data currColData];
end

for i = 1:numRows  
    strings{currCell} = indent;
    currCell = currCell+1;
    
    for j = 1:(numCols-1)
        strings{currCell} = [num2str(data(i,j), digits), ' & '];
        currCell = currCell+1;
    end
   
    strings{currCell} = [num2str(data(i,numCols), digits), ' \\', nl];
    currCell = currCell+1;
end

strings{currCell} = [indent, '\hline', nl];
currCell = currCell+1;

strings{currCell} = ['\end{tabular}', nl];
ltStr = char(cellstr(cell2mat(strings)));

end