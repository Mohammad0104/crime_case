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

# 📊 Headline Numbers

| Metric | Value |
|---|---:|
| Total incidents analyzed | **16,695** |
| Crime categories | 5 |
| Districts | 6 |
| Total population (all districts) | 347,000 |
| Total area (all districts) | 153.3 sq. km |
| Overall population density | ≈ 2,264 people / sq. km |
| Incidents per 1,000 residents | ≈ 48.1 |
| Property + Violent share of incidents | **77.03%** |
| Long-term felony backlog (12+ months) | **2,893 cases** |
| Largest backlog type | Assault (797 cases, 27.55%) |
| Total recorded financial loss | **$12,853,784.83** |
| Average loss per crime type | ≈ $1,428,198 |
| Largest loss type | Theft ($3,994,583.98, 31.08%) |
| Vehicle thefts classified by location | 1,300 |
| Top vehicle-theft location | Street (382 thefts, 29.38%) |

> Percentages and ratios below are calculated from the totals in each result table and rounded to two decimals.

---

# 🏙️ 1. District Population Analysis

Districts were grouped into population categories using SQL `CASE` logic, and population density was derived from population and area.

| District | Population | Area (sq. km) | Category | Density (per sq. km) | % of Population | % of Area |
|---|---:|---:|---|---:|---:|---:|
| Westfield | 70,000 | 35.4 | Large | 1,977 | 20.17% | 23.09% |
| Northside | 62,000 | 28.0 | Large | 2,214 | 17.87% | 18.27% |
| Southpark | 60,000 | 30.2 | Medium | 1,987 | 17.29% | 19.70% |
| Eastgate | 55,000 | 22.3 | Medium | 2,466 | 15.85% | 14.55% |
| Hillcrest | 52,000 | 24.9 | Medium | 2,088 | 14.99% | 16.24% |
| Downtown | 48,000 | 12.5 | Small | 3,840 | 13.83% | 8.15% |
| **Total** | **347,000** | **153.3** | | **≈ 2,264** | **100%** | **100%** |

### 🔎 Insight

- Westfield is the largest district by both population (**70,000**) and area (**35.4 sq. km**).
- **Downtown is the densest district at 3,840 people per sq. km**, about **1.7× the overall average** and **1.94× Westfield's density**.
- Downtown holds **13.83% of the population on only 8.15% of the land area**.
- Westfield is the least dense district (1,977 per sq. km) despite having the most residents.
- The two "Large" districts (Westfield and Northside) together hold **38.04%** of the population (132,000 of 347,000).

Population and geographic context matters when comparing crime across districts, because raw incident counts favor larger districts.

---

# 🚨 2. Which Crime Categories Make Up Most Incidents?

The analysis counted incidents in each crime category and calculated each category's percentage of total incidents using a window function.

| Rank | Crime Category | Incidents | Share | Cumulative Share |
|---:|---|---:|---:|---:|
| 1 | Property | 9,644 | 57.77% | 57.77% |
| 2 | Violent | 3,215 | 19.26% | 77.03% |
| 3 | Drug | 1,719 | 10.30% | 87.33% |
| 4 | Traffic | 1,142 | 6.84% | 94.17% |
| 5 | White Collar | 975 | 5.84% | 100.00% |
| | **Total** | **16,695** | **100%** | |

### 🔎 Insight

- **Property crime dominates the dataset**: 9,644 incidents, nearly **3 out of every 5**.
- Property crime is **3.0× the volume of violent crime** (9,644 vs 3,215).
- Property and violent crime combined: **12,859 incidents, or 77.03%** of the total.
- The top three categories (Property, Violent, Drug) cover **87.33%** of all incidents.
- Traffic and White Collar are the smallest categories at **6.84%** and **5.84%**, with a combined volume of 2,117 incidents (12.68%).
- Drug crime (1,719) is about **1.8× traffic** (1,142) and **1.76× white collar** (975).

---

# 📅 3. Year-over-Year Crime Trends

To avoid misleading comparisons, the analysis compares the same months across years. Instead of comparing a complete year with partial-year data, it focuses on **January through September**.

### Highest Monthly Results

