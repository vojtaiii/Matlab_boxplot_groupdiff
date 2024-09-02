function boxplotdifferences(data, groups, diffs, labels, paint, groupOrder)
% boxplotdifferences(data, groups, diffs, labels, paint, groupOrder)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compose the classic MATLAB boxplot with included between-group differences
% shown as lines with stars above.
% Inputs:
%   data: the data in the same format as classic boxplot
%   groups: group identifiers in the same format as classic boxplot
%   diffs: (double) info about the significant differences, each row
%   represents a single difference. First column is the position of the
%   group A, second column the postion of group B and third column is the
%   degree of significance (1 - '*', 2 - '**', 3 - '***'). Example:
%   [1 3 1; 1 4 2; 3 4 3].
%   labels: group labels to appear in the boxplot in the same format as a
%   classic boxplot. Example: {'group a', 'group b', 'group c'}
%   paint: set to one of you want to change the style of the boxplot
%   groupOrder (optional argument): specifies the order of the groups
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vojtech Illner, FEE CTU
% December 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 6
    groupOrder = [];
end
if nargin < 5
    paint = 0;
end

if paint == 1    
    %colors of each box
    map = [1 0 0
        0.08 0.5 0
        0.1 0.4 1
        0.9 0 0.45]; 

    h = boxplot(data, groups, 'Labels', labels, 'GroupOrder', groupOrder,'ColorGroup', [1,2,3,4],'Widths', 0.4,'Colors',map);
    set(h,{'linew'},{1.2}) %set thickness of boxes outlines
    %finds median lines and paint them black
    lines = findobj(h, 'type', 'line', 'Tag', 'Median');
    set(lines, 'Color', 'black');
else
    boxplot(data, groups, 'Labels', labels, 'GroupOrder', groupOrder);
end
% the inner settings (free to modify)
settings.linePad = 5; % in percents of the data range
settings.starPad = 2; % in percents of the data range
settings.figPad = 5; % in percents of the data range
settings.lineWidth = 1;

starArr = ["*", "**", "***"];

% the number of significant differences wanted to be shown
[diffNumber,~] = size(diffs);

% initial values computation
offset = 0;
maxVal = max(data);
range = maxVal - min(data);
linePad = range * settings.linePad/100;
starPad = range * settings.starPad/100;
figPad = range*settings.figPad/100;

% iterate over the single differences
for i = 1 : diffNumber
    % recalculate the y-axis line coordinates
    yVals = [(offset + maxVal + linePad) (offset + maxVal + 2*linePad)];
    % draw the lines
    line([diffs(i,1) diffs(i,1)], yVals, 'Color', 'black', 'LineWidth', settings.lineWidth)
    line([diffs(i,1) diffs(i,2)], [yVals(2) yVals(2)], 'Color', 'black', 'LineWidth', settings.lineWidth)
    line([diffs(i,2) diffs(i,2)], [yVals(2) yVals(1)], 'Color', 'black', 'LineWidth', settings.lineWidth)
    % add the star
    text((diffs(i,1) + diffs(i,2))/2, yVals(2) + starPad, starArr(diffs(i,3)), 'HorizontalAlignment', 'center')

    % adjust the offset so the lines do not intefere with each other
    offset = offset + 2*linePad + starPad;
end

% in the end adjust the figure y-axis limits to reflect added lines
if diffNumber ~= 0
    ylim([(min(data) - figPad) (yVals(2) + starPad + figPad)])
end

end
