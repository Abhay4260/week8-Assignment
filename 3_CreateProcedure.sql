-- 3_CreateProcedure.sql
USE DateDemoDB;
GO

IF OBJECT_ID('dbo.PopulateDateAttributes', 'P') IS NOT NULL
    DROP PROCEDURE dbo.PopulateDateAttributes;
GO

CREATE PROCEDURE dbo.PopulateDateAttributes
    @InputDate DATE
AS
BEGIN
    DECLARE @Year INT = YEAR(@InputDate);
    DECLARE @StartDate DATE = DATEFROMPARTS(@Year, 1, 1);
    DECLARE @EndDate DATE = DATEFROMPARTS(@Year, 12, 31);

    ;WITH DateSeries AS (
        SELECT @StartDate AS [Date]
        UNION ALL
        SELECT DATEADD(DAY, 1, [Date])
        FROM DateSeries
        WHERE [Date] < @EndDate
    )
    INSERT INTO dbo.DateAttributes (
        [Date], CalendarDay, CalendarMonth, CalendarQuarter, CalendarYear,
        DayNameLong, DayNameShort, DayNumberOfWeek, DayNumberOfYear, DaySuffix,
        FiscalWeek, FiscalPeriod, FiscalQuarter, FiscalYear, FiscalYearPeriod
    )
    SELECT
        [Date],
        DAY([Date]) AS CalendarDay,
        MONTH([Date]) AS CalendarMonth,
        DATEPART(QUARTER, [Date]) AS CalendarQuarter,
        YEAR([Date]) AS CalendarYear,
        DATENAME(WEEKDAY, [Date]) AS DayNameLong,
        LEFT(DATENAME(WEEKDAY, [Date]), 3) AS DayNameShort,
        DATEPART(WEEKDAY, [Date]) AS DayNumberOfWeek,
        DATEPART(DAYOFYEAR, [Date]) AS DayNumberOfYear,
        CAST(DAY([Date]) AS NVARCHAR(2)) + 
            CASE 
                WHEN DAY([Date]) IN (11,12,13) THEN 'th'
                WHEN RIGHT(DAY([Date]),1) = '1' THEN 'st'
                WHEN RIGHT(DAY([Date]),1) = '2' THEN 'nd'
                WHEN RIGHT(DAY([Date]),1) = '3' THEN 'rd'
                ELSE 'th'
            END AS DaySuffix,
        DATEPART(WEEK, [Date]) AS FiscalWeek,
        DATEPART(MONTH, [Date]) AS FiscalPeriod,
        DATEPART(QUARTER, [Date]) AS FiscalQuarter,
        YEAR([Date]) AS FiscalYear,
        CAST(YEAR([Date]) AS NVARCHAR(4)) + RIGHT('0' + CAST(MONTH([Date]) AS NVARCHAR(2)),2) AS FiscalYearPeriod
    FROM DateSeries
    OPTION (MAXRECURSION 366);
END
GO