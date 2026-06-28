/* Specify the libname */

/* i learn sas */

libname bh '/folders/myfolders/Boston House';

/* 1. Read the Boston House Pricing data into SAS and name it boston_house*/

proc import datafile='/folders/myfolders/Boston House/boston_house_train.csv'
dbms = csv
out= bh.boston_house
replace;
getnames= yes;
run;



proc export data=bh.boston_house dbms=xlsx
outfile = '/folders/myfolders/Boston House/boston_house_train.xlsx';
run;

proc export data=bh.boston_house dbms=tab
outfile = '/folders/myfolders/Boston House/boston_house_train.txt';
run;

/* 2. Read through the data dictionary to make sure that you are familiar with the data. 
Now, drop the price variable to create a new dataset with the name boston_house_features. */

data bh.boston_house_features;
set bh.boston_house;
drop medv ;
run;


data bh.boston_house_features;
set bh.boston_house (drop=medv);
run;



/* 3. Create another new dataset with ID and price only, name it boston_house_price. */

data bh.boston_house_price;
set bh.boston_house;
keep ID medv;
run;

/* 4. Create a dataset (name boston_house_charles) which only contains houses that are around the Charles river. */

data bh.boston_house_charles;
set bh.boston_house;
where chas = 1;
run;

data bh.boston_house_charles;
set bh.boston_house;
if chas = 1;
run;

/* 5. Create a dataset (name boston_house_age_ind) which contains a new variable age_ind that distinguishes
whether the proportion of units build prior to 1940 is higher than 30% or not */

data bh.boston_house_age_ind;
set bh.boston_house;
if age >= 30 then age_ind = 1;
else age_ind = 0;
run;

/* 6. Read through the following SAS script and find if there is a problem with the logic. */

data bh.boston_house_age_ind_2;
set bh.boston_house;
if age > 100 then age_ind = 1;
else if age < 100 then age_ind = 0;
run;

/* 7. Now run the script from question 6. Create a new dataset (name boston_hourse_null_ind) which contains all of the 
data with missing age indicator*/

data bh.boston_house_null_ind;
set bh.boston_house_age_ind_2;
where age_ind =.;
run;

data bh.boston_house_null_ind;
set bh.boston_house_age_ind_2;
where missing(age_ind);
run;








