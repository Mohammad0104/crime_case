# 🚔 Crime Analytics with SQL

## Crime Trends, Backlog, Financial Loss & Location Analysis

This project uses **MySQL** to analyze crime data across districts, crime categories, incidents, officers, locations, and financial losses.

The goal was not only to write SQL queries, but to answer practical analytical questions such as:

- Which crime categories account for most incidents?
- When do crimes occur most frequently?
- Which crime types have the largest unresolved backlog?
- Which crimes create the greatest financial loss?
- Where does vehicle theft occur most often?
- How do incidents change over time?
- What data-quality problems could affect reporting?

---

## 📌 Project Overview

The analysis uses four main datasets:

- `incidents`
- `crime_types`
- `districts`
- `officers`

### SQL Skills Demonstrated

`JOIN` • `GROUP BY` • `HAVING` • `CASE` • `COUNT` • `SUM` • `ROUND` • `YEAR` • `MONTH` • `MONTHNAME` • `DAYNAME` • `HOUR` • `TIMESTAMPDIFF` • Window Functions

---

# 📊 Key Findings

- **16,695 total incidents** were represented in the crime-category analysis.
- **Property crime accounts for 57.77%** of all incidents.
- Property and violent crime together account for about **77% of incidents**.
- **Assault has the largest long-term felony backlog**, with **797 cases**.
- Approximately **2,893 felony cases** were open or under investigation for more than one year.
- **Theft generated approximately $3.99M in recorded losses**, the highest of all crime types analyzed.
- Total recorded financial losses exceeded **$12.85M**.
- Vehicle theft occurred most frequently on **streets**.
- The analysis identified data-quality issues such as inconsistent capitalization in location values.

---

# 🏙️ 1. District Population Analysis

The first analysis examined district population and geographic area.

Districts were grouped into population categories using SQL `CASE` logic.

<img src="image(20261018-034927).png" width="100%">

### District Overview

| District | Population | Area (sq. km) | Category |
|---|---:|---:|---|
| Westfield | 70,000 | 35.4 | Large |
| Northside | 62,000 | 28.0 | Large |
| Southpark | 60,000 | 30.2 | Medium |
| Eastgate | 55,000 | 22.3 | Medium |
| Hillcrest | 52,000 | 24.9 | Medium |
| Downtown | 48,000 | 12.5 | Small |

### 🔎 Insight

Westfield has the largest population at **70,000 residents**, while Downtown has a population of **48,000** within only **12.5 sq. km**.

Population and geographic information provides useful context when comparing crime across districts.

---

# 🚨 2. Which Crime Categories Make Up Most Incidents?

The next analysis measured the number of incidents in each crime category and calculated its percentage of total incidents.

<img src="image(20261018-034947).png" width="100%">

| Crime Category | Incidents | Share |
|---|---:|---:|
| Property | 9,644 | 57.77% |
| Violent | 3,215 | 19.26% |
| Drug | 1,719 | 10.30% |
| Traffic | 1,142 | 6.84% |
| White Collar | 975 | 5.84% |

### 🔎 Insight

**Property crime dominates the dataset**, representing nearly **3 out of every 5 incidents**.

Property and violent crime combined account for:

> **77.03% of all incidents**

This suggests that these two categories have the greatest influence on overall crime volume.

---

# 📅 3. Year-over-Year Crime Trends

To avoid misleading comparisons, the analysis compares the same months across years.

Instead of comparing a complete year with partial-year data, the analysis focuses on **January through September**.

<img src="image(20261018-035007).png" width="100%">

### Highest Monthly Results

| Period | Incidents |
|---|---:|
| August 2024 | 591 |
| July 2023 | 587 |
| July 2024 | 578 |
| August 2023 | 567 |
| June 2023 | 548 |
| June 2024 | 539 |

### 🔎 Insight

Incident volume appears particularly high during the summer months.

**June, July, and August** consistently appear among the higher-volume periods.

This suggests possible seasonality in crime activity.

---

# ⏰ 4. When Do Incidents Occur?

Crime patterns were analyzed using:

- Day of week
- Hour of day
- Crime category

<img src="image(20261018-035045).png" width="100%">

One of the strongest property-crime combinations was:

