ods html close;
ods html;

data scope;
    infile 'D:\Grad\+stat514\+HW9\p1\measure.dat';
	input operator parts measurement;
proc print;

proc mixed method=type1;
	class operator parts;
	model measurement=;
	random operator parts(operator);
run;
