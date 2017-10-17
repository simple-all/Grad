ods html close;
ods html;

data oper;
    infile 'D:\Grad\+stat514\+HW6\+p1\p3data.dat';
	input operator order trt performance;

proc glm data = oper;
	class operator order trt;
	model performance=operator order trt;
	output out = newDat r = res p = pred;

symbol1 v=circle;
proc gplot data = newDat;	
	plot res*order;

	proc univariate noprint normal;
		qqplot res/normal (L=1 mu=0 sigma=est);

run;




	
