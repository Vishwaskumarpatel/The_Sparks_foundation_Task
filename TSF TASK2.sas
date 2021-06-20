/*For csv File taken From Drive*/
Filename Reffile '/home/u57839410/TSF TASK/Iris.csv';

/*import the CSV File*/
proc import datafile=Reffile dbms=csv out=work.Import;
	getnames=yes;
run;

proc contents data=work.Import;
run;

/*Print the result*/
proc print data=work.Import(obs=15);
run;

/*unassing the file reference*/
filename Reffile;

/* checking the contents of core the datasets*/
proc means data=work.Import n nmiss mean median max min;
	Var Sepallengthcm--petalwidthcm;
run;

/*perfoming cluster analysis*/
ods graphics on;

proc cluster data=work.Import method=centroid ccc print=15;
run;

/*retaining the "3" clusters*/
proc tree noprint ncl=3 out=work.Import;
	copy sepallengthcm--petalwidthcm;
run;

/*creat a scatterplot of the data set*/
proc candisc out=work.Import;
	class cluster;
	var PetalWidthCm:SepalLengthCm:;
run;

proc sgplot data=work.import;
	title 'Cluster analysis for the TSF Task 2 Datasets(iris.csv)';
	footnote1 'Task Done by Vishwaskumar Patel (MBA Business Analytics)';
	footnote2 'Ganpat University CMSR Powerd by SAS';
	Scatter y=can2 x=can1/ GROUP=cluster
	transparency=0.1;
	run;