ods html close;
ods html;

data dat;
	infile 'D:\Grad\+stat512\+HW2\P2\CH01PR22.DAT';
	input hardness time;

proc sort data=dat;
	by time;
run;

SYMBOL1 v=circle i=rl;
title1 'Hardness v. Time';
axis1 label=('Time (hrs)');
axis2 label=('Hardness (Brinell)');
proc gplot;
	plot hardness*time / haxis=axis1 vaxis=axis2;
run;

SYMBOL1 v=circle i=rlclm;
title1 'Hardness v. Time';
title2 '95% Confidence Bounds for Mean';
axis1 label=('Time (hrs)');
axis2 label=('Hardness (Brinell)');
proc gplot;
	plot hardness*time / haxis=axis1 vaxis=axis2;
run;


SYMBOL1 v=circle i=rlcli;
title1 'Hardness v. Time';
title2 '95% Confidence Bounds for Individual Observations';
axis1 label=('Time (hrs)');
axis2 label=('Hardness (Brinell)');
proc gplot;
	plot hardness*time / haxis=axis1 vaxis=axis2;
run;

title1;
title2;

proc reg data=dat;
	model hardness=time/clb p r;
	output out=diag p=pred r=resid;
	id time;
run;

data datPred;
	time=36; output;
	time=43; output;

data datNew;
	set dat datPred;

title1 'Prediction of E(Y_h)';
proc reg data=datNew;
	model hardness=time/clm;
run;
	

title1 'Prediction of Y_h(new)';
proc reg data=datNew;
	model hardness=time/cli;
run;
	
