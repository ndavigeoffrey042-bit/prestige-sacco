# Prestige SACCO Core System

A secure, community-driven financial database system designed for **Prestige SACCO**. This project implements a closed-loop financial ecosystem where member savings directly capitalize and back member loans, creating a self-sustaining financial model.

## 📊 Core Relational Architecture

The system operates on an internal financial loop divided into four main interactions:

1. **Contributions:** Members regularly pool their savings into the collective fund, building individual borrowing power.
2. **Capitalization:** The accumulated savings act as the direct liquidity source for loans. The total value of disbursed loans is constrained by the pool's liquidity.
3. **Growth & Yield:** Loan repayments include an interest component which flows back into the collective pool, growing the fund instead of losing value to external banking institutions.
4. **Dividends/Share-out:** At the end of the financial cycle, accumulated yields are distributed back to members proportionally based on their total savings weight.

Use code with caution.
+------------------------------------------+
|                  MEMBER                  |
+------------------+-----------------------+
|               ^
1. Contributes   |               | 4. Receives
Savings       |               |    Dividends/Share-out
v               |
+----------------------------------+-------+
|                 SAVINGS                  |
|          (The Collective Fund)           |
+------------------+-----------------------+
|               ^
2. Disburses     |               | 3. Repays Principal
Principal     |               |    + Interest
v               |
+------------------------------------------+
|                   LOAN                   |
+------------------------------------------+

## 🛠️ Database Schema Design

The architecture is built using relational SQL tables (`schema.sql`) to ensure absolute data integrity and financial auditing capabilities:

* **`members`**: Stores KYC details, status flags (`Active`, `Inactive`, `Suspended`), and registration tracking.
* **`savings`**: Tracks active individual member balances. Updates dynamically via a transaction ledger.
* **`loans`**: Manages loan applications, tracking balances, interest metrics, and states (`Pending`, `Approved`, `Disbursed`, `Fully Repaid`, `Defaulted`).
* **`savings_ledger`**: An immutable double-entry style audit log for all member deposits and withdrawals.
* **`loan_repayments`**: Breaks down each payment into principal and interest components for precise dividend calculations.

## 🚀 How to Use This Schema

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com
   ```
2. Import the `schema.sql` file into your SQL database engine (MySQL/MariaDB/PostgreSQL):
   ```bash
   mysql -u your_username -p your_database_name < schema.sql
   Add project documentation README
   ```
