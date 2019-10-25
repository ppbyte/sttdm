%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Writes to the 'Results.txt' file.
%
% Name: Peng Peng
% Contact: dante.peng@gmail.com
% Date: Oct 17, 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function WriteResultLine(str, mode)
if(nargin < 2)
    mode = 'a';
end
fid = fopen('Results.txt', mode);
if fid~=0
    fprintf(fid, str);
    fprintf(fid, '\n');
end
fclose(fid);
end