| Rank | Period | Incidents | Avg. Incidents / Day |
|---:|---|---:|---:|
| 1 | August 2024 | 591 | 19.06 |
| 2 | July 2023 | 587 | 18.94 |
| 3 | July 2024 | 578 | 18.65 |
| 4 | August 2023 | 567 | 18.29 |
| 5 | June 2023 | 548 | 18.27 |
| 6 | June 2024 | 539 | 17.97 |

### Summer Year-over-Year Comparison (June–August)

| Month | 2023 | 2024 | Change | % Change |
|---|---:|---:|---:|---:|
| June | 548 | 539 | −9 | −1.64% |
| July | 587 | 578 | −9 | −1.53% |
| August | 567 | 591 | +24 | +4.23% |
| **Summer total** | **1,702** | **1,708** | **+6** | **+0.35%** |

### 🔎 Insight

- All six of the highest-volume months in the comparison fall in **June, July, or August**, which suggests possible seasonality.
- The top six months average **≈ 568 incidents per month**, or roughly **18.5 incidents per day**.
- Summer volume is essentially **flat year over year (+0.35%)**: June and July dipped slightly (about −1.5% each), while August rose **4.23%**.
- **August 2024 (591)** is the single highest month and is **9.8% above the lowest of the top six (June 2024, 539)**.
- The spread between the highest and lowest month in the top six is only **52 incidents**, so summer volume is consistently high rather than driven by one spike.

---

# ⏰ 4. When Do Incidents Occur?

Crime patterns were analyzed by:

- Day of week
- Hour of day
- Crime category

### Property Crime Timing

One of the strongest property-crime combinations was:

> **Monday at 4:00 AM: 89 incidents**

For context, spreading all 9,644 property incidents evenly across the 168 day-and-hour slots in a week gives a baseline of **≈ 57.4 incidents per slot**. The Monday 4 AM peak of 89 is therefore about **1.55× the average slot (+55%)**.

Other high-volume combinations also occurred during late-night and early-morning periods.

---

# ⚠️ 5. Violent Crime Timing

Violent crime was analyzed separately to determine whether its timing patterns differ from the overall pattern.

### Selected High-Volume Periods

| Day | Time | Incidents | Multiple of Avg. Slot (≈ 19.1) |
|---|---:|---:|---:|
| Tuesday | 3 AM | 36 | 1.88× |
| Friday | 2 AM | 34 | 1.78× |
| Thursday | 5 AM | 34 | 1.78× |
| Wednesday | 1 AM | 33 | 1.72× |
| Saturday | 7 PM | 31 | 1.62× |

The baseline of ≈ 19.1 incidents per slot comes from spreading 3,215 violent incidents evenly across 168 weekly day-and-hour slots.

### 🔎 Insight

- **Four of the five** highest violent-crime slots fall between **1 AM and 5 AM**.
- The peak slot (Tuesday 3 AM, 36 incidents) is **≈ 1.9× the average slot**.
- Even the fifth-highest slot (Saturday 7 PM, 31 incidents) runs about **1.6× the average**.
- The top five slots total **168 incidents**, which is **5.23% of all violent incidents** from just 5 of 168 weekly slots (about 3% of the week).
- Saturday 7 PM is the only evening entry, suggesting a smaller evening-hours pattern alongside the overnight one.

This demonstrates why analyzing crime categories separately can reveal patterns hidden within overall totals.

---

# 📂 6. Long-Term Felony Backlog

The analysis identified felony cases that were:

- `Open` or `Under Investigation`
- More than **12 months old** (using `TIMESTAMPDIFF`)

| Rank | Crime Type | Backlog | % of Backlog | Cumulative % |
|---:|---|---:|---:|---:|
| 1 | Assault | 797 | 27.55% | 27.55% |
| 2 | Burglary | 578 | 19.98% | 47.53% |
| 3 | Vehicle Theft | 523 | 18.08% | 65.61% |
| 4 | Robbery | 393 | 13.58% | 79.19% |
| 5 | Fraud | 388 | 13.41% | 92.60% |
| 6 | Arson | 141 | 4.87% | 97.47% |
| 7 | Homicide | 73 | 2.52% | 99.99% |
| | **Total** | **2,893** | **100%** | |

*(Cumulative total shows 99.99% because of rounding.)*

### 🔎 Insight

