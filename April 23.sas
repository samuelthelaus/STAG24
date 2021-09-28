/* 4.9 */

/* Data input */
DATA Milk ;
	DO Solution=1 TO 3 ;
		DO Block=1 TO 4 ;
			INPUT Observation $ Bacteria @@ ;
			OUTPUT ;
		END ;
	END ;
LINES ;
1 13 4 22 7 18 10 39
2 16 5 24 8 17 11 44
3 5 6 4 9 1 12 22
;
RUN ;

/* Sort by Obs */
PROC SORT DATA=Milk SORTSEQ=linguistic(numeric_collation=on);
  BY Observation ;
RUN ;

/* Model */
PROC GLM DATA=Milk ;
	TITLE 'Randomized Block Design - 4.9' ;
	CLASS Solution Block ;
	MODEL Bacteria=Solution Block ;
	MEANS Solution / TUKEY ;
	OUTPUT OUT=NEW PREDICTED=YHAT RESIDUAL=RES ;
RUN ;

/* Independence plot */
PROC SGPLOT DATA=NEW ;
	TITLE 'Plot for Independence' ;
	SCATTER Y=RES X=Observation ;
RUN ;

/* Residual plots */
PROC GPLOT DATA=NEW ;
	TITLE 'Plot for homogeneity of variance' ;
	PLOT RES*YHAT ;
	PLOT RES*Bacteria ;
RUN ;

/* Normal probability plot */
PROC CAPABILITY DATA=NEW NOPRINT ;
	TITLE 'Normal Probability Plot' ;
	PROBPLOT RES / odstitle=title ;
RUN ;

/* Test for normality SW */
PROC UNIVARIATE DATA=NEW NORMAL ;
	TITLE 'Shapiro-Wilks and more' ;
	VAR RES ;
RUN ;


/* 4.28 */

/* Data entry */

DATA TV ;
	DO Order=1 TO 4 ;
		DO Operator=1 TO 4 ;
			INPUT Observation $ Method $ Time @@ ;
			OUTPUT ;
		END ;
	END ;
LINES ;
1 C 10 5 D 14 9 A 7 13 B 8
2 B 7 6 C 18 10 D 11 14 A 8
3 A 5 7 B 10 11 C 11 15 D 9
4 D 10 8 A 10 12 B 12 16 C 14
;
RUN ;

/* Sort by Obs */
PROC SORT DATA=TV SORTSEQ=linguistic(numeric_collation=on);
  BY Observation ;
RUN ;

/* Model */
PROC GLM DATA=TV ;
	TITLE 'Latin Square 4.28' ;
	CLASS Order Operator Method ;
	MODEL Time=Method Order Operator ;
	MEANS Method / TUKEY ;
	OUTPUT OUT=NEW2 PREDICTED=YHAT RESIDUAL=RES ;
RUN ;

/* Independence plot */
PROC SGPLOT DATA=NEW2 ;
	TITLE 'Plot for Independence' ;
	SCATTER Y=RES X=Observation ;
RUN ;

/* Residual plots */
PROC GPLOT DATA=NEW2 ;
	TITLE 'Plot for homogeneity of variance' ;
	PLOT RES*YHAT ;
	PLOT RES*Time ;
RUN ;

/* Normal probability plot */
PROC CAPABILITY DATA=NEW2 NOPRINT ;
	TITLE 'Normal Probability Plot' ;
	PROBPLOT RES / odstitle=title ;
RUN ;

/* Test for normality SW */
PROC UNIVARIATE DATA=NEW2 NORMAL ;
	TITLE 'Shapiro-Wilks and more' ;
	VAR RES ;
RUN ;


/* 4.41 */

/* Data entry */

DATA TV2 ;
	DO Order=1 TO 4 ;
		DO Operator=1 TO 4 ;
			INPUT Observation $ Method $ Workplace $ Time @@ ;
			OUTPUT ;
		END ;
	END ;
LINES ;
1 C beta 11 5 B gamma 10 9 D delta 14 13 A alpha 8
2 B alpha 8 6 C delta 12 10 A gamma 10 14 D beta 12
3 A delta 9 7 D alpha 11 11 B beta 7 15 C gamma 15
4 D gamma 9 8 A beta 8 12 C alpha 18 16 B delta 6
;
RUN ;

/* Sort by Obs */
PROC SORT DATA=TV2 SORTSEQ=linguistic(numeric_collation=on);
  BY Observation ;
RUN ;

/* Model */
PROC GLM DATA=TV2 ;
	TITLE 'Graeco-Latin Square 4.28' ;
	CLASS Order Operator Method Workplace ;
	MODEL Time=Method Order Operator Workplace ;
	MEANS Method / TUKEY ;
	OUTPUT OUT=NEW3 PREDICTED=YHAT RESIDUAL=RES ;
RUN ;

/* Independence plot */
PROC SGPLOT DATA=NEW3 ;
	TITLE 'Plot for Independence' ;
	SCATTER Y=RES X=Observation ;
RUN ;

/* Residual plots */
PROC GPLOT DATA=NEW3 ;
	TITLE 'Plot for homogeneity of variance' ;
	PLOT RES*YHAT ;
	PLOT RES*Time ;
RUN ;

/* Normal probability plot */
PROC CAPABILITY DATA=NEW3 NOPRINT ;
	TITLE 'Normal Probability Plot' ;
	PROBPLOT RES / odstitle=title ;
RUN ;

/* Test for normality SW */
PROC UNIVARIATE DATA=NEW3 NORMAL ;
	TITLE 'Shapiro-Wilks and more' ;
	VAR RES ;
RUN ;



