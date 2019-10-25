%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gets the correlation between the predicted quality and subject quality.
% 
% 4 metrics included:
%     (1) SRCC (Spearman's Rank Correlation Coefficient)
%     (1) KRCC (Kendall's Rank Correlation Coefficient)
%     (1) PLCC (Pearson's' Linear Correlation Coefficient)
%     (1) RMSE (Root Mean Squared Error)
%
% Name: Peng Peng
% Contact: dante.peng@gmail.com
% Date: Sept 20, 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [srcc, krcc, plcc, RMSE] = Performance(predictions, dmos, selected_videos, tag, printToFile)
if nargin < 5
    printToFile = true;
end
if nargin < 4
    tag = 'Performance';
end
if nargin < 3
    selected_videos = true(length(dmos), 1);
end
predictions = predictions(selected_videos);
dmos = dmos(selected_videos);
srcc = corr(predictions, dmos, 'type', 'Spearman');
krcc = corr(predictions, dmos, 'type', 'Kendall');

%  plcc = 0;
%  RMSE = 0;

% %    plcc = corr(predictions(selected_videos), dmos(selected_videos), 'type', 'Pearson');

mos = dmos;
beta(1) = max(mos);
beta(2) = min(mos);
beta(3) = mean(predictions);
beta(4) = 0.1;
beta(5) = 0.1;
%fitting a curve using the data
[bayta ehat,J] = nlinfit(predictions,mos,@Logistic,beta, statset('Display','off'));
%given a ssim value, predict the correspoing mos (ypre) using the fitted curve
[ypre junk] = nlpredci(@Logistic,predictions,bayta,ehat,J);
RMSE = sqrt(sum((ypre - mos).^2) / length(mos));%root meas squared error
plcc = corr(mos, ypre, 'type','Pearson'); %pearson linear coefficient

format_str =[tag ':\tSRCC = %3.4f, KRCC = %3.4f, PLCC = %3.4f, RMSE = %3.4f\n'];

str = sprintf(format_str, abs(srcc), abs(krcc), abs(plcc), RMSE);
WriteLog(str);

fprintf(str);

if printToFile
    WriteResult(str, 'a');

    %latex_format_str = [tag '(latex):\t%3.4f & %3.4f & %3.4f & %3.4f\n' ];
    %latex_str = sprintf(latex_format_str, abs(srcc), abs(krcc), abs(plcc), RMSE);
    %WriteResult(latex_str, 'a');
end
