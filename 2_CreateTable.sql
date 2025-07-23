-- 2_CreateTable.sql
USE DateDemoDB;
GO

IF OBJECT_ID('dbo.DateAttributes', 'U') IS NOT NULL
    DROP TABLE dbo.DateAttributes;
GO

CREATE TABLE dbo.DateAttributes (
    [Date] DATE PRIMARY KEY,
    CalendarDay INT,
    CalendarMonth INT,
    CalendarQuarter INT,
    CalendarYear INT,
    DayNameLong NVARCHAR(20),
    DayNameShort NVARCHAR(10),
    DayNumberOfWeek INT,
    DayNumberOfYear INT,
    DaySuffix NVARCHAR(5),
    FiscalWeek INT,
    FiscalPeriod INT,
    FiscalQuarter INT,
    FiscalYear INT,
    FiscalYearPeriod NVARCHAR(10)
);
GO