- Approximately **2,893 long-term felony cases** were identified.
- The three largest backlogs (Assault, Burglary, Vehicle Theft) total **1,898 cases, or 65.61%**.
- The top five types (adding Robbery and Fraud) account for **2,679 cases, or 92.60%**.
- Assault's backlog is **1.38× burglary's** and **≈ 5.65× arson's**.
- **Homicide has the smallest backlog (73 cases, 2.52%)**, but each unresolved homicide carries far greater severity than the count suggests.
- Robbery (393) and Fraud (388) are nearly tied, separated by just 5 cases.

This indicates where backlog-reduction efforts could potentially have the largest impact.

---

# 👮 7. Officer & District Workload

The analysis examined incident volume associated with officers through their district.

Several officers were associated with district incident volumes of approximately:

| Reported Volume | Share of All Incidents (of 16,695) | Compared to Average District (≈ 2,783) |
|---:|---:|---:|
| 2,959 incidents | 17.72% | ≈ +6.3% |
| 1,540 incidents | 9.22% | ≈ −44.7% |

- The busiest reported district volume (2,959) is **≈ 1.92× the lightest (1,540)**, a gap of **1,419 incidents**.
- An even split across six districts would be **≈ 2,783 incidents per district** (16,695 ÷ 6). This assumes the 16,695 total is the full incident population mapped across the six districts.

### ⚠️ Data Model Limitation

Officers and incidents are connected using `district_id`.

Therefore, these numbers represent **district-associated incident volume**, rather than confirmed individual officer caseloads.

Joining officers to incidents on `district_id` also produces one row per officer-incident pair. Counting rows after that join would overstate volume, so counts should use `COUNT(DISTINCT incident_id)`.

A better future data model would connect incidents directly to an `officer_id`. That would allow analysis of:

- Individual officer caseload
- Cases closed
- Resolution rate
- Average resolution time
- Experience versus workload
- Rank versus performance

Identifying limitations in the data model is an important part of reliable analytics.

---

# 💰 8. Which Crimes Create the Largest Financial Loss?

Financial impact was analyzed by summing the `loss_amount` associated with each crime type.

| Rank | Crime Type | Total Loss | % of Total Loss | Cumulative % |
|---:|---|---:|---:|---:|
| 1 | Theft | $3,994,583.98 | 31.08% | 31.08% |
| 2 | Vandalism | $1,837,380.69 | 14.29% | 45.37% |
| 3 | Drug Offense | $1,514,046.69 | 11.78% | 57.15% |
| 4 | Burglary | $1,232,671.45 | 9.59% | 66.74% |
| 5 | Vehicle Theft | $1,227,870.52 | 9.55% | 76.29% |
| 6 | DUI | $1,175,272.65 | 9.14% | 85.43% |
| 7 | Fraud | $920,165.18 | 7.16% | 92.59% |
| 8 | Trespassing | $592,774.18 | 4.61% | 97.20% |
| 9 | Arson | $359,019.49 | 2.79% | 99.99% |
| | **Total** | **$12,853,784.83** | **100%** | |

### 💵 Total Recorded Loss

> **$12,853,784.83 (more than $12.85 million)**

Average loss per crime type: **≈ $1,428,198**. Only **three** types (Theft, Vandalism, Drug Offense) exceed this average.

### 🔎 Insight

- Theft generated about **$3.99 million**, roughly **31%** of all recorded loss.
- Theft's loss is **2.17× the second-largest category** (Vandalism, $1.84M) and **≈ 11.1× the smallest** (Arson, $0.36M).
- The three largest contributors (Theft, Vandalism, Drug Offense) account for **$7,346,011.36, or 57.15%**.
- The top five account for **$9,806,553.33, or 76.29%**.
- Burglary ($1,232,671.45) and Vehicle Theft ($1,227,870.52) are separated by only **$4,800.93**, which is about **0.04%** of total loss.
- Burglary and Vehicle Theft together total **$2,460,541.97 (19.14%)**.

This shows why crime severity should not be evaluated using incident count alone. A category may occur less frequently but still create significant financial impact.

> **Note:** Assault, Robbery, and Homicide do not appear in the loss table, which suggests `loss_amount` captures economic loss only. The financial analysis therefore says nothing about the human cost of violent crime.

---

# 🔗 9. Cross-Analysis: Frequency vs. Backlog vs. Loss

Comparing the earlier results shows which crime types rank high on more than one measure.

