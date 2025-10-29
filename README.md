# Analysing-Customer-Churn-and-Retention-Patterns-in-a-UK-Based-Multinational-Retail-Bank

# Overview 

Company Context Veritas Bank, a UK-based retail bank with operations in Germany and France, serves over 3 million customers. Known for technology-driven services, the bank now faces rising churn due to fintech competition, declining engagement in continental Europe, and lack of real-time churn monitoring.

## Business Challenge 

Veritas Bank is facing increased customer churn from its users. Retaining customers has become a growing challenge due to:

- > **Intense competition from neobanks and fintech startups**
 - > **Perceived decrease in customer engagement in Germany and France**
  - >  **Lack of targeted retention strategies based on behavioural insights**

The absence of real-time churn monitoring and customer segmentation has made it difficult for the business to respond
proactively.

## Tools and Technologies Used 

<p align="center">
  <a href="https://learn.microsoft.com/en-us/sql/sql-server/" target="_blank">
    <img src="https://upload.wikimedia.org/wikipedia/commons/8/87/Sql_data_base_with_logo.png" alt="SQL Server" width="70"/>
  </a>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://powerbi.microsoft.com/" target="_blank">
    <img src="https://upload.wikimedia.org/wikipedia/commons/c/cf/New_Power_BI_Logo.svg" alt="Power BI" width="70"/>
  </a>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://www.docker.com/" target="_blank">
    <img src="https://upload.wikimedia.org/wikipedia/commons/4/4e/Docker_%28container_engine%29_logo.svg" alt="Docker" width="70"/>
  </a>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://azure.microsoft.com/en-us/products/data-studio/" target="_blank">
    <img src="https://upload.wikimedia.org/wikipedia/commons/f/fa/Microsoft_Azure.svg" alt="Azure Data Studio" width="70"/>
  </a>
</p>

<p align="center">
  <b>SQL Server</b> &nbsp;&nbsp;&nbsp;&nbsp;
  <b>Power BI</b> &nbsp;&nbsp;&nbsp;&nbsp;
  <b>Docker</b> &nbsp;&nbsp;&nbsp;&nbsp;
  <b>Azure Data Studio</b>
</p>


## Challenge Faced!

While working on this project, I needed to:
- Store and query large datasets efficiently using **SQL Server**
- Use **Power BI** for visualizations  
- But my main device was a **MacBook (M1)**  which doesn’t support SQL Server installation natively.

Instead of switching systems, I found a cross-platform solution.

---
### Running SQL Server on Mac for Data Analysis (M1)

This documents how I overcame the challenge of running **SQL Server** on a **Mac (M1)** while working on a this **project**.  
Since SQL Server isn’t natively supported on macOS, I used **Docker**, **Azure SQL Edge**, and **Azure Data Studio** to set up a full working environment and then connected it to **Power BI** (on Windows) for visualization.

---

## My Setup

| Tool | Purpose |
|------|----------|
| 🐳 **Docker** | To host SQL Server in a container using the Azure SQL Edge image |
| ☁️ **Azure SQL Edge** | Lightweight version of SQL Server that runs on ARM processors |
| 💻 **Azure Data Studio** | For database management and SQL queries on Mac |
| 🟨 **Power BI (Windows)** | For analysis and visualization via remote connection |

---

 ## Project Objectives

1. Identify Common Characteristics :
   
• Identify common characteristics amongst customers who have
churned.

3. Regional Comparison:
   
• Compare account behaviour across the UK, Germany, and France.

5. Customer Segmentation:
   
• Segment customers based on risk profiles and account usage.

7. Interactive Dashboards:

• Visualise key churn metrics via interactive dashboards for better
decision-making


## Conclution 


