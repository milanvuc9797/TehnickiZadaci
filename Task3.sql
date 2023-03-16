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
CREATE procedure [dbo].[Task3]
(
	-- Add the parameters for the function here
@MinNumberOfOrders int,
@TopNCustomers int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP(@TopNCustomers)
	CustId as IdKupca, MAX(orderdate) as PoslednjaNarudzba,
	 SUM(qty * unitprice) as UkupnoNaruceno, sa.Broj as BrojNarudzbi from Sales.Orders as Ord1
	 left outer join Sales.OrderDetails on Ord1.orderid = sales.OrderDetails.orderid
	 cross apply (SELECT COUNT (*) as Broj FROM Sales.Orders as Ord where Ord.custid = Ord1.custid) as sa
	 WHERE sa.Broj >= @MinNumberOfOrders
	group by custid, sa.Broj

	
END

GO


