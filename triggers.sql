DELIMITER $$

CREATE TRIGGER enforce_savings_withdrawal_lock
BEFORE INSERT ON savings_ledger
FOR EACH ROW
BEGIN
    DECLARE outstanding_loans INT DEFAULT 0;
    DECLARE current_member_id INT;

    -- 1. Find the member matching this savings account
    SELECT member_id INTO current_member_id 
    FROM savings 
    WHERE savings_id = NEW.savings_id;

    -- 2. Count if they have any unpaid or defaulted loans
    SELECT COUNT(*) INTO outstanding_loans 
    FROM loans 
    WHERE member_id = current_member_id 
      AND loan_status IN ('Approved', 'Disbursed', 'Defaulted');

    -- 3. Block withdrawal attempts if an unpaid loan exists
    IF NEW.transaction_type = 'Withdrawal' AND outstanding_loans > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction Rejected: Cannot withdraw savings while holding an active loan balance with Prestige SACCO.';
    END IF;
END$$

DELIMITER ;
