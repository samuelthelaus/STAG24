
/* Data input */
DATA Dataset ;
DO Operator = 1, 2 ;
	DO Measure = 1 TO 3 ;
		DO Part = 1 TO 10 ;
			INPUT Capability @@ ;
			OUTPUT ;
		END ;
	END ;
END ;
LINES ;
50 52 53 49 48 52 51 52 50 47
49 52 50 51 49 50 51 50 51 46
50 51 50 50 48 50 51 49 50 49
50 51 54 48 48 52 51 53 51 46
48 51 52 50 49 50 50 48 48 47
51 51 51 51 48 50 50 50 49 48
;
RUN ;

/* Stochastic model */
PROC GLM DATA=Dataset ;
	TITLE 'Stochastic model' ;
	CLASS Part Operator ;
	MODEL Capability=Part Operator Part*Operator ;
	RANDOM Part Operator Part*Operator / TEST ;
RUN ;

PROC VARCOMP DATA=Dataset METHOD=TYPE1 ;
	TITLE 'VARCOMP Model' ;
	CLASS Part Operator ;
	MODEL Capability=Part Operator Part*Operator ;
RUN ;

/* Mixed model */
PROC GLM DATA=Dataset ;
	TITLE 'Mixed model' ;
	CLASS Part Operator ;
	MODEL Capability=Part Operator Part*Operator ;
	TEST H=Operator E=Part*Operator / HTYPE=3 ETYPE=3 ;
RUN ;