USE ccdb;

CREATE TABLE cc_detail (
    Client_Num INT,
    Card_Category VARCHAR(50),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date DATE,
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    Current_Year INT,
    Credit_Limit DECIMAL(10, 2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Vol INT,
    Avg_Utilization_Ratio DECIMAL(10, 3),
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10, 3),
    Delinquent_Acc VARCHAR(10)
);

SELECT * FROM cc_detail;

SHOW VARIABLES LIKE 'secure_file_priv';

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

CREATE TEMPORARY TABLE temp_cc_detail (
    Client_Num INT,
    Card_Category VARCHAR(50),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date VARCHAR(10),
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    Current_Year INT,
    Credit_Limit DECIMAL(10, 2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Vol INT,
    Avg_Utilization_Ratio DECIMAL(10, 3),
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10, 3),
    Delinquent_Acc VARCHAR(10)
);

LOAD DATA INFILE 'path/to/cc_add.csv'
INTO TABLE temp_cc_detail
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE temp_cc_detail;

INSERT INTO ccdb.cc_detail (Client_Num, Card_Category, Annual_Fees, Activation_30_Days,
                            Customer_Acq_Cost, Week_Start_Date, Week_Num, Qtr, Current_Year,
                            Credit_Limit, Total_Revolving_Bal, Total_Trans_Amt, Total_Trans_Vol,
                            Avg_Utilization_Ratio, Use_Chip, Exp_Type, Interest_Earned, Delinquent_Acc)
SELECT 
    Client_Num, 
    Card_Category, 
    Annual_Fees, 
    Activation_30_Days, 
    Customer_Acq_Cost, 
    STR_TO_DATE(Week_Start_Date, '%d-%m-%Y'), 
    Week_Num, 
    Qtr, 
    Current_Year, 
    Credit_Limit, 
    Total_Revolving_Bal, 
    Total_Trans_Amt, 
    Total_Trans_Vol, 
    Avg_Utilization_Ratio, 
    Use_Chip, 
    Exp_Type, 
    Interest_Earned, 
    Delinquent_Acc
FROM temp_cc_detail;

DROP TABLE temp_cc_detail;

SELECT * FROM ccdb.cc_detail LIMIT 10;

CREATE TABLE cust_detail (
    Client_Num INT,
    Customer_Age INT,
    Gender VARCHAR(5),
    Dependent_Count INT,
    Education_Level VARCHAR(50),
    Marital_Status VARCHAR(20),
    State_cd VARCHAR(50),
    Zipcode VARCHAR(20),
    Car_Owner VARCHAR(5),
    House_Owner VARCHAR(5),
    Personal_Loan VARCHAR(5),
    Contact VARCHAR(50),
    Customer_Job VARCHAR(50),
    Income INT,
    Cust_Satisfaction_Score INT
);

LOAD DATA INFILE 'path/to/cust_add.csv'
INTO TABLE cust_detail
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM ccdb.cust_detail LIMIT 10;

SELECT AVG(Customer_Age) AS average_age FROM cust_detail;
