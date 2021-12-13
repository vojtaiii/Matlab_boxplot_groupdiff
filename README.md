## Boxplots differences

Compose the classic MATLAB boxplot with included between-group differences shown as lines with stars above.

### Usage

In a given figure environment call

```matlab
boxplotdifferences(data, groups, diffs, labels)
```

where the parameters are:

 - **data**: the data in the same format as classic boxplot
 - **groups**: group identifiers in the same format as classic boxplot
 - **diffs**: (MxN double matrix) info about the significant differences. Each row represents a single difference. First column is the position of the group A, 
 second column the position of group B and third column is the degree of significance (1 - '*', 2 - '**', 3 - '***'). Example:
 
  ```matlab
  diffs = [1 3 1; 1 4 2; 3 4 3];
  ```
  
  - **labels**: group labels to appear in the boxplot in the same format as a classic boxplot. Example: 
  
  ```matlab
  labels = {'group a', 'group b', 'group c'};
  ```

### License & ownership

Developed by Vojtech Illner at FEE CTU in Prague