> **Monday at 4:00 AM — 89 incidents**

Other high-volume combinations occurred during late-night and early-morning periods.

---

# ⚠️ Violent Crime Timing

Violent crime was analyzed separately to determine whether its timing patterns differed.

<img src="image(20261018-035110).png" width="100%">

### Selected High-Volume Periods

| Day | Time | Incidents |
|---|---:|---:|
| Tuesday | 3 AM | 36 |
| Friday | 2 AM | 34 |
| Thursday | 5 AM | 34 |
| Wednesday | 1 AM | 33 |
| Saturday | 7 PM | 31 |

### 🔎 Insight

Many of the highest violent-crime combinations occur during **late-night and early-morning hours**.

This demonstrates why analyzing crime categories separately can reveal patterns hidden within overall totals.

---

# 📂 5. Long-Term Felony Backlog

The analysis identified felony cases that were:

- `Open`
- `Under Investigation`
- More than **12 months old**

<img src="image(20261018-035131).png" width="100%">

### Felony Backlog

| Crime Type | Backlog |
|---|---:|
| Assault | 797 |
| Burglary | 578 |
| Vehicle Theft | 523 |
| Robbery | 393 |
| Fraud | 388 |
| Arson | 141 |
| Homicide | 73 |

### 🔎 Insight

Approximately **2,893 long-term felony cases** were identified.

The largest backlog comes from:

1. Assault
2. Burglary
3. Vehicle Theft

Together these three crime types represent approximately **65.6% of the identified backlog**.

This indicates where backlog-reduction efforts could potentially have the largest impact.

---

# 👮 6. Officer & District Workload

The analysis also examined the number of incidents associated with officers through their district.

<img src="image(20261018-035150).png" width="100%">

Several officers were associated with district incident volumes of approximately:

- **2,959 incidents**
- **1,540 incidents**

### ⚠️ Data Model Limitation

Officers and incidents are connected using `district_id`.

Therefore, these numbers represent **district-associated incident volume**, rather than confirmed individual officer caseloads.

A better future data model would connect incidents directly to an `officer_id`.

That would allow analysis of:

- Individual officer caseload
- Cases closed
- Resolution rate
- Average resolution time
- Experience versus workload
- Rank versus performance

Identifying limitations in the data model is an important part of reliable analytics.

---

# 💰 7. Which Crimes Create the Largest Financial Loss?

Financial impact was analyzed by summing the `loss_amount` associated with each crime type.

<img src="image(20261018-035206).png" width="100%">

### Financial Loss by Crime Type

| Crime Type | Total Loss |
|---|---:|
| Theft | $3,994,583.98 |
| Vandalism | $1,837,380.69 |
| Drug Offense | $1,514,046.69 |
| Burglary | $1,232,671.45 |
| Vehicle Theft | $1,227,870.52 |
| DUI | $1,175,272.65 |
| Fraud | $920,165.18 |
| Trespassing | $592,774.18 |
| Arson | $359,019.49 |

### 💵 Total Recorded Loss

> **More than $12.85 Million**

### 🔎 Insight

Theft generated approximately:

> **$3.99 Million**

in recorded losses.

That represents roughly **31% of the total financial loss**.

The three largest contributors were:

- Theft
- Vandalism
- Drug Offense

Together they account for approximately **57% of recorded losses**.

This shows why crime severity should not be evaluated using incident count alone.

A category may occur less frequently but still create significant financial impact.

---

# 🚗 8. Where Does Vehicle Theft Happen Most?

The next analysis looked at the locations where vehicle theft was most frequently reported.

<img src="image(20261018-035241).png" width="100%">

| Location Type | Vehicle Thefts |
|---|---:|
| Street | 382 |
| Residence | 296 |
| Commercial | 251 |
| Parking Lot | 163 |
| Park | 106 |
| Transit | 102 |

### 🔎 Insight

**Street locations have the highest number of vehicle theft incidents.**

Street thefts were approximately:

- **29% higher** than residential locations
- **52% higher** than commercial locations
- More than **2× higher** than parking lots

This type of analysis could help identify higher-risk environments for vehicle theft prevention.

---

# 🧹 9. Data Quality Finding

During the location analysis, an important data-quality issue appeared.

The dataset contained both:

