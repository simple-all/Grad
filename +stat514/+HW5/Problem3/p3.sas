ods html close;
ods html;

data tiles;
    infile 'D:\Grad\+stat514\+HW5\Problem3\data.dat';
	input block treatment effect;

proc glm data = tiles;
	class block treatment;
	model effect=block treatment;
	output out=diag predicted=yhat;

data diag; set diag;
	nonadd = yhat**2;

proc glm data = diag;
	class block treatment;
	model effect=treatment block nonadd / SS1 solution;
run;
	
