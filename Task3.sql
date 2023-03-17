USE [TSQL2012]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[Task3]
(
	
@MinNumberOfOrders int,
@TopNCustomers int
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT TOP(@TopNCustomers)
	CustId as IdKupca, MAX(orderdate) as PoslednjaNarudzba,
	 SUM(qty * unitprice) as UkupnoNaruceno, sa.Broj as BrojNarudzbi from Sales.Orders as Ord1
	 left outer join Sales.OrderDetails on Ord1.orderid = sales.OrderDetails.orderid
	 cross apply (SELECT COUNT (*) as Broj FROM Sales.Orders as Ord where Ord.custid = Ord1.custid) as sa
	 WHERE sa.Broj >= @MinNumberOfOrders
	group by custid, sa.Broj

	
END

GO


