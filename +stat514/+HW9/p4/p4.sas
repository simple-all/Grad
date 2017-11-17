ods html close;
ods html;

data scope;
    infile 'D:\Grad\+stat514\+HW9\p4\rocket.dat';
	input process batch burnRate;

proc mixed method=type1;
	class process batch;
	model burnRate=process;
	random batch(process);
run;
