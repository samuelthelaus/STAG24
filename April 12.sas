/* Uppgift 3.11 */

DATA Concrete ;
	INPUT Technique $ Strength @@ ;
CARDS ;
t1 3129 t1 3000 t1 2865 t1 2890
t2 3200 t2 3300 t2 2975 t2 3150
t3 2800 t3 2900 t3 2985 t3 3050
t4 2600 t4 2700 t4 2600 t4 2765
;
RUN ;

PROC GLM DATA=Concrete PLOTS=NONE ;
TITLE 'Tensile Strength of Cement ANOVA' ;
CLASS Technique ;
MODEL Strength = Technique ;
MEANS Technique / LSD ;
OUTPUT OUT=NEW PREDICTED=YHAT RESIDUAL=RES ;
RUN ;

PROC CAPABILITY DATA=NEW NOPRINT ;
TITLE 'Normal Probability Plot' ;
   PROBPLOT RES / odstitle=title ;
RUN ;

PROC GPLOT DATA=NEW ;
TITLE 'Kontroll av modellen - residualplottar' ;
PLOT RES*YHAT ;
PLOT RES*Strength ;
RUN ;

PROC SGPLOT DATA=Concrete ;
  HISTOGRAM Strength / GROUP=Technique TRANSPARENCY=0.5 ;
  DENSITY Strength / TYPE=kernel GROUP=Technique ;
RUN;

PROC SGPLOT DATA=Concrete ;
TITLE ' ' ;
	SCATTER X=Technique Y=Strength ;
RUN ;

/* Uppgift 3.12 */

PROC GLM DATA=Concrete PLOTS=ALL ;
TITLE 'Tensile Strength of Cement ANOVA' ;
CLASS Technique ;
MODEL Strength = Technique ;
LSMEANS Technique / ADJUST=TUKEY LINES STDERR ;
RUN ;

/* Uppgift 3.13 */

PROC GLM DATA=Concrete PLOTS=NONE ;
TITLE 'Tensile Strength of Cement ANOVA' ;
CLASS Technique ;
MODEL Strength = Technique ;
MEANS Technique / CLM CLDIFF LSD ;
RUN ;


	