USE [TSQL2012]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[Task2]
(

@DateForm datetime,
@DateTo datetime,
@TopNProducts int = 10
)
AS
BEGIN

	SET NOCOUNT ON;


	SELECT TOP(@TopNProducts)
	CategoryId as IdKategorijePro, productname as NazivProizvoda, Sales.OrderDetails.productid,
	SUM(qty * Sales.OrderDetails.unitprice) as UkupnaProdanoPro from Production.Products
	LEFT OUTER JOIN Sales.OrderDetails ON Production.Products.productid = Sales.OrderDetails.productid
	LEFT OUTER JOIN Sales.Orders on Sales.OrderDetails.orderid = Sales.Orders.orderid
	WHERE Sales.Orders.orderdate BETWEEN @DateForm AND @DateTo
	GROUP BY categoryid, productname, Sales.OrderDetails.productid
	ORDER BY UkupnaProdanoPro DESC
	
END

GO


