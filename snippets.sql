-- 1 --
select *, (
        select customer_id
        from orders
        where
            id = order_details.order_id
    ) as customer_id
from order_details;

-- 2 --
select *
from order_details
where
    order_id IN (
        select id
        from orders
        where
            shipper_id = 3
    );

-- 3 --
SELECT order_id, AVG(quantity) AS average_quantity
FROM (
        SELECT order_id, quantity
        FROM order_details
        WHERE
            quantity > 10
    ) AS filtered_order_details
GROUP BY
    order_id;

-- 4 --
-- using CTE
WITH
    temp AS (
        SELECT order_id, quantity
        FROM order_details
        WHERE
            quantity > 10
    )
SELECT order_id, AVG(quantity) AS average_quantity
FROM temp
GROUP BY
    order_id;

-- using subquery in FROM clause
SELECT order_id, AVG(quantity) AS average_quantity
FROM (
        SELECT order_id, quantity
        FROM order_details
        WHERE
            quantity > 10
    ) temp
GROUP BY
    order_id;

-- 5 --
-- Видалення функції, якщо вона вже існує
DROP FUNCTION IF EXISTS divide_numbers;

DELIMITER / /
-- Створення функції divide_numbers
CREATE FUNCTION divide_numbers(a FLOAT, b FLOAT) RETURNS FLOAT
DETERMINISTIC
BEGIN
    RETURN a / b;
END//

DELIMITER;

SELECT
    order_id,
    quantity,
    divide_numbers (quantity, 2.0) AS divided_quantity
FROM order_details;