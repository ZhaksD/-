SELECT * FROM accounts LIMIT 10;
SELECT * FROM customers LIMIT 10;
SELECT * FROM transactions LIMIT 10;

SELECT 
    a.customer_id,
    MAX(t.transaction_date) AS last_txn
FROM accounts a
JOIN transactions t ON a.account_id = t.account_id
GROUP BY a.customer_id
HAVING MAX(t.transaction_date) < CURRENT_DATE - INTERVAL '30 days';

SELECT 
    a.customer_id,
    CURRENT_DATE - MAX(t.transaction_date) AS recency,
    COUNT(t.transaction_id) AS frequency,
    SUM(t.amount) AS monetary
FROM accounts a
JOIN transactions t ON a.account_id = t.account_id
GROUP BY a.customer_id
ORDER BY monetary DESC, frequency DESC;

SELECT 
    a.customer_id,
    SUM(CASE WHEN t.type = 'credit' THEN amount ELSE 0 END) AS income,
    SUM(CASE WHEN t.type = 'debit' THEN amount ELSE 0 END) AS expenses
FROM accounts a
JOIN transactions t ON a.account_id = t.account_id
GROUP BY a.customer_id;

SELECT 
    category,
    COUNT(*) AS transactions,
    AVG(amount) AS avg_check
FROM transactions
GROUP BY category
ORDER BY transactions DESC;

SELECT 
    account_id,
    SUM(amount) AS total_atm
FROM transactions
WHERE category = 'atm'
GROUP BY account_id
HAVING SUM(amount) > 250000;

SELECT 
    c.segment,
    COUNT(DISTINCT c.customer_id) AS clients,
    AVG(t.amount) AS avg_spent
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.segment;

-- создаем единую таблицу
CREATE TABLE bank_full AS
SELECT
    c.customer_id,
    c.age,
    c.gender,
    c.city,
    c.segment,
    
    a.account_id,
    a.balance,
    
    t.transaction_id,
    t.transaction_date,
    t.amount,
    t.type,
    t.category
    
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id;
