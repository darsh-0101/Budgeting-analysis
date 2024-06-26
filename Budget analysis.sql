create table FACT_TABLE( Date DATE, ProductID INT PRIMARY KEY IDENTITY (1,1), Profit INT, Sales INT, Margin INT, COGS INT, Total_Expenses INT,
 Marketing INT, Inventory INT, Budget_Profit INT, Budget_COGS INT, Budget_Margin INT, Budget_Sales INT , Area_Code INT)
 
 CREATE TABLE ProductTable( Product_Type varchar(20),
 Product VARCHAR (20), ProductID int references FACT_TABLE(ProductID) ,Type VARCHAR(10))

 CREATE TABLE LocationTable( Area_Code int,
 State varchar (10), Market varchar(10), Market_Size int)

 --1. Display the number of states present in theLocationTable.
 SELECT COUNT(State) from LocationTable


 --2. Howmany products are of regular type?
 SELECT COUNT(Type) AS regular_type from ProductTable
 where Type='regular'

 --Howmuch spending has been done on marketing of product ID1?

select SUM(marketing) from FACT_TABLE
where ProductID=1

--What is the minimum sales of a product?
SELECT MIN(SALES) FROM FACT_TABLE

--Display the max Cost of Good Sold (COGS)
SELECT MAX(COGS) FROM FACT_TABLE

--Display the details of the product where product type iscoffee.
SELECT * FROM ProductTable
WHERE Product_Type='COFFEE'

-- Display the details where total expenses are greater than40.
SELECT * FROM FACT_TABLE
WHERE Total_Expenses>40

 -- What is the average sales in area code 719?
 SELECT AVG(SALES) FROM FACT_TABLE
 WHERE Area_Code=719

 -- Find out the total profit generated by Colorado state.
 SELECT SUM(profit) FROM FACT_TABLE AS FACT
 JOIN LocationTable AS LOC ON LOC.Area_Code= FACT.Area_Code
 WHERE State='Colorado'

 --Display the average inventory for each product ID.
 select AVG(inventory),ProductID from FACT_TABLE 
 group by ProductID

 --Display state in a sequential order in a LocationTable.
 Select state from LocationTable
 order by state 


 --Display the average budget of the Product where the average budget margin should be greater than 100.
 select ProductID, AVG(Budget_Margin) from FACT_TABLE 
 where Budget_Margin>100
 group by ProductID

 -- What is the total sales done on date 2010-01-01?
 select SUM(sales) from FACT_TABLE
 where Date='2010-01-01';

-- Display the average total expense of each product ID on anindividual date.
select ProductID,AVG(Total_Expenses),DATE from FACT_TABLE fact
group by ProductID,Date


-- Display the table with the following attributes such as date, productID,
--product_type, product, sales, profit, state, area_code.
select Date, fact.ProductID,product_type, product, sales, profit, state, fact.Area_Code from FACT_TABLE fact
join LocationTable as loc on fact.Area_Code=loc.Area_Code
join ProductTable prod on fact.ProductID=prod.ProductID

--Display the rank without any gap to show the sales wiserank.
select dense_RANK() over (order by sales)  as saleswiserank from FACT_TABLE 
-- Find the state wise profit and sales.
select state, SUM (sales) as tot_sales,SUM(profit) as tot_profit from FACT_TABLE fact
join LocationTable loc on fact.Area_Code=loc.Area_Code
group by state
-- Find the state wise profit and sales along with the productname.
select state,product,SUM (sales) as tot_sales,SUM(profit) as tot_profit from FACT_TABLE fact
join LocationTable loc on fact.Area_Code=loc.Area_Code
join ProductTable prod on fact.ProductID=prod.ProductID
group by State,Product
-- If there is an increase in sales of 5%, calculate the increasedsales.
select sales*0.5 as increasedsales
from FACT_TABLE
-- Find the maximum profit along with the product ID and producttype.
select fact.ProductID,Product_Type,MAX(profit) from FACT_TABLE fact
join ProductTable prod on prod.ProductID=fact.ProductID
group by fact.ProductID,Product_Type

/*Create a stored procedure to fetch the result according to theproduct type
 from ProductTable.*/
 ALter procedure theproducttyperesult @producttype varchar(50)
 As 
 begin
select Product_Type from ProductTable
where Product_Type=@producttype
end

/* Write a query by creating a condition in which if the total expenses isless than
 60 then it is a profit or else loss.*/
 select Total_Expenses ,
 case
      when  Total_Expenses > 60 
	  then 'profit' 
	  else 'loss'
end as profit_loss
from FACT_TABLE




/* Give the total weekly sales value with the date and product IDdetails. Use
 roll-up to pull the data in hierarchical order.*/
 select Productid,DATE,SUM(sales) as weekly_sales,Datepart(week,Date)as weekofdate from FACT_TABLE
 group by Rollup( DATEPART(week,Date),DATE, Productid)



/* Apply union and intersection operator on the tables which consistof
 attribute area code.*/
--union
 select area_code from FACT_TABLE
 union
 select  Area_Code from LocationTable
--intersect
 select area_code from FACT_TABLE
 intersect
 select  Area_Code from LocationTable
 /*Create a user-defined function for the product table to fetch aparticular
 product type based upon the user�s preference.*/
 create function fetchproductbytype 
 (
      @producttype varchar(30)
 ) 
 RETURNS table 
 as
 Return
 (
        select product_type from ProductTable
		where Product_Type=@producttype
  );

 

-- Change the product type from coffee to tea where product ID is 1and undo it.
Begin transaction

update ProductTable
set Product_Type='tea'
where  ProductID='1'and product_type='coffee'

select * from ProductTable

Rollback Transaction;


-- Display the date, product ID and sales where total expenses are between 100 to 200.
select date, productID ,sales from FACT_TABLE
where Total_Expenses between 100 and 200


-- Delete the records in the Product Table for regulartype.
delete  from ProductTable
Where Type='regulartype'
-- Display the ASCII value of the fifth character from the columnProduct.
SELECT ASCII(SUBSTRING(PRODUCT,5,1) )AS ASCII_VALUE  FROM ProductTable 