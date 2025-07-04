Enter password: ****
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 9.3.0 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| 14_feb_batch       |
| information_schema |
| librarydb          |
| mysql              |
| performance_schema |
| serenemind         |
| sys                |
| tables             |
+--------------------+
8 rows in set (0.094 sec)

mysql> use tables;
Database changed
mysql> show tables;
+------------------+
| Tables_in_tables |
+------------------+
| customers        |
| orders           |
+------------------+
2 rows in set (0.109 sec)

mysql> desc customers;
+--------------+--------------+------+-----+---------+-------+
| Field        | Type         | Null | Key | Default | Extra |
+--------------+--------------+------+-----+---------+-------+
| CustomerID   | int          | NO   | PRI | NULL    |       |
| CustomerName | varchar(100) | YES  |     | NULL    |       |
+--------------+--------------+------+-----+---------+-------+
2 rows in set (0.190 sec)

mysql> desc orders;
+------------+---------------+------+-----+---------+-------+
| Field      | Type          | Null | Key | Default | Extra |
+------------+---------------+------+-----+---------+-------+
| OrderID    | int           | NO   | PRI | NULL    |       |
| CustomerID | int           | YES  |     | NULL    |       |
| Product    | varchar(100)  | YES  |     | NULL    |       |
| Amount     | decimal(10,2) | YES  |     | NULL    |       |
+------------+---------------+------+-----+---------+-------+
4 rows in set (0.056 sec)

mysql> select * from customers;
+------------+--------------+
| CustomerID | CustomerName |
+------------+--------------+
|          1 | Abhishek     |
|          2 | Neha         |
|          3 | Rahul        |
|          4 | Meena        |
+------------+--------------+
4 rows in set (0.072 sec)

mysql> select * from orders;
+---------+------------+----------+----------+
| OrderID | CustomerID | Product  | Amount   |
+---------+------------+----------+----------+
|     101 |          1 | Laptop   | 50000.00 |
|     102 |          1 | Mouse    |   600.00 |
|     103 |          2 | Keyboard |  1500.00 |
|     104 |          2 | Chair    |  3000.00 |
|     105 |          3 | Desk     |  7000.00 |
+---------+------------+----------+----------+
5 rows in set (0.053 sec)

mysql> CREATE VIEW v_customer_orders AS
    -> SELECT c.CustomerName, o.Product, o.Amount
    -> FROM Customers c
    -> JOIN Orders o ON c.CustomerID = o.CustomerID;
Query OK, 0 rows affected (0.576 sec)

mysql> SELECT * FROM v_customer_orders;
+--------------+----------+----------+
| CustomerName | Product  | Amount   |
+--------------+----------+----------+
| Abhishek     | Laptop   | 50000.00 |
| Abhishek     | Mouse    |   600.00 |
| Neha         | Keyboard |  1500.00 |
| Neha         | Chair    |  3000.00 |
| Rahul        | Desk     |  7000.00 |
+--------------+----------+----------+
5 rows in set (0.038 sec)

mysql> CREATE VIEW v_high_spenders AS
    -> SELECT c.CustomerID, c.CustomerName, SUM(o.Amount) AS TotalSpend
    -> FROM Customers c
    -> JOIN Orders o ON c.CustomerID = o.CustomerID
    -> GROUP BY c.CustomerID, c.CustomerName
    -> HAVING SUM(o.Amount) > 10000;
Query OK, 0 rows affected (0.179 sec)

mysql> SELECT * FROM v_high_spenders;
+------------+--------------+------------+
| CustomerID | CustomerName | TotalSpend |
+------------+--------------+------------+
|          1 | Abhishek     |   50600.00 |
+------------+--------------+------------+
1 row in set (0.178 sec)

mysql> DROP VIEW v_high_spenders;
Query OK, 0 rows affected (0.128 sec)

mysql>