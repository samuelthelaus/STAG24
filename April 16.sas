/* Uppgift 3.27 */

/* Data import */
DATA Insulation ;
	INPUT Observation $ Fluid $ Life @@ ;
CARDS ;
1  f1 17.6 2  f1 18.9 3  f1 16.3 4  f1 17.4 5  f1 20.1 6  f1 21.6
7  f2 16.9 8  f2 15.3 9  f2 18.6 10 f2 17.1 11 f2 19.5 12 f2 20.3
13 f3 21.4 14 f3 23.6 15 f3 19.4 16 f3 18.5 17 f3 20.5 18 f3 22.3
19 f4 19.3 20 f4 21.1 21 f4 16.9 22 f4 17.5 23 f4 18.3 24 f4 19.8
;
RUN ;

/* Main model */
PROC GLM DATA=Insulation PLOTS=ALL ;
	TITLE 'Life of insulating fluids ANOVA' ;
	CLASS Fluid ;
	MODEL Life = Fluid ;
	MEANS Fluid / HOVTEST=LEVENE (TYPE=ABS);
	LSMEANS Fluid / ADJUST=TUKEY LINES STDERR ;
	OUTPUT OUT=NEW PREDICTED=YHAT RESIDUAL=RES ;
RUN ;

/* Independence plot */
PROC SGPLOT DATA=NEW ;
	TITLE 'Plot for Independence' ;
	SCATTER Y=RES X=Observation ;
RUN ;

/* DW test */
PROC REG DATA=Insulation ;
	TITLE 'Durbin-Watson' ; 
	MODEL Life = / DW ;
RUN ;

/* Residual plots */
PROC GPLOT DATA=NEW ;
	TITLE 'Plot for homogeneity of variance' ;
	PLOT RES*YHAT ;
	PLOT RES*Life ;
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

/* Uppgift 3.59 */
PROC NPAR1WAY DATA=Insulation WILCOXON ;
	TITLE 'Kruskal-Wallis test' ;
	CLASS Fluid ;
	VAR Life ;
RUN ;

/* Uppgift 3.29 */

/* Data import */
DATA Alcohol ;
	INPUT Observation $ Chemist $ Percentage @@ ;
CARDS ;
1 c1 84.99 2 c1 84.04 3 c1 84.38
4 c2 85.15 5 c2 85.13 6 c2 84.88
7 c3 84.72 8 c3 84.48 9 c3 85.16
10 c4 84.20 11 c4 84.10 12 c4 84.55
;
RUN ;

/* Main model */
PROC GLM DATA=Alcohol PLOTS=NONE ;
	TITLE 'Percentage of Methyl Alcohol ANOVA' ;
	CLASS Chemist ;
	MODEL Percentage = Chemist ;
	CONTRAST 'Contrast 1' Chemist  -1 3 -1 -1 ;
	CONTRAST 'Contrast 2' Chemist  2 0 -1 -1 ;
	CONTRAST 'Contrast 3' Chemist  0 0 1 -1 ;
	MEANS Chemist / LSD HOVTEST=LEVENE (TYPE=ABS);
	OUTPUT OUT=NEW2 PREDICTED=YHAT RESIDUAL=RES ;
RUN ;

/* Independence plot */
PROC SGPLOT DATA=NEW2 ;
	TITLE 'Plot for Independence' ;
	SCATTER Y=RES X=Observation ;
RUN ;

/* DW test */
PROC REG DATA=Alcohol ;
	TITLE 'Durbin-Watson' ; 
	MODEL Percentage = / DW ;
RUN ;

/* Residual plots */
PROC GPLOT DATA=NEW2 ;
	TITLE 'Plot for homogeneity of variance' ;
	PLOT RES*YHAT ;
	PLOT RES*Percentage ;
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

