USE [NAC]
GO
/****** Object:  StoredProcedure [dbo].[Z_CreateCreditHoldRecord]    Script Date: 8/13/2024 11:21:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lunsford, Jeremy
-- Create date: 13 Aug 2024
-- Description:	This creates a record in the credit hold table
--				for later insertion to Salesforce.
-- =============================================
ALTER PROCEDURE [dbo].[Z_CreateCreditHoldRecord]
	-- Add the parameters for the stored procedure here
	@Customer_Code char(15),
	@Location_Code char(15),
	@Credit_Hold_Flag tinyint = 1,
	@Action_DateTime datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET @Action_DateTime = CURRENT_TIMESTAMP;
	SET NOCOUNT ON;

    -- Insert into credit hold table (Z_SV00200_Credit_Hold)
	INSERT INTO Z_SV00200_Credit_Hold
	VALUES (@Customer_Code, @Location_Code, @Credit_Hold_Flag, @Action_DateTime)
	
END
