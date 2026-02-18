-- 2.1
INSERT INTO "HW-2"."Orders"(
	"O_id", order_date)
	VALUES (0, '3055-03-14'),(1, '3055-03-14');

SELECT * from "HW-2"."Order_items";
SELECT * from "HW-2"."Orders";
SELECT * from "HW-2"."Products";

-- 2.2
INSERT INTO "HW-2"."Products"(
	p_name, price)
	VALUES ('p1', 4),('p2', 7);
--2.3
ALTER TABLE "HW-2"."Order_items" ALTER COLUMN amount SET DEFAULT 1

--2.4
INSERT INTO "HW-2"."Order_items"(order_id, product_name, amount)

	VALUES (1, 'p1', 13), (1, 'p2', 7);
	

ALTER TABLE "HW-2"."Products" RENAME p_id TO p_name;

ALTER TABLE "HW-2"."Products" ADD COLUMN p_id serial;
TRUNCATE TABLE "HW-2"."Products";
ALTER TABLE "HW-2"."Products" 
ALTER COLUMN p_id TYPE SERIAL;

--3.1
ALTER TABLE "HW-2"."Order_items" ALTER COLUMN amount SET NOT NULL;
ALTER TABLE "HW-2"."Order_items" ALTER COLUMN amount SET NOT NULL;
ALTER TABLE "HW-2"."Order_items" ALTER COLUMN amount SET NOT NULL;

--3.2

--3.3
ALTER TABLE "HW-2"."Order_items" ALTER COLUMN amount UNIQUE;

DROP INDEX unique_product_p_name

CREATE UNIQUE INDEX CONCURRENTLY unique_product_p_name
ON "HW-2"."Products" (p_name);

ALTER TABLE "HW-2"."Products"
ADD CONSTRAINT unique_product_p_name
UNIQUE USING INDEX unique_product_p_name;

--3.4
ALTER TABLE "HW-2"."Order_items" ADD COLUMN price money NOT NULL DEFAULT 0;
ALTER TABLE "HW-2"."Order_items" ADD COLUMN total money NOT NULL DEFAULT 0;

--3.5
UPDATE "HW-2"."Order_items" as oi
SET price = p.price
FROM "HW-2"."Products" AS p
WHERE  p.p_name = oi.product_name;


--3.6
UPDATE "HW-2"."Order_items"
SET total = amount * price;


ALTER TABLE "HW-2"."Order_items" 
ADD CONSTRAINT check_total_calculation 
CHECK (total = amount * price);



--4.1
UPDATE "HW-2"."Order_items" AS p
SET p_name = 'product1'
WHERE p_name = 'p1'

--4.2
DELETE FROM Order_Items 
WHERE order_id = (
    SELECT MIN(o_id) FROM Orders
) 
AND p_id = (
    SELECT p_id FROM Products WHERE p_name = 'p2'
);

--4.3

DELETE FROM "HW-2"."Order_items" AS oi
WHERE o_id = (
    SELECT o_id FROM Orders 
    ORDER BY o_id 
    OFFSET 1 LIMIT 1
);


--4.4

SELECT * from "HW-2"."Order_items" AS oi;
SELECT * from "HW-2"."Orders";
SELECT * from "HW-2"."Products" AS p;


UPDATE "HW-2"."Products" AS p
SET price = 5
WHERE p_name = 'product1'

UPDATE "HW-2"."Order_items" AS p
SET product_name = 'product1'
WHERE product_name = 'p1'

--4.5

INSERT INTO Orders (order_date) 
VALUES (CURRENT_DATE);

INSERT INTO Order_Items (order_id, p_id, product_name, amount, price, total)
SELECT 
    -- Get the newly created order's ID
    (SELECT MAX(o_id) FROM Orders),
    -- Get p_id for product1 without hardcoding it
    (SELECT p_id FROM Products WHERE p_name = 'product1'),
    -- Product name
    'product1',
    -- Amount
    3,
    -- Price from Products table
    (SELECT price FROM Products WHERE p_name = 'product1'),
    -- Calculate total
    3 * (SELECT price FROM Products WHERE p_name = 'product1');







	