```text
Street
street
```

Although these represent the same location category, SQL treats them as separate values.

There were also several incomplete location records.

### Example Cleaning Approach

```sql
UPDATE incidents
SET location_type = 'Street'
WHERE LOWER(TRIM(location_type)) = 'street';
```

### Additional Data Quality Checks

The dataset should also be checked for:

- Duplicate incident IDs
- Missing values
- Blank fields
- Inconsistent capitalization
- Invalid dates
- Invalid district IDs
- Negative financial values
- Unmatched foreign keys

---

# 🛠️ SQL Techniques Used

## Aggregations

```sql
COUNT()
SUM()
AVG()
ROUND()
```

Used for incident counts, percentages, financial loss, and summary metrics.

## JOINs

```sql
INNER JOIN
```

Used to combine information from incidents, crime types, districts, and officers.

## Conditional Logic

```sql
CASE
    WHEN ...
    THEN ...
    ELSE ...
END
```

Used to categorize district populations.

## Date Functions

```sql
YEAR()
MONTH()
MONTHNAME()
DAYNAME()
HOUR()
TIMESTAMPDIFF()
```

Used to analyze monthly trends, year-over-year patterns, weekday patterns, time-of-day patterns, and case age.

## Window Functions

```sql
SUM(COUNT(*)) OVER()
```

Used to calculate each crime category's percentage of total incidents.

## Filtering & Grouping

```sql
WHERE
GROUP BY
HAVING
ORDER BY
```

Used to isolate important records and compare different groups.

---

# ❓ Business Questions Answered

1. How are districts different by population and area?
2. Which crime categories account for most incidents?
3. What percentage of total incidents belongs to each category?
4. How does crime change across comparable periods?
5. Which months experience the highest incident levels?
6. What days and hours experience the most incidents?
7. Does violent crime follow a different timing pattern?
8. Which felony crimes have the largest long-term backlog?
9. Which crimes generate the greatest financial losses?
10. Where does vehicle theft occur most frequently?
11. Are there data-quality issues that could affect reporting?

---

# 💡 What I Learned

This project strengthened my ability to use SQL for **analytical problem-solving**, rather than simply retrieving data.

Key lessons included:

- Raw incident counts require context.
- Partial-year data should not be compared directly with full-year data.
- Crime frequency and financial impact can tell different stories.
- Backlog analysis can reveal operational pressure points.
- Data relationships must be validated before interpreting results.
- Small data-quality problems can distort KPIs and dashboards.
- SQL analysis should begin with a business question, not just a query.

---

# 🧰 Tools Used

| Tool | Purpose |
|---|---|
| MySQL | Data analysis |
| MySQL Workbench | Query development |
| SQL JOINs | Combining relational tables |
| Window Functions | Percentage analysis |
| GitHub | Portfolio documentation |

---

# 📁 Project Structure

```text
Crime-Analytics-SQL/
│
├── README.md
├── crime_analysis.sql
├── incidents.csv
├── crime_types.csv
├── districts.csv
├── officers.csv
├── image(20261018-034927).png
├── image(20261018-034947).png
├── image(20261018-035007).png
├── image(20261018-035045).png
├── image(20261018-035110).png
├── image(20261018-035131).png
├── image(20261018-035150).png
├── image(20261018-035206).png
└── image(20261018-035241).png
```

> Keep the screenshots in the same folder as `README.md` for the image links above to work.

---

# 🎯 Conclusion

This project demonstrates how SQL can transform relational crime data into useful operational insights.

The analysis found that:

- **Property crime drives overall incident volume**
- **Assault has the largest long-term felony backlog**
- **Theft creates the greatest recorded financial loss**
- **Vehicle theft occurs most often on streets**
- **Late-night and early-morning periods are important for several crime patterns**
- **Data quality and table relationships must be considered before drawing conclusions**

Rather than focusing only on writing queries, this project emphasizes turning SQL results into a clear analytical story that can support better decisions.

---

## 👤 Author

**Mohammad**

B.Sc. Computer Science — Data Science Concentration  
Ontario Tech University

### Skills

**SQL | Power BI | Excel | Python | R | Data Analysis | Data Visualization**

### 🌐 Portfolio

https://mohammad0104.github.io/
