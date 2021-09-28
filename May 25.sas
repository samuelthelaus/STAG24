
/* 14.3 */

/* Data input */
DATA Dataset ;
	DO Machine = 1 TO 3 ;
		DO Spindle = 1, 2 ;
			DO Obs = 1 TO 4 ;
				INPUT Dimension @@ ;
				OUTPUT ;
			END ;
		END ;
	END ;
LINES ;
12 9 11 12 8 9 10 8 14 15 13 14
12 10 11 13 14 10 12 11 16 15 15 14
;
RUN ;

PROC GLM DATA=Dataset ;
	TITLE 'Nested model - 14.3' ;
	CLASS Machine Spindle ;
	MODEL Dimension = Machine Spindle(Machine) ;
RUN ;


/* 14.5 */

/* Data input */
DATA Dataset2 ;
	DO Chemistry = 1, 2 ;
		DO Heats = 1 TO 3 ;
			DO Ingots = 1, 2 ;
				DO Obs = 1, 2 ;
					INPUT Hardness @@ ;
					OUTPUT ;
				END ;
			END ;
		END ;
	END ;
LINES ;
40 63 27 30 95 67 69 47 65 54 78 45
22 10 23 39 83 62 75 64 61 77 35 42
;
RUN ;

PROC GLM DATA=Dataset2 ;
	TITLE 'Three-stage nested model - 14.5' ;
	CLASS Chemistry Heats Ingots ;
	MODEL Hardness = Chemistry Heats(Chemistry) Ingots(Heats Chemistry) / SS3 ;
	RANDOM Ingots(Heats Chemistry) / TEST ;
RUN ;

PROC VARCOMP DATA=Dataset2 METHOD=TYPE1;
CLASS Chemistry Heats Ingots ;
MODEL Hardness = Chemistry Heats(Chemistry) Ingots(Chemistry Heats) / FIXED=2;
TITLE ’VARIANCE COMPONENTS ANALYSIS’;
RUN ;
	