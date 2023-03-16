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
CREATE procedure [dbo].[Task2]
(
	-- Add the parameters for the function here
@DateForm datetime,
@DateTo datetime,
@TopNProducts int = 10
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
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


