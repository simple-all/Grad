ods html close;
ods html;

data needles;
    infile 'D:\Grad\+stat514\+HW6\+p1\stomata.dat';
	input needle stomataCount;

proc glm data = needles;
	class needle;
	model stomataCount=needle;
run;

	
