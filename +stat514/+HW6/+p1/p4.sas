ods html close;
ods html;

data oper;
    infile 'D:\Grad\+stat514\+HW6\+p1\p4data.dat';
	input operator order trt workplace performance;

proc glm data = oper;
	class operator order workplace trt;
	model performance=operator order workplace trt;
run;

	
