
/* 6.5 */

/* Input data */
DATA Tools ;
DO C = -1, 1 ;
	DO B = -1, 1 ;
		DO A = -1, 1 ;
			DO OBS = 1 TO 3 ;
				INPUT Life @@ ; 
				AB=A*B ; AC=A*C ; BC=B*C ; ABC=A*B*C ;
				OUTPUT ;
			END ;
		END ;
	END ;
END ;
LINES ;
22 31 25 32 43 29 35 34 50 55 47 46
44 45 38 40 37 36 60 50 54 39 41 47
;
RUN ;


/* ANOVA Model */
PROC GLM DATA=Tools ;
	TITLE '2^3 Design' ;
	CLASS A B C ;
	MODEL Life = A B C A*B A*C B*C A*B*C ;
	MEANS A B C / TUKEY ;
	OUTPUT OUT=NEW P=YHAT R=RES ;
	STORE GLMMOD ;
RUN ;

PROC PLM RESTORE=GLMMOD NOINFO ;
	TITLE 'Interaction Plot' ;
	EFFECTPLOT INTERACTION(X=A SLICEBY=C) / CLM ;
RUN ;

/* Residual plots */
PROC GPLOT DATA=NEW ;
	TITLE2 'Residual plot' ;
	PLOT RES*YHAT / VREF=0 ;
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

/* New dataset for regression */
DATA Tools ;
	SET Tools ;
	ARRAY OMKOD A B C AB AC BC ABC ;
	DO I=1 TO 7 ; 
		OMKOD[I]=OMKOD[I]/2 ; 
	END ;
RUN ;

/* Regression model */
PROC REG DATA= Tools ;
	TITLE 'Regression model' ;
	MODEL Life = A B C AB AC BC ABC / CLB ;
RUN ;








