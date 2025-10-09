/** Service contracts with cancellation
    This is a list of all service contracts. Duplicates exist where contracts are renewed.
    Wennsoft does not create new contract objects. Instead it reuses the existing contract
    number and updates the date fields.

  */
-- Active Contracts
-- ALTER VIEW Z_PBI_service_contracts_with_cancellation AS
SELECT 
    'Active' AS Status,
    c.CUSTNMBR AS Customer_Code,
    c.ADRSCODE AS Location_code,
    -- c.Location_name (commented out)
    c.Contract_Number AS Contract_number,
    c.Contract_Description AS Contract_description,
    c.Contract_Amount,
    c.Annual_Contract_Value,
    c.Multiyear_Contract_Flag,
    c.Contract_Start_Date AS Begin_date,
    c.Contract_Expiration_Date AS End_date,
    c.Service_User_Define_10 AS Salesforce_date,
    c.SLPRSNID AS Sales_rep,
    CASE 
        WHEN c.Service_User_Define_9 > '1990-01-01' THEN c.Service_User_Define_9 
        ELSE NULL 
    END AS Cancellation_date,
    c.User_Define_3a AS Cancellation_reason,
    -- c.Bill_Freq AS Billing_frequency_code (commented out)
    c.Contract_Internal_Name,
    b.Number_Of_Billings AS Number_Of_Billings
FROM dbo.SV00500 c
LEFT JOIN (
    SELECT 
        Contract_Number, 
        COUNT(Contract_Number) AS Number_Of_Billings
    FROM SV00510
    GROUP BY Contract_Number
) AS b ON c.Contract_Number = b.Contract_Number

UNION

-- Inactive Contracts
SELECT 
    'Inactive' AS Status,
    c.CUSTNMBR AS Customer_Code,
    c.ADRSCODE AS Location_code,
    -- c.Location_name (commented out)
    c.Contract_Number AS Contract_number,
    c.Contract_Description AS Contract_description,
    c.Contract_Amount,
    c.Annual_Contract_Value,
    c.Multiyear_Contract_Flag,
    c.Contract_Start_Date AS Begin_date,
    c.Contract_Expiration_Date AS End_date,
    c.Service_User_Define_10 AS Salesforce_date,
    c.SLPRSNID AS Sales_rep,
    CASE 
        WHEN c.Service_User_Define_9 > '1990-01-01' THEN c.Service_User_Define_9 
        ELSE NULL 
    END AS Cancellation_date,
    c.User_Define_3a AS Cancellation_reason,
    -- c.Bill_Freq AS Billing_frequency_code (commented out)
    c.Contract_Internal_Name,
    b.Number_Of_Billings AS Number_Of_Billings
FROM dbo.SV00501 c
LEFT JOIN (
    SELECT 
        Contract_Number, 
        COUNT(Contract_Number) AS Number_Of_Billings
    FROM SV00510
    GROUP BY Contract_Number
) AS b ON c.Contract_Number = b.Contract_Number;
