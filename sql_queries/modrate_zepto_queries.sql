-- 1. Category Wise Product Count
SELECT category,COUNT(*) AS total_products
FROM zepto
GROUP BY category
ORDER BY total_products DESC;

-- 2.Average Discount By Category
SELECT category, ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category;

-- 3.Average Selling Price
SELECT category, ROUND(AVG(discountedSellingPrice),2) AS avg_price
FROM zepto
GROUP BY category
ORDER BY avg_price DESC;

-- 4.Products With More Than 50% Discount
SELECT name, category, discountpercent 
FROM zepto
WHERE discountpercent > 50;

-- 5.Savings Analysis
SELECT name, mrp, discountedsellingprice, (mrp-discountedsellingprice) AS total_saving
FROM zepto
ORDER BY total_saving DESC;


-- 6. Categories Having More Than 20 Products
SELECT * FROM zepto;
SELECT category, count(*) AS TOTAL_PRODUCT
FROM zepto
GROUP BY category
HAVING  count(*) > 20
ORDER BY  count(*);



