ods html close;
ods html;

data cars;
    infile 'D:\Grad\+stat514\+HW7\+P2\prob2.dat';
	input trt block resp;

proc glm data = cars;
	class block trt;
	model resp = block trt;
	lsmeans trt / tdiff pdiff adjust=bon stderr;
	lsmeans trt / pdiff adjust=tukey;

	contrast '1 & 2 vs. 4 & 5' trt 1 1 0 -1 -1;
run;
