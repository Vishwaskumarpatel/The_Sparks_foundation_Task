/*Data Import Step From Provided url by TSF*/
filename student "%sysfunc(getoption(work))/student.csv";
proc http
out=Student
URL="http://bit.ly/w-data"
method="GET";
run;

/*Data Loading in SAS Studio */
Proc Import
file=Student
out=student_scores
dbms=csv replace;
run;

/*Table creat with the help of proc sql*/
Proc sql;
create table work.Student_scores as
Select*
from work.student_scores;
quit;

proc print data=work.student_scores;
run;

/*Scetter plot*/
proc sgplot
data=work.student_scores;
title "Hours vs Percentage";
scatter x=hours y=scores;
run;

/*Regression plot*/
proc sgplot
data=work.student_scores;
title "Hours vs Percentage";
scatter x=hours y=scores;
reg x=hours y=scores /lineattrs=(color=red thickness=3);
run;


/*Scatter plot grid or Matrix*/
title 'TSF Task 1 Study Profile';
footnote1 'Task Done by Vishwaskumar Patel (MBA Business Analytics)';
footnote2 'Ganpat University CMSR Powerd by SAS';
proc sgscatter
data=work.student_scores;
matrix scores hours /
transparency=0.1 markerattrs=graphdata4(symbol=crirclefilled);
run;

ods graphics on;

proc reg data=work.student_scores;
Model Scores=hours/p;
run;
ods graphics off;

ods noproctitle;

ods graphics / imagemap=on;
 
proc glmselect
data=work.student_scores;
model scores=hours / selection=none;
score out=work.student_scores1 predicted residual;
run;

proc print
data=work.student_scores;
run;

/*Prediction Model*/
data work.student_scores2;
set work.student_scores;
keep x1 y;
b0=2.43;
b1=9.78;
x1=9.25;
y=b0+b1*x1+epsilon;
epsilon=0;
output;
run;

/*predict value on the basis of simple liner Regrassion */
title "Predicted score(Y) of Student on the Basis of Hours(x1)";
proc print
data=work.student_scores2(obs=1);
run;
Title;