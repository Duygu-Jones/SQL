--04 June 2024--

### Örnek Database: `products` ve `sales` Tabloları

#### `products` Tablosu

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

INSERT INTO products (product_id, product_name, category, price, stock_quantity) VALUES
(1, 'Laptop', 'Electronics', 800.00, 50),
(2, 'Smartphone', 'Electronics', 600.00, 150),
(3, 'Tablet', 'Electronics', 300.00, 200),
(4, 'Headphones', 'Accessories', 50.00, 300),
(5, 'Charger', 'Accessories', 20.00, 500),
(6, 'Office Chair', 'Furniture', 150.00, 100),
(7, 'Desk', 'Furniture', 200.00, 75),
(8, 'Monitor', 'Electronics', 200.00, 80),
(9, 'Keyboard', 'Accessories', 30.00, 250),
(10, 'Mouse', 'Accessories', 25.00, 400);

SELECT * FROM products;


#### `sales` Tablosu

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity_sold INT,
    total_sale DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO sales (sale_id, product_id, sale_date, quantity_sold, total_sale) VALUES
(1, 1, '2024-01-15', 5, 4000.00),
(2, 2, '2024-01-16', 10, 6000.00),
(3, 3, '2024-01-17', 7, 2100.00),
(4, 4, '2024-01-18', 20, 1000.00),
(5, 5, '2024-01-19', 15, 300.00),
(6, 6, '2024-01-20', 8, 1200.00),
(7, 7, '2024-01-21', 3, 600.00),
(8, 8, '2024-01-22', 4, 800.00),
(9, 9, '2024-01-23', 12, 360.00),
(10, 10, '2024-01-24', 18, 450.00);

SELECT * FROM sales s 

### Sorular:

--1. Tüm ürünlerin bilgilerini getiren bir sorgu yazın.

SELECT *FROM products p 

--2. Stok miktarı 100'den fazla olan ürünleri getiren bir sorgu yazın.
SELECT * 
FROM products p 
WHERE stock_quantity >100


--3. 'Electronics' kategorisindeki ürünlerin isimlerini ve fiyatlarını getiren bir sorgu yazın.
SELECT product_name , price 
FROM products p 
WHERE category = 'Electronics';


--4. Fiyatı 100'den fazla olan ürünleri getiren bir sorgu yazın.
SELECT *
FROM products 
WHERE price >100;

--5. Her kategorideki toplam stok miktarını hesaplayan bir sorgu yazın.
SELECT category ,
	sum(stock_quantity) AS total_stock 
FROM products
GROUP BY category; 


--6. 'Accessories' kategorisindeki ürünleri getiren bir sorgu yazın.
SELECT *
FROM products p
WHERE category = 'Accessories';


--7. Fiyatı 50 ile 200 arasında olan ürünleri getiren bir sorgu yazın.
SELECT *
FROM products p 
WHERE price BETWEEN 50 AND 200;

--8. Her kategorideki en pahalı ürünü getiren bir sorgu yazın.
SELECT category , max(price) AS max_price 
FROM products p 
GROUP BY category;


--9. 2024-01-20 tarihinden sonraki satışları getiren bir sorgu yazın.
SELECT *
FROM sales s 
WHERE sale_date > '2024-01-20';


--10. En çok satan ürünü getiren bir sorgu yazın.
SELECT product_id , sum(quantity_sold) AS total_sold_product
FROM sales s 
GROUP BY product_id
ORDER BY total_sold_product DESC 
LIMIT 1;



--11. Her üründen kaç adet satıldığını hesaplayan bir sorgu yazın.
SELECT product_id , sum(quantity_sold) AS total_sales
FROM sales s 
GROUP BY product_id ;


--12. Satışların toplam değerini hesaplayan bir sorgu yazın.
SELECT sum(total_sale) AS total_sales
FROM sales s 

--13. '2024-01-15' ile '2024-01-20' tarihleri arasındaki satışları getiren bir sorgu yazın.
SELECT *  
FROM sales s 
WHERE sale_date 
BETWEEN '2024-01-15' AND '2024-01-20';

--14. En az satılan ürünü getiren bir sorgu yazın.
SELECT 
	product_id, 
	sum(quantity_sold) AS tot_sold_product
FROM sales s 
GROUP BY product_id 
ORDER BY tot_sold_product ASC 
LIMIT 1;

--15. Her ürün için toplam satış miktarını ve ortalama satış değerini hesaplayan bir sorgu yazın.
SELECT product_id, 
sum(quantity_sold) AS total_amount, 
avg(total_sale) AS avg_total_sales 
FROM sales s 
GROUP BY product_id; 

--16. Satış miktarına göre ürünleri azalan sırada listeleyen bir sorgu yazın.
SELECT *
FROM sales s 
ORDER BY quantity_sold DESC 

--17. 'Electronics' kategorisindeki ürünlerin toplam satış değerini hesaplayan bir sorgu yazın.
SELECT sum(s.total_sale) AS total_sales_value
FROM sales s 
JOIN products p ON s.product_id =p.product_id 
WHERE p.category = 'Electronics';


--18. Her kategoride kaç farklı ürün olduğunu hesaplayan bir sorgu yazın.
SELECT category , count(*)
FROM products p
GROUP BY category

SELECT * FROM products p 

--19. 'Accessories' kategorisindeki ürünlerin ortalama fiyatını hesaplayan bir sorgu yazın.
SELECT category, 
avg(price) AS avg_price
FROM products p 
WHERE category ='Accessories'
GROUP BY category ;
---

SELECT sum(s.total_sale), avg(s.quantity_sold) 
FROM sales s 
JOIN products p ON s.product_id =p.product_id 
WHERE p.category = 'Accessories';

--20. Her ürünün toplam satış miktarını ve toplam satış değerini hesaplayan bir sorgu yazın.
SELECT *
FROM products p 


SELECT p.product_name , sum(s.quantity_sold) AS total_sold_amound, 
sum(s.total_sale) AS total_sales 
FROM sales s 
JOIN products p ON s.product_id =p.product_id 
GROUP BY p.product_name ;

------------


