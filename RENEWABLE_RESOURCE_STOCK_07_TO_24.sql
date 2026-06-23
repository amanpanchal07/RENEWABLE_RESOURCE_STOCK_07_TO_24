CREATE DATABASE RENEWABLE_STOCK;
USE RENEWABLE_STOCK;
DROP DATABASE RENEWABLE_STOCK;

-- BASIC QUESTIONS 

-- Q.1 How many records are available for each energy resource?

SELECT `RESOURCE`, COUNT(*)
FROM `renewable-energy-stock-account-2007-2024`
GROUP BY `RESOURCE`;

-- Q.2 List all unique energy resources present in the dataset.

SELECT `RESOURCE`
FROM `renewable-energy-stock-account-2007-2024`
GROUP BY `RESOURCE`;

-- Q.3 Find the total number of records for each year.

SELECT `YEAR` ,COUNT(*) AS TOTAL_RECORDS
FROM `renewable-energy-stock-account-2007-2024`
GROUP BY `YEAR`
ORDER BY `YEAR`;

-- Q.4 Retrieve all records where the variable is 'Generation'.

SELECT * 
FROM `renewable-energy-stock-account-2007-2024`
WHERE VARIABLE = "GENERATION";

-- Q.5 Calculate the average data_value for each resource.

SELECT `RESOURCE`, ROUND(AVG(DATA_VALUE),2) AS AVG_DATA_VALUE
FROM `renewable-energy-stock-account-2007-2024`
GROUP BY `RESOURCE`;

-- Q.6 Identify the record with the highest data_value in the dataset.

SELECT * 
FROM `renewable-energy-stock-account-2007-2024`
ORDER BY DATA_VALUE DESC
LIMIT 1;

-- Q.7 Display all records for a specific resource (e.g., Renewable) sorted by year

SELECT *
FROM `renewable-energy-stock-account-2007-2024`
WHERE `RESOURCE` = "RENEWABLE"
ORDER BY `YEAR`;

-- Q.8 Count the number of records for each variable type.

SELECT VARIABLE , COUNT(*) AS TOTAL_RECORDS
FROM `renewable-energy-stock-account-2007-2024`
GROUP BY VARIABLE;

-- Q.9 Find the total number of rows where data_value is NULL.

SELECT COUNT(*) AS null_count
FROM `renewable-energy-stock-account-2007-2024`
WHERE data_value IS NULL;

-- Q.10 Retrieve the top 10 records with the highest data_value.

SELECT * FROM `renewable-energy-stock-account-2007-2024`
ORDER BY DATA_VALUE DESC
LIMIT 10;

-- INTERMEDIATE LEVEL QUESTIONS 

-- Q.1 Calculate the total energy generation for each resource and rank them from highest to lowest.

SELECT `RESOURCE` , SUM(data_value) as total_generation
FROM `renewable-energy-stock-account-2007-2024`
WHERE variable = "Generation"
GROUP BY `RESOURCE` 
ORDER BY total_generation DESC;

-- Q.2 Analyze the yearly trend of total renewable energy generation from 2007 to 2024.

SELECT `YEAR` , SUM(data_value) as total_renewable_generation 
FROM `renewable-energy-stock-account-2007-2024`
WHERE `resource` = "Renewable" AND variable = "Generation"
GROUP BY `YEAR`;

-- Q.3 Determine which resource has the highest average generation value

SELECT `RESOURCE` , AVG(data_value) as Highest_avg_value 
FROM `renewable-energy-stock-account-2007-2024`
WHERE variable = "Generation"
GROUP BY `RESOURCE`
ORDER BY Highest_avg_value DESC
LIMIT 1;

-- Q.4 Find the maximum and minimum data_value recorded for each resource.

SELECT `RESOURCE` , 
MAX(data_value) as maximum_value ,
MIN(data_value) as mimimum_value 
FROM `renewable-energy-stock-account-2007-2024`
GROUP BY `RESOURCE`;

-- Q.5 Calculate the total generation for each year and identify the year with the highest energy production.

SELECT `YEAR` ,SUM(data_value) as total_generation 
FROM `renewable-energy-stock-account-2007-2024`
WHERE variable = "Generation"
GROUP BY `YEAR`
ORDER BY total_generation DESC;

-- Q.6 Find the percentage contribution of each resource to the overall energy generation.

SELECT
    resource,
    ROUND(
        SUM(data_value) * 100.0 /
        (SELECT SUM(data_value)
         FROM `renewable-energy-stock-account-2007-2024`
         WHERE variable = 'Generation'),
         2
    ) AS contribution_percentage
FROM `renewable-energy-stock-account-2007-2024`
WHERE variable = 'Generation'
GROUP BY resource
ORDER BY contribution_percentage DESC;

-- Q.7 Identify all resources whose average generation is greater than the overall average generation.

SELECT `RESOURCE` , AVG(DATA_VALUE) AS AVG_RESOURCE
FROM `renewable-energy-stock-account-2007-2024`
WHERE variable = 'Generation'
GROUP BY `RESOURCE`
HAVING AVG(DATA_VALUE) >
(
   SELECT AVG(data_value)
    FROM `renewable-energy-stock-account-2007-2024`
    WHERE variable = 'Generation'
);

-- Q.8 Find the latest available year in the dataset and display all records from that year.

SELECT * FROM `renewable-energy-stock-account-2007-2024`
WHERE year =
(
    SELECT MAX(year)
    FROM `renewable-energy-stock-account-2007-2024`
);

-- Q.9 Compare the total generation values between different resources and identify the top 5 contributors.

SELECT `RESOURCE`,  SUM(data_value) AS total_generation
FROM `renewable-energy-stock-account-2007-2024`
WHERE VARIABLE = "GENERATION"
GROUP BY `resource`
ORDER BY total_generation DESC
LIMIT 5;

-- Q10. Categorize resources into High, Medium, and Low generation groups based on their average data_value

SELECT
    resource,
    AVG(data_value) AS avg_generation,
    CASE
        WHEN AVG(data_value) >= 1000 THEN 'High'
        WHEN AVG(data_value) >= 500 THEN 'Medium'
        ELSE 'Low'
    END AS generation_category
FROM `renewable-energy-stock-account-2007-2024`
GROUP BY resource;

