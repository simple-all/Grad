ods html close;
ods html;

goption colors=(none);

data filter;          
 do D = -1 to 1 by 2;do C = -1 to 1 by 2;
 do B = -1 to 1 by 2;do A = -1 to 1 by 2;
 input y @@;  output;
 end; end; end; end;
datalines;
550 669 604 650 633 642 601 635 1037 749 1052 868 1075 860 1063 729
;

data inter;                              /* Define Interaction Terms */
 set filter;
 AB=A*B; AC=A*C; AD=A*D; BC=B*C; BD=B*D; CD=C*D; ABC=AB*C; ABD=AB*D;
 ACD=AC*D; BCD=BC*D; ABCD=ABC*D;

 /* ANOVA without higher order terms to confirm signigicant effectors */
proc glm data=inter;                   /* GLM Proc to Obtain Effects */
 class A B C D AB AC AD BC BD CD;/* ABC ABD ACD BCD ABCD;*/
 model y=A B C D AB AC AD BC BD CD;/* ABC ABD ACD BCD ABCD;*/
 estimate 'A' A 1 -1; estimate 'AC' AC 1 -1;

proc reg outest=effects data=inter;    /* REG Proc to Obtain Effects */
 model y=A B C D AB AC AD BC BD CD ABC ABD ACD BCD ABCD;
data effect2; set effects;
 drop y intercept _RMSE_;
proc transpose data=effect2 out=effect3;
data effect4; set effect3; effect=col1*2;  
proc sort data=effect4; by effect;
proc print data=effect4;
proc rank data=effect4 out=effect5 normal=blom;
 var effect; ranks neff;

symbol1 v=circle;
proc gplot data=effect5;
 plot effect*neff=_NAME_;
run;


/* ANOVA with A, D and their interactions */
proc glm data=filter;
	class A D;
	model y = A|D;
run;

/* Regression model */
data inter; set filter; AD = A*D;
proc reg data=inter; model y=A D AD;
output out=outres r=res p=pred;

proc gplot data=outres; plot res*pred; run;

quit;


