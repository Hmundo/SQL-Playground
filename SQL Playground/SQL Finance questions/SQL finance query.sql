USE sql_practice;
select * from ipi_calendar_lookup;
select * from revenue_raw_data;

## Anwering financial related questions using SQL ##

-- What is the total Revenue of the company this year?

SELECT 
    SUM(Revenue) as revenue_fy21
FROM
    revenue_raw_data
WHERE
    Month_ID IN (SELECT DISTINCT
            Month_ID
        FROM
            ipi_calendar_lookup
        WHERE
            Fiscal_Year = 'FY21');

-- What is the total Revenue Performance(2019 vs 2020)?

SELECT a.*, b.*, (revenue_2020 - revenue_2019) AS revenue_2020vs2019 FROM
(SELECT 
    SUM(Revenue) as revenue_2020
FROM
    revenue_raw_data
WHERE
    Month_ID IN (SELECT DISTINCT
            Month_ID
        FROM
            ipi_calendar_lookup
        WHERE
            Fiscal_Year = 'FY20')) a,
            
(SELECT 
    SUM(Revenue) as revenue_2019
FROM
    revenue_raw_data
WHERE
    Month_ID IN (SELECT DISTINCT
            Month_ID
        FROM
            ipi_calendar_lookup
        WHERE
            Fiscal_Year = 'FY19')) b;

-- What is the MoM Revenue Performance for 2020?

SELECT 
    month_name AS months_of_2020,
    SUM(r.revenue) AS monthly_revenue,
    (sum(r.revenue) - coalesce(lag(sum(r.revenue)) over (order by month_no), 0)) as MoM
FROM
    revenue_raw_data r
        JOIN
    ipi_calendar_lookup c ON r.month_id = c.month_id
WHERE
    year_no = 2020
GROUP BY month_name
ORDER BY month_no ASC; 



