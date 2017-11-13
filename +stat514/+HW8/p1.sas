ods html close;
ods html;

data scope;
    infile 'D:\Grad\+stat514\+HW8\data.dat';
	input glass temperature output;
	if glass=1 then x1=1;
	if glass=1 then x2=0;
	if glass=2 then x1 = 0;
	if glass=2 then x2 = 1;
	if glass=3 then x1=-1;
	if glass=3 then x2=-1;
	t = (temperature-1)*25+100;
	t2 = t*t;
	x1t = x1*t;
	x2t = x2*t;
	x1t2=x1*t2;
	x2t2=x2*t2;
proc print;

proc glm data = scope;
	class glass temperature;
	model output = glass temperature glass*temperature;
	output out=scopeNew r=res p=pred;
	lsmeans glass temperature glass*temperature;
	means glass /bon lines;
	lsmeans glass|temperature/tdiff adjust=tukey;
run;

proc sort; by pred;

symbol1 v=circle;
proc gplot data=scopeNew;
	plot res*pred/frame;
run;

proc univariate data=scopeNew;
	var res; qqplot res / normal (L=1 mu=est sigma=est);
run;

proc means noprint data=scope;
	var output;
	by glass temperature;
	output out=scopemean mean=mn;

symbol1 v=circle i=join;
symbol2 v=square i=join;
symbol3 v=triangle i=join;
proc gplot data=scopemean;
	plot mn*temperature=glass;
run;

proc reg data=scope;
	model output=x1 x2 t x1t x2t t2 x1t2 x2t2;
run;
