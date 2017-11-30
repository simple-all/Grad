ods html close;
ods html;

data dat;
    infile 'D:\Grad\+stat514\HW10\p1\data.dat';
	input A B C resp;


proc glm;
	class A B C;
	model resp=A|B|C;
	output out=dat1 r=res p=pred;
run;

proc univariate data=dat1 pctldef=4;
	var res; qqplot res / normal (L=1 mu=est sigma=est);
	histogram res / normal;
run;
proc print;

/* Regression model */
data dat2; set dat; AC = A*C;
proc reg data=dat2; model resp=B C AC;
output out=outres r=res p=pred;
symbol1 v=circle i=none;
proc gplot data=outres; plot res*pred;

/* Effect Plots */
proc sort data=dat; by B;
proc means noprint;
var resp; by B;
output out=ymeanb mean = mn;

symbol1 v=circle i=join; symbol2 v=square i=join;
proc gplot data=ymeanb; plot mn*B;
run;


proc sort data=dat; by C;
proc means noprint;
var resp; by C;
output out=ymeanc mean = mn;

symbol1 v=circle i=join; symbol2 v=square i=join;
proc gplot data=ymeanc; plot mn*C;
run;

/* Interaction Plots */
proc sort data = dat; by A C;
proc means noprint;
var resp; by A C;
output out=ymeanac mean = mn;

symbol1 v=circle i=join; symbol2 v=square i=join;
proc gplot data=ymeanac; plot mn*A=C;
run;


quit;
