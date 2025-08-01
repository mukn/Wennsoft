/**      Z_AddTechnician

    Use this to add users to the technician team list. Update the variables below to add
    the user to the list, then the team lead and dispatcher are added based on the team
    identifier.

    Any mistakes can be undone with the last command which is otherwise commented out. Be
    sure to identify the correct EmployeeID before running that.

  */

USE NAC;
GO

-- Declare variables
DECLARE 
	@EmployeeID INT,
	@TechnicianID VARCHAR(100),
	@EmployeeName VARCHAR(100),
	@EmployeeEmail VARCHAR(100),
	@Team VARCHAR(100);

-- Set variable values
SET @EmployeeID = 00;								-- Pull from Paylocity
SET @TechnicianID = 'CKent';						-- First initial & last name, limit to 10 characters
SET @EmployeeName = 'Kent, Clark';					-- Last name, first name
SET @EmployeeEmail = 'Clark.Kent@nacgroup.com';		-- Email address
SET @Team = 'Justice League';						-- Enter Team 1, Team 2, Team 3, Team 4, or Special Projects

-- Add the row with defined values
INSERT INTO NAC.dbo.Z_Technician_team_assignments (EmployeeID, TechnicianID, EmployeeName, EmployeeEmail, Team)
VALUES (@EmployeeID, @TechnicianID, @EmployeeName, @EmployeeEmail, @Team);

-- Assign relevant team resources
UPDATE NAC.dbo.Z_Technician_team_assignments
SET TeamLeadName = 'Charlie Grabner', TeamLeadEmail = 'charlie.grabner@nacgroup.com', DispatcherName = 'Danielle Simmons', DispatcherEmail = 'danielle.simmons@nacgroup.com'
WHERE Team = 'Team 1';
UPDATE NAC.dbo.Z_Technician_team_assignments
SET TeamLeadName = 'Miguel Melgares', TeamLeadEmail = 'miguel.melgares@nacgroup.com', DispatcherName = 'Muhammed Jobe', DispatcherEmail = 'muhammed.jobe@nacgroup.com'
WHERE Team = 'Team 2';
UPDATE NAC.dbo.Z_Technician_team_assignments
SET TeamLeadName = 'TJ Cornell', TeamLeadEmail = 'tj.cornell@nacgroup.com', DispatcherName = 'Lino Ramirez', DispatcherEmail = 'joselino.ramirez@nacgroup.com'
WHERE Team = 'Team 3';
UPDATE NAC.dbo.Z_Technician_team_assignments
SET TeamLeadName = 'Greg Cunningham', TeamLeadEmail = 'greg.cunningham@nacgroup.com', DispatcherName = 'Nancy Carrero', DispatcherEmail = 'nancy.carrero@nacgroup.com'
WHERE Team = 'Team 4';
UPDATE Z_Technician_team_assignments
SET DispatcherName = 'Shannon Mclean', DispatcherEmail = 'shannon.mclean@nacgroup.com'
WHERE Team = 'Special Projects';

-- Quality control
SELECT * FROM Z_Technician_team_assignments WHERE EmployeeID = @EmployeeID

-- Undo command
--DELETE FROM NAC.dbo.Z_Technician_team_assignments WHERE EmployeeID = ''
