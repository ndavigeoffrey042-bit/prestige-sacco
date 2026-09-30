-- 1. Create Members Table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    id_number VARCHAR(20) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    joined_date DATE NOT NULL,
    status ENUM('Active', 'Inactive', 'Suspended') DEFAULT 'Active'
);

-- 2. Create Savings Table (Tracks individual saving buckets)
CREATE TABLE savings (
    savings_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    total_savings_balance DECIMAL(15, 2) DEFAULT 0.00,
    last_deposit_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- 3. Create Loans Table (Tied to Members, limited by Multipliers based on Savings)
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    principal_amount DECIMAL(15, 2) NOT NULL,
    interest_rate DECIMAL(5, 2) NOT NULL, -- e.g., 12.00 for 12%
    loan_status ENUM('Pending', 'Approved', 'Disbursed', 'Fully Repaid', 'Defaulted') DEFAULT 'Pending',
    application_date DATE NOT NULL,
    disbursement_date DATE NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE RESTRICT
);

-- 4. Create Savings Transactions Ledger (Tracks contributions)
CREATE TABLE savings_ledger (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    savings_id INT NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    transaction_type ENUM('Deposit', 'Withdrawal') NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (savings_id) REFERENCES savings(savings_id)
);

-- 5. Create Loan Repayments Ledger (Tracks money coming back)
CREATE TABLE loan_repayments (
    repayment_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    amount_paid DECIMAL(15, 2) NOT NULL,
    principal_component DECIMAL(15, 2) NOT NULL,
    interest_component DECIMAL(15, 2) NOT NULL,
    repayment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
