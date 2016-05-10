function [ltStr] = printLatexTable(title, varargin)
% printLatexTable Returns a string consisting of a LaTeX table.
%  The table has the given title, and its contents consist of columns whose
%  titles are the even varargs, and data are the vectors corresponding to the column titles.


nl = char(10);
indent = '   ';

ltStr = char(cellstr(['\begin{table}[H]', nl, indent, '\centering', nl, indent, '\caption{' ,...
title, '}', nl, indent, printLatexTabular(varargin{:}), nl, '\end{table}']));

end