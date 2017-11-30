ods html close;
ods html;

goption colors=(none);

data dat;
    infile 'D:\Grad\+stat514\HW10\p1\data.dat';
	input A B C y;

data inter;                              /* Define Interaction Terms */
 set dat;
 AB=A*B; AC=A*C; BC=B*C; ABC=AB*C;


proc reg outest=effects data=inter;    /* REG Proc to Obtain Effects */
 model y=A B C AB AC BC ABC;
data effect2; set effects;
 drop y intercept _RMSE_;
proc transpose data=effect2 out=effect3;
data effect4; set effect3; effect=col1*2;  
proc sort data=effect4; by effect;
proc print data=effect4;
proc rank data=effect4 out=effect5 normal=blom;
 var effect; ranks neff;

symbol1 v=circle;
proc gplot data=effect5;
 plot effect*neff=_NAME_;
run;

/* Regression model */
data inter; set filter; AC = A*C;
proc reg data=inter; model y=B C AC;
output out=outres r=res p=pred;

proc gplot data=outres; plot res*pred; run;

quit;


