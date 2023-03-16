USE [TSQL2012]
GO

/****** Object:  StoredProcedure [dbo].[Task1]    Script Date: 3/16/2023 9:52:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[Task1]
(
	-- Add the parameters for the function here
@DateForm datetime,
@DateTo datetime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
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


