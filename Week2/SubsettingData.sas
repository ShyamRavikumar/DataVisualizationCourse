LIBNAME MYDATA "/courses/d1406ae5ba27fe300 " access=readonly;

Data TEMP.data_research;
set MYDATA.addhealth_pds;
KEEP AID H1GI18 H1GI20 H1PR1-H1PR4 H1ED11-H1ED14;
LABEL
    AID = "Child ID"
    H1GI18 = "Presently in school/Was in school the past year"
    H1GI20 = "Student's Grade/Standard?"
    H1PR1 = "Rating - Adult Care"
    H1PR2 = "Rating - Teacher Care"
    H1PR3 = "Rating - Parent Care"
    H1PR4 = "Rating - Friend Care"
    H1ED11 = "Grade - English/Arts"
    H1ED12 = "Grade - Mathematics"
    H1ED13 = "Grade - History/Social Studies"
    H1ED14  = "Grade - Science"
;
/* Subsetting Rows -
      1) Should be in school
      2) Should have provided the grades for at least one of the subjects */

IF H1GI18=1; /*A response of 1 indicates that the student is/was in school in this/past year.*/
IF H1ED11 IN (1,2,3,4) /*Consider records only if at least 1 rating was given, to any of the subjects *?
    OR H1ED12 IN (1,2,3,4)
    OR H1ED13 IN (1,2,3,4)
    OR H1ED14 IN (1,2,3,4);
PROC SORT;
    BY H1GI20; /* Sort by the grade the student is in */
/*PROC FREQ;*/
/* Frequency of all the variables being studied */
/*TABLES H1GI20 H1PR1-H1PR4 H1ED11-H1ED14;*/
run;

PROC FREQ data=TEMP.data_research;
/* Frequency of 3 variables, as requested in the assignment*/
    TABLES H1GI20 H1PR3 H1ED14;
run;