| Crime Type | Backlog Rank | Backlog Cases | Loss Rank | Total Loss |
|---|---:|---:|---:|---:|
| Burglary | 2 | 578 | 4 | $1,232,671.45 |
| Vehicle Theft | 3 | 523 | 5 | $1,227,870.52 |
| Fraud | 5 | 388 | 7 | $920,165.18 |
| Arson | 6 | 141 | 9 | $359,019.49 |

### 🔎 Insight

- **Burglary and Vehicle Theft are the two types that rank in the top five for both backlog and loss.** Together they hold **1,101 backlog cases (38.06% of the backlog)** and **19.14% of recorded loss**, which makes them strong candidates for prioritization.
- **Assault, Robbery, and Homicide** account for **1,263 backlog cases, or 43.66% of the backlog**, even though the Violent category is only **19.26% of incidents**. This is roughly **2.3× its share of incidents**.
  - This comparison is directional rather than exact: the backlog covers only felonies older than 12 months, while the incident share covers all incidents, and it assumes these three types map to the Violent category.
- Theft is the biggest loss driver, but it does not appear in the felony backlog table, so loss and backlog point to different priorities.

---

# 🚗 10. Where Does Vehicle Theft Happen Most?

The next analysis looked at where vehicle theft was most frequently reported.

| Rank | Location Type | Vehicle Thefts | % of Total | Cumulative % |
|---:|---|---:|---:|---:|
| 1 | Street | 382 | 29.38% | 29.38% |
| 2 | Residence | 296 | 22.77% | 52.15% |
| 3 | Commercial | 251 | 19.31% | 71.46% |
| 4 | Parking Lot | 163 | 12.54% | 84.00% |
| 5 | Park | 106 | 8.15% | 92.15% |
| 6 | Transit | 102 | 7.85% | 100.00% |
| | **Total** | **1,300** | **100%** | |

### 🔎 Insight

- **Street locations have the highest number of vehicle theft incidents** (382 of 1,300).
- Street thefts were:
  - **29.1% higher** than residential (382 vs 296)
  - **52.2% higher** than commercial (382 vs 251)
  - **2.34× parking lots** (382 vs 163)
  - **3.75× transit** (382 vs 102)
- Street and Residence together account for **678 thefts, or 52.15%**, which is more than half of all vehicle thefts.
- The top three locations (Street, Residence, Commercial) cover **929 thefts, or 71.46%**.
- Parking lots, parks, and transit combined account for only **371 thefts (28.54%)**.

This type of analysis could help identify higher-risk environments for vehicle theft prevention.

---

# 🧹 11. Data Quality Finding

During the location analysis, an important data-quality issue appeared.

The dataset contained both:

```text
Street
street
```

Although these represent the same location category, SQL grouping can treat them as separate values depending on collation. There were also several incomplete location records.

### Why It Matters

If lowercase `street` rows are counted separately from `Street`, the street total (**382**) may be understated, which would only strengthen the conclusion that streets are the top location. The location counts should be re-run after normalization to confirm the final percentages.

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

1. How are districts different by population, area, and density?
2. Which crime categories account for most incidents?
3. What percentage of total incidents belongs to each category?
4. How does crime change across comparable periods?
5. Which months experience the highest incident levels?
6. What days and hours experience the most incidents?
7. Does violent crime follow a different timing pattern?
8. Which felony crimes have the largest long-term backlog?
9. Which crimes generate the greatest financial losses?
10. Which crime types rank high on both backlog and financial loss?
11. Where does vehicle theft occur most frequently?
12. Are there data-quality issues that could affect reporting?

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
└── officers.csv
```

---

# 🎯 Conclusion

This project demonstrates how SQL can transform relational crime data into useful operational insights.

The analysis found that:

- **Property crime drives overall incident volume** (57.77% of 16,695 incidents)
- **Property and violent crime together make up 77.03% of incidents**
- **Assault has the largest long-term felony backlog** (797 of 2,893 cases, 27.55%)
- **Theft creates the greatest recorded financial loss** ($3.99M of $12.85M, 31.08%)
- **Burglary and Vehicle Theft rank in the top five for both backlog and loss**
- **Vehicle theft occurs most often on streets** (382 of 1,300 thefts, 29.38%)
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
