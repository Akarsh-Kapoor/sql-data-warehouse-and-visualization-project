IF OBJECT_ID('gold.dim_dates', 'U') IS NOT NULL
    DROP TABLE gold.dim_dates;
GO

CREATE TABLE gold.dim_dates (
    date_key INT PRIMARY KEY,
    full_date DATE,
    year INT,
    quarter INT,
    month_number INT,
    month_name VARCHAR(20),
    day INT,
    weekday_name VARCHAR(20),
    month_year VARCHAR(20)
);
GO

DECLARE @StartDate DATE = '2010-01-01';
DECLARE @EndDate DATE = '2015-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO gold.dim_dates (
        date_key,
        full_date,
        year,
        quarter,
        month_number,
        month_name,
        day,
        weekday_name,
        month_year
    )
    VALUES (
        CAST(CONVERT(VARCHAR, @StartDate, 112) AS INT),
        @StartDate,
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DAY(@StartDate),
        DATENAME(WEEKDAY, @StartDate),
        FORMAT(@StartDate, 'MMM yyyy')
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END;
GO
