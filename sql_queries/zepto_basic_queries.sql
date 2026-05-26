
-- 1. file creation
CREATE TABLE zepto (
    category VARCHAR(100),
    name TEXT,
    mrp NUMERIC,
    discountPercent NUMERIC,
    availableQuantity INT,
    discountedSellingPrice NUMERIC,
    weightInGms INT,
    outOfStock BOOLEAN,
    quantity INT
);

-- 2. view tha data
SELECT * FROM zepto;

-- 3.Total products
SELECT COUNT(*) AS Total_Product from zepto;

-- 4.Expensive Products
SELECT name, mrp
FROM zepto
ORDER BY mrp DESC
LIMIT 10;

-- 5.Cheapest Products
SELECT name, discountedSellingPrice
FROM zepto
ORDER BY discountedSellingPrice ASC
LIMIT 10;

-- 6.Out of Stock Products
SELECT name, category
FROM zepto
WHERE outOfStock = TRUE;

--7. Products Above ₹500
SELECT name, mrp
FROM zepto
WHERE mrp > 500;
