/* Specify the libname */

libname bh '/folders/myfolders/Boston House';

/* 1. Read the Boston House Pricing test data into SAS and name it boston_house_test
Note: you have three file types: csv, xlsx, txt. Try to play with all three if you have time.*/

proc import datafile='/folders/myfolders/Boston House/boston_house_test.csv'
dbms = csv
out= bh.boston_house_test
replace;
getnames= yes;
run;

proc contents data = bh.boston_house_test;
run;



/* 2. Read through the data dictionary to make sure that you are familiar with the data. 
Now, create a dataset which only contains the information regarding the physical characteristics 
of the houses. */

data bh.boston_house_physical;
set bh.boston_house_test;
keep ID rm age;
run;

/* 3. If the analysis does not want to include variables related to education 
and future employment opportunity,  */
/* how would you modify the dataset? Create a new dataset (boston_house_test_remove_eduemp) for this. */

data bh.boston_house_test_remove;
set bh.boston_house_test;
drop indus dis ptratio;
run;

/* 4. Create a dataset (name boston_house_test_safe) 
which only contains records with per capita
crime rate lower than 1%*/

data bh.boston_house_test_safe;
set bh.boston_house_test;
where crim < 1;
run;

data bh.boston_house_test_safe;
set bh.boston_house_test;
if crim < 1;
run;

/* 5. For a town, if the average number of rooms per dwelling is higher than 6 
and the proportion of 
old owner-occupied units is lower than 80%), then we say that the region's 
fancy_house indicator is 'Y'
otherwise it would be 'N'. Create a new variable in boston_house_test to 
capture that.*/

data bh.boston_house_test;
set bh.boston_house_test;
if rm > 6 and age < 80 then fancy_house = 'Y';
else fancy_house = 'N';
run;

/* 6. If the pupil-teacher ratio is lower than 20 then we say the 
edu_ind ='good' else it would be 'ok'. Create
a new variable in boston_house_test to capture that.*/

data bh.boston_house_test;
set bh.boston_house_test;
if ptratio < 20  then edu_ind= 'good';  
else edu_ind = 'ok';
run;

/* 7. If both of the fancy house and education indicator are positive, then we say that the house has quality_ind as Super,
if the fancy house is positive but the education indicator is negative, then we say that the quality_ind is 'Nice to live',
if the education indicator is positive but the fancy house is negative, then we say that the quality_ind is 'Good education',
if either of them is positive, then the quality_ind is 'No good'. Create a new variable for that in boston_house_test.

Note: you may find some issue with the actual content of this variable. This is due to the variable length. Do not worry, 
we will cover it when we take up the homework.*/

data bh.boston_house_test_v2;
set bh.boston_house_test;
length quality_ind_2 $20; 
if fancy_house = 'Y' and edu_ind = 'good' then quality_ind_2 = 'Super';
else if fancy_house = 'Y' and edu_ind = 'ok' then quality_ind_2 = 'Nice to live';
else if fancy_house = 'N' and edu_ind = 'good' then quality_ind_2 = 'Good education';
else quality_ind_2 = 'No good';
run;


