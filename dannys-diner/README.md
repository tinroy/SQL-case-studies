Add Danny's Diner project README
## 📌 Project Overview

This project is a complete SQL case study based on **Danny’s Diner**, a fictional restaurant that wants to analyze customer purchasing behavior, membership impact, and loyalty points.

The goal of this project is to demonstrate **real-world SQL skills** commonly tested in **Data Analyst / Analytics / BI interviews**, including:

* Joins & aggregations
* Window functions
* Date logic
* Business-focused problem solving

This project is inspired by the *8 Week SQL Challenge* and implemented independently as a **portfolio-ready SQL analysis**.

---

## 🛠 Tech Stack

* **SQL (MySQL-compatible syntax)**
* Concepts used:

  * `JOIN`, `GROUP BY`, `CASE`
  * `COUNT`, `SUM`
  * Window functions (`RANK`, `DENSE_RANK`)
  * Date arithmetic (`INTERVAL`, `BETWEEN`)

---

## 📂 Database Schema

### 1️⃣ `menu`

Stores product-level information.

| column       | type    | description |
| ------------ | ------- | ----------- |
| product_id   | INT     | Primary key |
| product_name | VARCHAR | Item name   |
| price        | INT     | Item price  |

---

### 2️⃣ `members`

Stores customer membership join dates.

| column      | type     | description           |
| ----------- | -------- | --------------------- |
| customer_id | CHAR(1)  | Primary key           |
| join_date   | DATETIME | Membership start date |

---

### 3️⃣ `sales`

Stores transaction-level data.

| column      | type     | description   |
| ----------- | -------- | ------------- |
| order_id    | INT      | Primary key   |
| customer_id | CHAR(1)  | FK → members  |
| order_date  | DATETIME | Purchase date |
| product_id  | INT      | FK → menu     |

---

## 📊 Business Questions Answered

1. Total amount spent by each customer
2. Number of days each customer visited the restaurant
3. First item purchased by each customer
4. Most purchased item overall
5. Most popular item for each customer
6. First item purchased **after becoming a member**
7. Item purchased **just before becoming a member**
8. Total items and amount spent **before membership**
9. Loyalty points earned (with sushi multiplier)
10. Loyalty points with **first-week 2× multiplier**




---

⭐ *If you found this project helpful, feel free to star the repository!*
