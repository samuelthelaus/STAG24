
/* 5.8 */

/* Input data */
DATA Chem ;
	DO Pressure = 200 TO 230 BY 15 ;
		DO Temperature = 150 TO 170 BY 10 ;
			DO OBS = 1 TO 2 ;
				INPUT Yield @@ ;
				OUTPUT ;
			END ;
		END ;
	END ;
LINES ;
90.4 90.2 90.1 90.3 90.5 90.7
90.7 90.6 90.5 90.6 90.8 90.9
90.2 90.4 89.9 90.1 90.4 90.1
;
RUN ;

/* Model */
PROC GLM DATA=Chem ;
	TITLE 'Two-factor ANOVA on Chemical Yields' ;
	CLASS Pressure Temperature ;
	MODEL Yield=Pressure | Temperature ;
	MEANS Pressure Temperature / TUKEY ;
	OUTPUT OUT=NEW P=YHAT R=RES ;
RUN ;

/* Residual plots */
PROC GPLOT DATA=NEW ;
	TITLE2 'Residual plot' ;
	PLOT RES*YHAT / VREF=0 ;
	PLOT RES*Pressure / VREF=0 ;
	PLOT RES*Temperature / VREF=0 ;
RUN ;

/* Normal probability plot */
PROC CAPABILITY DATA=NEW NOPRINT ;
	TITLE 'Normal Probability Plot' ;
	PROBPLOT RES / odstitle=title ;
RUN ;

/* Normality test */
PROC UNIVARIATE DATA=NEW NORMAL ;
	TITLE2 'Normality assumption test' ;
	VAR RES ;
RUN ;








