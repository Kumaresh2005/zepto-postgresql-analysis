-- CTE Example
WITH avg_price AS (
    SELECT category,AVG(discountedSellingPrice) AS avgp
    FROM zepto
    GROUP BY category

)

SELECT z.name,
       z.category,
       z.discountedSellingPrice,
       round(a.avgp,2)
FROM zepto z
JOIN avg_price a
ON z.category = a.category
WHERE z.discountedSellingPrice > a.avgp;


-- Window Function
SELECT category,
       name,
       mrp,
       RANK() OVER(
           PARTITION BY category
           ORDER BY mrp DESC
       ) AS price_rank
FROM zepto;

-- Top 3 Expensive Products Per Category
SELECT *
FROM (
	SELECT category,
           name,
           mrp,
           ROW_NUMBER() OVER(
               PARTITION BY category
               ORDER BY mrp DESC
           ) AS rn
    FROM zepto
	) t
WHERE rn <= 3;

-- Create View
CREATE VIEW high_discount_products AS

SELECT name,
       category,
       discountPercent
FROM zepto
WHERE discountPercent > 40;


-- Use View
SELECT *
FROM high_discount_products;


-- Dense Rank Example
SELECT category,
       name,
       discountedSellingPrice,
       DENSE_RANK() OVER(
           PARTITION BY category
           ORDER BY discountedSellingPrice DESC
       ) AS ranking
FROM zepto;


-- User Define Functions
CREATE OR REPLACE FUNCTION total_products(cat_name VARCHAR)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE total INT;
BEGIN
    SELECT COUNT(*)
    INTO total
    FROM zepto
    WHERE category = cat_name;
    RETURN total;
END;
$$;

-- call the function
SELECT total_products('Beverages');

-- Trigger Log Deleted Products

CREATE TABLE deleted_products (

    product_name TEXT,
    deleted_at TIMESTAMP

);

-- Trigger Function

CREATE OR REPLACE FUNCTION log_deleted_product()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO deleted_products
    VALUES(OLD.name, NOW());
    RETURN OLD;
END;
$$;

-- Create Trigger
CREATE TRIGGER before_product_delete
BEFORE DELETE
ON zepto
FOR EACH ROW
EXECUTE FUNCTION log_deleted_product();

-- Index
CREATE INDEX idx_category
ON zepto(category);

-- View
CREATE VIEW top_discount_products AS
SELECT name,
       category,
       discountPercent
FROM zepto
WHERE discountPercent > 50;

SELECT *
FROM top_discount_products;

-- Transaction
BEGIN;
UPDATE zepto
SET discountedSellingPrice = 100
WHERE name = 'Milk';
ROLLBACK;

COMMIT;

-- Case Statement
SELECT name,
       mrp,
CASE
    WHEN mrp > 500 THEN 'Expensive'
    WHEN mrp > 200 THEN 'Moderate'
    ELSE 'Cheap'
END AS price_category
FROM zepto;


