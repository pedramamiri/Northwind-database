--1. I vilka länder har företaget anställda? Ange Country samt visa inte dubbletter i 
 SELECT DISTINCT country FROM `Employees`;

--2. Vilka kategorier av produkter finns det i databasen? Ange CategoryID och CategoryName. Sortera efter CategoryName i fallande ordning.
SELECT Categories.CategoryID,Categories.CategoryName FROM `Categories` ORDER BY Categories.CategoryName DESC;

--3. Gör en telefonlista över samtliga tyska kunder. Ange CompanyName, ContactName, Phone samt Fax. Sortera efter CompanyName i fallande ordning.
SELECT Customers.CompanyName,Customers.ContactName,Customers.Phone,Customers.Fax FROM `Customers` WHERE Customers.Country="Germany" ORDER BY Customers.CompanyName DESC;

--4. I vilka svenska städer finns det kunder? Ange City.
SELECT Customers.City FROM `Customers` WHERE Customers.Country="Sweden";

--5. Vilka produkter innehåller ordet 'bröd' i sitt produktnamn? Ange ProductName. 
SELECT Products.ProductName FROM `Products` WHERE Products.ProductName LIKE "%br-d%";

--6. Vilken anställd föddes 1966-01-27? Ange förnamn och efternamn. 
SELECT Employees.FirstName,Employees.LastName FROM `Employees` WHERE Employees.BirthDate="1966-01-27";

--7. Vilken anställd har ingen chef (dvs där ReportsTo är NULL)? Ange förnamn och efternamn.
SELECT Employees.FirstName,Employees.LastName FROM `Employees` WHERE Employees.ReportsTo IS NULL;

--8. Vilka produkter behöver beställas, dvs där lagerantalet är mindre än ReorderLevel (ta inte med produkter som har utgått ur sortementet)? Ange ProductName, UnitsInStock samt ReorderLevel. 
SELECT Products.ProductName,Products.UnitsInStock,Products.ReorderLevel FROM `Products` WHERE Products.UnitsInStock<Products.ReorderLevel;

--9. Vilka tyska och franska leverantörer finns i databasen? Ange CompanyName, ContactName, Country, Phone samt Homepage. Sortera efter CompanyName i fallande ordning.
SELECT Suppliers.CompanyName, Suppliers.ContactName,Suppliers.Country,Suppliers.Phone,Suppliers.HomePage FROM `Suppliers` WHERE Suppliers.Country = "Germany" OR Suppliers.Country="France" ORDER BY Suppliers.CompanyName DESC;

--10. Vilka produkter finns det mer än 100 av i lager? Ange ProductID, ProductName, UnitPrice samt UnitsInStock. Sortera först efter UnitPrice i fallande ordning och sedan efter UnitsInStock i stigande ordning.
SELECT Products.ProductID,Products.ProductName,Products.UnitPrice,Products.UnitsInStock FROM `Products` WHERE Products.UnitsInStock >= 100 ORDER BY Products.UnitPrice DESC , Products.UnitsInStock ASC;

--11. Vilket födelsedatum har den anställd som är äldst?
SELECT MIN(Employees.BirthDate) AS födelsedatum FROM `Employees`;

--12. Vad är snittpriset samt summan för produkter i kategori 2?
SELECT AVG(Products.UnitPrice) AS snittpriset , SUM(Products.UnitPrice) AS summ FROM `Products` WHERE Products.CategoryID=2;

--13. Vad är den största rabatten som ges bland samtliga orderrader?
SELECT MAX(Order_Details.Discount) AS störstarabatt FROM `Order_Details`;

--14. Hur många olika produktkategorier finns det?
SELECT COUNT(Categories.CategoryID) AS Antal FROM `Categories`;

--15. Hur många kunder finns det i varje land? Sortera efter antal kunder i fallande ordning.
SELECT Customers.Country AS Country,COUNT(Customers.CustomerID) AS Antal FROM `Customers` GROUP BY Country ORDER BY Antal DESC;

--16. Vad är det genomsnittliga priset för produkter i kategorierna 1, 3, 5, och 7 grupperade efter leverantör? 
SELECT Products.SupplierID AS SupplierID,ROUND(AVG(Products.UnitPrice),2) AS snittpris FROM `Products` WHERE Products.CategoryID IN(1,3,5,7) GROUP BY SupplierID;

--17. Ange CategoryID för de kategorier som innehåller fler än 10 produkter.
SELECT CategoryID FROM `Products` GROUP BY CategoryID HAVING COUNT(ProductID)>10;

--18. Visa CustomerID för de kunder som hade fler än 10 ordrar under perioden 1998-01- 01 och 1998-12-31.
SELECT Orders.CustomerID,COUNT(Orders.OrderID) AS antal FROM `Orders` WHERE Orders.OrderDate BETWEEN '1998-01-01' AND '1998-12-31' GROUP BY Orders.CustomerID ORDER BY antal DESC LIMIT 1;

--19. Lista varje order med OrderID större än 10500 som har en ordersumma (summan av orderradernas enhetspris*antal) som överstiger 10000. Ange OrderID samt ordersumman som [OrderSumma]. Sortera efter ordersumman i fallande ordning.
SELECT Order_Details.OrderID,SUM(Order_Details.UnitPrice*Order_Details.Quantity) AS summa FROM `Order_Details` WHERE Order_Details.OrderID>10500 GROUP BY Order_Details.OrderID HAVING summa>10000 ORDER BY summa DESC;

--20. Skapa en tio-i-top lista över de produkter som det har sålts mest av. Ange ProductID samt summan av antalet sålda enheter som [Antal].
SELECT Order_Details.ProductID,SUM(Order_Details.Quantity) AS antal FROM `Order_Details` GROUP BY Order_Details.ProductID ORDER BY antal DESC LIMIT 10;

--21. Skapa en lista som visar antalet ordrar per kund som har skäppats till de olika länderna, där antalet ordrar per kund överstiger 10.Endast ordrar med en ShipRegion som är NULL skall tas med. Gruppera först efter ShipCountry och sedan efter CustomerID. Ange ShipCountry, CustomerID samt antalet ordrar per kund som [Antal]. Sortera först efter ShipCountry i fallande ordning och sedan efter CustomerID i stigande ordning.
SELECT Orders.ShipCountry,Orders.CustomerID,COUNT(Orders.CustomerID) AS antal FROM `Orders` WHERE Orders.ShipRegion IS NULL GROUP BY Orders.ShipCountry,Orders.CustomerID HAVING antal>10 ORDER BY Orders.ShipCountry DESC,Orders.CustomerID ASC;

