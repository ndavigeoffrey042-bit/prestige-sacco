-- 1. Calculate Average Savings per Member across Prestige SACCO
SELECT 
    AVG(total_savings_balance) AS average_member_savings,
    SUM(total_savings_balance) AS total_sacco_liquidity
FROM savings;

-- 2. Calculate Average Loan Size and Interest Earned
SELECT 
    AVG(principal_amount) AS average_loan_disbursed,
    SUM(principal_amount * (interest_rate / 100)) AS total_expected_interest_yield
FROM loans 
WHERE loan_status IN ('Approved', 'Disbursed');

-- 3. Audit Member Profile with their Savings vs Max Borrowing Limit (3x Rule)
SELECT 
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    s.total_savings_balance,
    (s.total_savings_balance * 3) AS maximum_allowed_loan
FROM members m
JOIN savings s ON m.member_id = s.member_id
WHERE m.status = 'Active';
