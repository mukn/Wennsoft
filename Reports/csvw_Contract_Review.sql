/**    csvw_Contract_Review
      This is a view authored by Ariel Morgan. It gives us an estimate of 
      hours remaining on open contracts.

*/

--ALTER VIEW csvw_Contract_Review AS
SELECT
    RTRIM(b.CUSTNAME) AS CustomerName,
	TRIM(a.Contract_Number) AS Contract_number,

    -- Performance Metrics
    (SELECT SUM(Estimate_Hours) / 100 
     FROM dbo.SV00585 AS c
     WHERE c.CUSTNMBR = a.CUSTNMBR 
       AND c.ADRSCODE = a.ADRSCODE 
       AND c.Contract_Number = RTRIM(a.Contract_Number) 
       AND c.WSCONTSQ = a.WSCONTSQ) AS Estimated_Hours,

    (SELECT SUM(CASE WHEN g.RMDTYPAL = 7 THEN -g.Billable_All ELSE g.Billable_All END)
     FROM dbo.SV00564 AS g
     WHERE g.CUSTNMBR = a.CUSTNMBR 
       AND g.ADRSCODE = a.ADRSCODE 
       AND g.Contract_Number = RTRIM(a.Contract_Number) 
       AND g.WSCONTSQ = a.WSCONTSQ 
       AND g.CREATDDT <= GETDATE()) AS Invoiced_to_Date,

    (SELECT SUM(DOCAMNT)
     FROM dbo.SV00509 AS h
     WHERE h.CUSTNMBR = a.CUSTNMBR 
       AND h.ADRSCODE = a.ADRSCODE 
       AND h.Contract_Number = RTRIM(a.Contract_Number) 
       AND h.WSCONTSQ = a.WSCONTSQ 
       AND h.POSTDATE <= GETDATE()) AS Revenue_to_Date,

    (SELECT COUNT(Service_Call_ID)
     FROM dbo.SV00300 AS s
     WHERE s.CUSTNMBR = a.CUSTNMBR 
       AND s.ADRSCODE = a.ADRSCODE 
       AND s.Contract_Number = RTRIM(a.Contract_Number) 
       AND s.WSCONTSQ = a.WSCONTSQ) AS Service_Calls_to_Date,

    (SELECT COUNT(Service_Call_ID)
     FROM dbo.SV00300 AS s
     WHERE s.CUSTNMBR = a.CUSTNMBR 
       AND s.ADRSCODE = a.ADRSCODE 
       AND s.Contract_Number = RTRIM(a.Contract_Number) 
       AND s.WSCONTSQ = a.WSCONTSQ 
       AND s.Status_of_Call = 'OPEN') AS Open_Service_Calls,

    (SELECT COUNT(Service_Call_ID)
     FROM dbo.SV00300 AS s
     WHERE s.CUSTNMBR = a.CUSTNMBR 
       AND s.ADRSCODE = a.ADRSCODE 
       AND s.Contract_Number = RTRIM(a.Contract_Number) 
       AND s.WSCONTSQ = a.WSCONTSQ 
       AND s.Status_of_Call <> 'OPEN') AS Complete_Service_Calls,

    (SELECT COUNT(DISTINCT CONCAT(CUSTNMBR, ADRSCODE, Contract_Number, WSCONTSQ, Schedule_Date) )
     FROM dbo.SV00585 AS c
     WHERE c.CUSTNMBR = a.CUSTNMBR 
       AND c.ADRSCODE = a.ADRSCODE 
       AND c.Contract_Number = RTRIM(a.Contract_Number) 
       AND c.WSCONTSQ = a.WSCONTSQ 
       AND c.Schedule_Date > GETDATE()) AS Calls_Remaining,

    -- Appointment Metrics
    (SELECT COUNT(DISTINCT CONCAT(appt.Appointment, appt.Service_Call_ID) )
     FROM dbo.SV00301 AS appt
     INNER JOIN dbo.SV00300 AS s ON appt.Service_Call_ID = s.Service_Call_ID
     WHERE s.CUSTNMBR = a.CUSTNMBR 
       AND s.ADRSCODE = a.ADRSCODE 
       AND s.Contract_Number = RTRIM(a.Contract_Number) 
       AND s.WSCONTSQ = a.WSCONTSQ) AS Appointments_to_Date,

    (SELECT COUNT(DISTINCT CONCAT(appt.Appointment, appt.Service_Call_ID) )
     FROM dbo.SV00301 AS appt
     INNER JOIN dbo.SV00300 AS s ON appt.Service_Call_ID = s.Service_Call_ID
     WHERE s.CUSTNMBR = a.CUSTNMBR 
       AND s.ADRSCODE = a.ADRSCODE 
       AND s.Contract_Number = RTRIM(a.Contract_Number) 
       AND s.WSCONTSQ = a.WSCONTSQ 
       AND appt.Appointment_Status <> 'Complete') AS Open_Appointments,

    (SELECT COUNT(DISTINCT CONCAT(appt.Appointment, appt.Service_Call_ID) )
     FROM dbo.SV00301 AS appt
     INNER JOIN dbo.SV00300 AS s ON appt.Service_Call_ID = s.Service_Call_ID
     WHERE s.CUSTNMBR = a.CUSTNMBR 
       AND s.ADRSCODE = a.ADRSCODE 
       AND s.Contract_Number = RTRIM(a.Contract_Number) 
       AND s.WSCONTSQ = a.WSCONTSQ 
       AND appt.Appointment_Status = 'Complete') AS Complete_Appointments,

    -- Equipment Summary
    (SELECT COUNT(DISTINCT CONCAT(CUSTNMBR, ADRSCODE, Contract_Number, WSCONTSQ, Equipment_ID) )
     FROM dbo.SV00403 AS e
     WHERE e.CUSTNMBR = a.CUSTNMBR 
       AND e.ADRSCODE = a.ADRSCODE
       AND e.Contract_Number = RTRIM(a.Contract_Number) 
       AND e.WSCONTSQ = a.WSCONTSQ 
       AND e.Equipment_ID NOT LIKE '%HOUR%') AS Contract_Equipment_Count,

    (SELECT STRING_AGG(CONCAT(Equipment_Count, '-', RTRIM(Equipment_Type)) , ', ')
     FROM (
         SELECT RTRIM(eq.Equipment_Type) AS Equipment_Type, COUNT(*) AS Equipment_Count
         FROM dbo.SV00403 AS ceq
         LEFT OUTER JOIN dbo.SV00400 AS eq 
         ON eq.CUSTNMBR = ceq.CUSTNMBR 
         AND eq.ADRSCODE = ceq.ADRSCODE 
         AND eq.Equipment_ID = ceq.Equipment_ID
         WHERE ceq.CUSTNMBR = a.CUSTNMBR 
           AND ceq.ADRSCODE = a.ADRSCODE 
           AND ceq.Contract_Number = RTRIM(a.Contract_Number) 
           AND ceq.WSCONTSQ = a.WSCONTSQ 
           AND ceq.Equipment_ID NOT LIKE '%HOUR%'
         GROUP BY RTRIM(eq.Equipment_Type)
     ) AS type_counts) AS Equipment_Types,

    -- Pull Through Revenue and Cost
    (SELECT SUM(CASE WHEN pt.Invoice_Type = 7 THEN -pt.Billable_All ELSE pt.Billable_All END)
     FROM dbo.SV00701 AS pt
     WHERE pt.CUSTNMBR = a.CUSTNMBR 
       AND pt.ADRSCODE = a.ADRSCODE 
       AND pt.Contract_Number = '') AS Pull_Through_Revenue,

    (SELECT SUM(Cost_All)
     FROM dbo.SV00701 AS pt
     WHERE pt.CUSTNMBR = a.CUSTNMBR 
       AND pt.ADRSCODE = a.ADRSCODE 
       AND pt.Contract_Number = '') AS Pull_Through_Cost,

    -- Explicitly listed fields from SV00500
	a.Cancel_Box
    --a.CUSTNMBR, a.ADRSCODE, a.Contract_Number, a.WSCONTSQ, a.Wennsoft_Affiliate, a.Wennsoft_Region, a.Wennsoft_Branch, a.USERID, a.Technician_ID, a.Technician_Team, a.Technician,
    --a.CPRCSTNM, a.Corporate_Contract_Nbr, a.WSMSTRCONTSQ, a.Corporate_Invoice_Number, a.Contract_Amount, a.WSContractRenewalValue, a.Bill_Freq, a.Wennsoft_Close_Date, a.Amount_Billed,
    --a.SLPRSNID, a.TAXSCHID, a.Annual_Contract_Value, a.Revenue_Rec_Method_ID, a.Invoice_Style, a.Multiyear_Contract_Flag, a.Contract_Start_Date, a.Contract_Expiration_Date,
    --a.Forecast_Original_Equip, a.Forecast_Original_Labor, a.Fore_Orig_Material, a.Forecast_Original_Other, a.Forecast_Original_Subs, a.Forecast_Orig_Labor_1, a.Forecast_Orig_Labor1_Hrs,
    --a.Forecast_Orig_Labor_2, a.Fore_Orig_Labor_2_Hrs, a.Forecast_Orig_Labor_3, a.Forecast_Orig_Labor3_Hrs, a.Forecast_Orig_Labor_4, a.Forecast_Orig_Labor4_Hrs, a.Forecast_Orig_Labor_5,
    --a.Forecast_Orig_Labor5_Hrs, a.Forecast_Orig_Tot_Labor, a.Fore_Orig_Tot_Lbr_Hrs, a.Actual_Equipment, a.Actual_Labor, a.Actual_Material, a.Actual_Subs, a.Actual_Other,
    --a.Total_Cost_Tax, a.Actual_Total_Cost, a.Actual_Hours, a.Actual_Labor_1, a.Actual_Labor_1_Hours, a.Actual_Labor_2, a.Actual_Labor_2_Hours, a.Actual_Labor_3, a.Actual_Labor_3_Hours,
    --a.Actual_Labor_4, a.Actual_Labor_4_Hours, a.Actual_Labor_5, a.Actual_Labor_5_Hours, a.Actual_Total_Labor, a.Actual_Total_Labor_Hrs, a.Actual_Contract_Earned, a.Actual_Gross_Profit,
    --a.Actua_Revenue_Recognized, a.Actual_Billed, a.Estimate_Equipment, a.Estimate_Labor, a.Estimate_Material, a.Estimate_Subs, a.Estimate_Other, a.Estimate_Total_Cost, a.Estimate_Hours,
    --a.Estimate_Labor_1, a.Estimate_Labor_1_Hours, a.Estimate_Labor_2, a.Estimate_Labor_2_Hours, a.Estimate_Labor_3, a.Estimate_Labor_3_Hours, a.Estimate_Labor_4, a.Estimate_Labor_4_Hours,
    --a.Estimate_Labor_5, a.Estimate_Labor_5_Hours, a.Estimate_Total_Labor, a.Estimate_Total_Labor_Hrs, a.Forecast_Labor, a.Forecast_Equipment, a.Forecast_Material, a.Forecast_Subs,
    --a.Forecast_Other, a.Forecast_Total_Cost, a.Forecast_Hours, a.Forecast_Labor_1, a.Forecast_Labor_1_Hours, a.Forecast_Labor_2, a.Forecast_Labor_2_Hours, a.Forecast_Labor_3,
    --a.Forecast_Labor_3_Hours, a.Forecast_Labor_4, a.Forecast_Labor_4_Hours, a.Forecast_Labor_5, a.Forecast_Labor_5_Hours, a.Forecast_Total_Labor, a.Forecast_Total_Labor_Hrs,
    --a.Task_Est_Rollup_Group, a.Contract_Description, a.User_Define_1a, a.User_Define_2a, a.User_Define_3a, a.User_Define_4a, a.Service_User_Define_3, a.Service_User_Define_5,
    --a.Service_User_Define_6, a.Service_User_Define_9, a.Service_User_Define_10, a.Service_User_Define_18, a.Service_User_Define_19, a.Service_User_Define_22, a.Service_User_Define_23,
    --a.Service_User_Define_24, a.Contract_Billing_Date, a.Contract_Service_Date, a.WS_Closed, a.Auto_Bill, a.Purchase_Order, a.LSTFSCDY, a.Divisions, a.PY_Labor, a.PY_Material,
    --a.PY_Equipment, a.PY_Subcontractor, a.PY_Other, a.PY_Total_Cost, a.PY_Billed, a.PY_Contract_Earned, a.PY_Gross_Profit, a.PY_Revenue_Recognized, a.PY_Hours, a.PY_Labor_1,
    --a.PY_Labor_1_Hours, a.PY_Labor_2, a.PY_Labor_2_Hours, a.PY_Labor_3, a.PY_Labor_3_Hours, a.PY_Labor_4, a.PY_Labor_4_Hours, a.PY_Labor_5, a.PY_Labor_5_Hours, a.PY_Total_Labor,
    --a.PY_Total_Labor_Hrs, a.YTD_Labor, a.YTD_Material, a.YTD_Equipment, a.YTD_Subcontractor, a.YTD_Other, a.YTD_Total_Cost, a.YTD_Billed, a.YTD_Contract_Earned, a.YTD_Gross_Profit,
    --a.YTD_Revenue_Recognized, a.YTDHOURS, a.YTD_Labor_1, a.YTD_Labor_1_Hours, a.YTD_Labor_2, a.YTD_Labor_2_Hours, a.YTD_Labor_3, a.YTD_Labor_3_Hours, a.YTD_Labor_4, a.YTD_Labor_4_Hours,
    --a.YTD_Labor_5, a.YTD_Labor_5_Hours, a.YTD_Total_Labor, a.YTD_Total_Labor_Hrs, a.TTD_Material, a.TTD_Equipment, a.TTD_Subcontractor, a.TTD_Other, a.TTD_Labor, a.TTD_Billed,
    --a.TTD_Contract_Earned, a.TTD_Gross_Profit, a.TTD_Revenue_Recognized, a.TTD_Total_Cost, a.TTD_Hours, a.TTD_Labor1, a.TTD_Labor1_Hours, a.TTD_Labor2, a.TTD_Labor2_Hours,
    --a.TTD_Labor3, a.TTD_Labor3_Hours, a.TTD_Labor4, a.TTD_Labor4_Hours, a.TTD_Labor5, a.TTD_Labor5_Hours, a.TTD_Total_Labor, a.TTD_Total_Labor_Hrs, a.Auto_Date, a.Cancel_Box,
    --a.HOLD, a.Excess_Cost, a.Unbilled_Receivable, a.Contract_NTE_Units, a.Contract_Actual_Units, a.Equipment_ID, a.Warranty_Checkbox, a.CREATDDT, a.CRUSRID, a.MODIFDT,
    --a.Modified_Time, a.MDFUSRID, a.Time_Zone, a.SV_Language_ID, a.Base_Currency_ID, a.Billing_Currency_ID, a.Local_Currency_ID, a.Hold_Reason_ID, a.Billing_Equipment,
    --a.Billing_Material, a.Billing_Labor, a.Billing_Subs, a.Billing_Other, a.Billing_Percentage_Equip, a.Billing_Pct_Material, a.Billing_Percentage_Labor, a.Billing_Percentage_Subs,
    --a.Billing_Percentage_Other, a.Current_Billing_Amount, a.Escalation_Frequency, a.Escalation_Date, a.Escal_Notify_Days, a.Next_Escalation_Date, a.Begin_Date_CY,
    --a.Anniversary_Date, a.Evergreen_Contract_Flag, a.Contract_Units_Measure, a.Last_Review_Date, a.Last_Review_User_ID, a.Contract_Internal_Name, a.Auto_Escalation_Flag,
    --a.Bill_Customer_Number, a.Bill_Address_Code, a.Leave_Open_Flag, a.WSReserved_CB1, a.WSReserved_CB2, a.WSReserved_CB3, a.WSReserved_CB4, a.WSReserved_CB5, a.WSReserved_CB6,
    --a.WSReserved_CB7, a.WSReserved_CB8, a.WSReserved_STR1, a.WSReserved_STR2, a.DEX_ROW_ID

FROM dbo.SV00500 AS a
LEFT OUTER JOIN dbo.RM00101 AS b ON a.CUSTNMBR = b.CUSTNMBR
