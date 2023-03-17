USE [TSQL2012]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Task1]
(
	
@DateForm datetime,
@DateTo datetime
)
AS
BEGIN

	SET NOCOUNT ON;


	SELECT Sales.Orders.OrderId as IdNarduzbe, Sales.Orders.orderdate as DatumNarudzbe,
	sum(qty * unitprice) as IznosNarudzbe,
	(SUM(qty * unitprice) / (SELECT SUM(qty * unitprice) FROM Sales.OrderDetails
	WHERE Sales.OrderDetails.orderid IN (SELECT Sales.Orders.orderid
	 FROM Sales.Orders where Sales.Orders.orderdate BETWEEN @DateForm AND @DateTo)
	) * 100)  as UdioProcenti from Sales.Orders
	LEFT OUTER JOIN Sales.OrderDetails on Sales.Orders.orderid = Sales.OrderDetails.orderid
	WHERE Sales.Orders.orderdate BETWEEN @DateForm AND @DateTo
	Group By Sales.Orders.orderid, Sales.Orders.orderdate
	order by IznosNarudzbe desc
	
END

GO


