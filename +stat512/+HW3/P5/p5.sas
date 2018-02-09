ods html close;
ods html;

data origSet;
	infile 'D:\Grad\+stat512\+HW3\P5\data.dat';
	input concentration rxnRate;

SYMBOL1 v=circle;
title1 'Reaction Rate v. Concentration';
axis1 label=('Concentration');
axis2 label=('Reaction Rate');
proc gplot data=origSet;
	plot rxnRate*concentration / haxis=axis1 vaxis=axis2;
run;

* Create altered dataset of inverse values;
data invSet;
	set origSet;
	cinv = 1/concentration;
	vinv = 1/rxnRate;

title1 'Inverse of Reaction Rate v. Inverse of Concentration';
axis1 label=('1/Concentration');
axis2 label=('1/Reaction Rate');
proc gplot data=invSet;
	plot vinv*cinv / haxis=axis1 vaxis=axis2;
run;

* Create linear regression;
proc reg data=invSet;
	model vinv=cinv;
	output out=results p=pred r=resid;
run;

data invSet;
	set results;
	predv=1/pred;
run;



symbol1 v=circle i=none c=black;
symbol2 v=plus i=sm5 c=red;
title1 'Reaction Rate v. Concentration';
axis1 label=('Concentration');
axis2 label=('Reaction Rate');
proc gplot data=invSet;
	plot rxnRate*concentration predv*concentration /overlay haxis=axis vaxis=axis2;
run;
	
	
