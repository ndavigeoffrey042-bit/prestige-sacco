INSERT INTO members (first_name, last_name, id_number, phone_number, joined_date, status) 
VALUES ('John', 'Doe', '12345678', '+254700000000', '2026-01-15', 'Active');

-- Initialize their Savings Bucket
INSERT INTO savings (member_id, total_savings_balance) 
VALUES (1, 50000.00);
