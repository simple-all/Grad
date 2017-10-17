ods html close;
ods html;

data tiles;
    infile 'D:\Grad\+stat514\+HW5\Problem2\data.dat';
	input block temperature effect;

proc glm data = tiles;
	class block temperature;
	model effect=temperature block;
	means temperature / tukey;
	output out=diag r=res p=pred;
	contrast 'C1' temperature 1 -1 0 0;
	contrast 'C2' temperature 0 0 1 -1;
	contrast 'C3' temperature 1 1 -1 -1;
run;
	
