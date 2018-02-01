ods html close;
ods html;

data dat;
	infile 'D:\Grad\+stat512\+HW2\P1\CH01PR19.DAT';
	input GPA exam;

proc sort data=dat;
	by exam;

SYMBOL1 v=circle i=sm70;
title1 'GPA v. Entrance Exam Score';
title2 'Smoothed curve Value: 70';
axis1 label=('Entrance Exam Score');
axis2 label=('GPA');
proc gplot;
	plot GPA*exam / haxis=axis1 vaxis=axis2;


proc reg data=dat;
	model GPA=exam/clb p r;
	output out=diag p=pred r=resid;
	id exam;

run;


	
