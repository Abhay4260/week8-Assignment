# 📦 Date Dimension SQL Assignment

This project contains SQL scripts to create and populate a **date dimension table** for a given year in SQL Server.  
It is structured into clean, modular `.sql` files for clarity and maintainability.

---

## ✅ **Files included**

| File                        | Purpose                                                                                     |
|----------------------------:|----------------------------------------------------------------------------------------------|
| `1_CreateDatabase.sql`      | Creates a new database named `DateDemoDB` (only if it does not already exist).               |
| `2_CreateTable.sql`        | Creates the table `dbo.DateAttributes` inside `DateDemoDB` to store date dimension data.     |
| `3_CreateProcedure.sql`    | Creates a stored procedure `dbo.PopulateDateAttributes` to insert all dates for a given year.|
| `4_RunProcedure.sql`       | Calls the stored procedure with input date `2020-07-14` to populate data for year 2020.      |
| `5_CheckData.sql`         | Verifies the inserted data by selecting all rows from `DateAttributes`.                      |

---

## 🛠 **How to use**

1. Open SQL Server Management Studio (SSMS) or your preferred SQL client.
2. Connect to your SQL Server instance.
3. Run the scripts in order:
   - `1_CreateDatabase.sql`
   - `2_CreateTable.sql`
   - `3_CreateProcedure.sql`
   - `4_RunProcedure.sql`
   - `5_CheckData.sql`

4. Check the output:  
   - The table `DateAttributes` will contain all dates for the year 2020, including calculated attributes.

---

## ⚙️ **How it works**
- The stored procedure `PopulateDateAttributes` accepts a date as input.
- It extracts the year from that date and generates all dates in that year.
- It computes attributes like:
  - Calendar month, quarter, year
  - Day names (full and short)
  - Day number of week, year, suffix
  - Fiscal attributes (week, period, quarter, year)

---

## 📅 **Table structure**

| Column              | Type          | Description                                         |
|--------------------:|--------------:|----------------------------------------------------:|
| `Date`              | DATE (PK)     | The actual date                                    |
| `CalendarDay`       | INT           | Day of month (1-31)                                |
| `CalendarMonth`     | INT           | Month number (1-12)                                |
| `CalendarQuarter`   | INT           | Quarter (1-4)                                      |
| `CalendarYear`      | INT           | Year                                               |
| `DayNameLong`       | NVARCHAR(20)  | Full weekday name (e.g., Monday)                   |
| `DayNameShort`      | NVARCHAR(10)  | Abbreviated weekday name (e.g., Mon)               |
| `DayNumberOfWeek`   | INT           | Day number within the week                          |
| `DayNumberOfYear`   | INT           | Day number within the year (1-365/366)             |
| `DaySuffix`         | NVARCHAR(5)   | Suffix (e.g., st, nd, rd, th)                      |
| `FiscalWeek`        | INT           | Fiscal week number                                 |
| `FiscalPeriod`      | INT           | Fiscal month                                       |
| `FiscalQuarter`     | INT           | Fiscal quarter                                     |
| `FiscalYear`        | INT           | Fiscal year                                        |
| `FiscalYearPeriod`  | NVARCHAR(10)  | Concatenation of year and period (e.g., 202001)    |

---
