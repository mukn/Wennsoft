/* Z_Contacts
	
	A collection of contacts from Wennsoft.

*/
--ALTER VIEW Z_Contacts AS
SELECT
    l.Contact_ID AS Contact_code,
    TRIM(l.CUSTNMBR) AS Customer_code,
    TRIM(l.ADRSCODE) AS Location_code,
    TRIM(c.WS_Contact_Name) AS Contact_name,
    TRIM(c.E_Mail_Address) AS Contact_email,
    TRIM(c.ADDRESS1) AS Contact_address1,
    TRIM(c.ADDRESS2) AS Contact_address2,
    TRIM(c.CITY) AS Contact_city,
    TRIM(c.STATE) AS Contact_state,
    TRIM(c.Postal_Code) AS Contact_zip
FROM dbo.SV01100 AS c
LEFT OUTER JOIN dbo.SV00205 AS l
    ON c.Contact_ID = l.Contact_ID;
