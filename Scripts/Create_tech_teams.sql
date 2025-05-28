SELECT Technician_Long_Name,Technician_ID,EMPLOYID,Technician_Team FROM SV00115
  WHERE Technician_Team = 'TEAM 1' OR Technician_Team = 'TEAM 2' OR Technician_Team = 'TEAM 3' OR Technician_Team = 'TEAM 4'
  ORDER BY Technician_Long_Name

DROP TABLE Z_Technician_team_assignments;

CREATE TABLE Z_Technician_team_assignments (
	EmployeeID int,
	TechnicianID varchar(100),
	EmployeeName varchar(100),
	EmployeeEmail varchar(100),
	Team varchar(100),
	TeamLeadName varchar(100),
	TeamLeadEmail varchar(100),
	DispatcherName varchar(100),
	DispatcherEmail varchar(100)
);


INSERT INTO Z_Technician_team_assignments (EmployeeID, TechnicianID, EmployeeName, EmployeeEmail, Team)
VALUES ('303', 'CGRABNER', 'Charles Grabner', 'charlie.grabner@nacgroup.com', 'Team 1'),
('297', 'SBARNES', 'Sean Barnes', 'sean.barnes@nacgroup.com', 'Team 1'),
('439', 'JASOBARBEE', 'Jason Barbee', 'jason.barbee@nacgroup.com', 'Team 1'),
('557', 'MGOUKER', 'Michael Gouker', 'michael.gouker@nacgroup.com', 'Team 1'),
('516', 'JROCK', 'Julian Rock', 'julian.rock@nacgroup.com', 'Team 1'),
('1665', 'NDAVIDSON', 'Noah Davidson', 'noah.davidson@nacgroup.com', 'Team 1'),
('1662', 'MPADDY', 'Matthew Paddy', 'matt.paddy@nacgroup.com', 'Team 1'),
('1664', 'CBENTON', 'Chad Benton', 'chad.benton@nacgroup.com', 'Team 1'),
('301', 'ZREHMAN', 'Zaheer Rehman', 'zaheer.rehman@nacgroup.com', 'Team 1'),
('725', 'SELISIO', 'Sam Elisio', 'sam.elisio@nacgroup.com', 'Team 1'),
('692', 'ZBIBLE', 'Zach Bible', '', 'Team 1'),
('1661', 'AMEYER', 'Andrew Meyer', 'andrew.meyer@nacgroup.com', 'Team 1'),
('1663', 'TFISHER', 'Taylor Viar-Fisher', 'taylor.fisher-viar@nacgroup.com', 'Team 1'),
('510', 'MMELGARES', 'Miguel Melgares', 'miguel.melgares@nacgroup.com', 'Team 2'),
('527', 'JCREEGAN', 'Joe Creegan', 'joe.creegan@nacgroup.com', 'Team 2'),
('1635', 'ALAPLANTE', 'Arden LaPlante', 'arden.laplante@nacgroup.com', 'Team 2'),
('284', 'JYOUNG', 'Jake Young', 'jake.young@nacgroup.com', 'Team 2'),
('526', 'LMOSLEY', 'Kirk Mosley', 'kirk.mosley@nacgroup.com', 'Team 2'),
('187', 'MSTROJNI', 'Michael Strojni', 'michael.strojni@nacgroup.com', 'Team 2'),
('496', 'SBUTLAND', 'Shawn Butland', 'shawn.butland@nacgroup.com', 'Team 2'),
('553', 'SALLNUTT', 'Stacee Allnutt', 'stacee.allnutt@nacgroup.com', 'Team 2'),
('579', 'ZBARBEE', 'Zach Barbee', 'zachary.barbee@nacgroup.com', 'Team 2'),
('2326', 'CLEAVELL', 'Casey Leavell', '', 'Team 2'),
('644', 'DHARVEY', 'Darrion Harvey', 'darrion.harvey@nacgroup.com', 'Team 2'),
('2137', 'TIENC', 'Tien Choney', '', 'Team 2'),
('2673', 'STEBUTLAND', 'Steve Butland', '', 'Team 2'),
('252', 'TJCORNELL', 'TJ Cornell', 'tj.cornell@nacgroup.com', 'Team 3'),
('591', 'HMAUS', 'Willie Maus', 'hewitt.maus@nacgroup.com', 'Team 3'),
('733', 'WHINKSTON', 'Bill Hinkston', 'bill.hinkston@nacgroup.com', 'Team 3'),
('273', 'BRIANEVANS', 'Brian Evans', 'brian.evans@nacgroup.com', 'Team 3'),
('123', 'BRATICA', 'Brian Ratica', 'brian.ratica@nacgroup.com', 'Team 3'),
('307', 'CCORNELL', 'Clint Cornell', 'clint.cornell@nacgroup.com', 'Team 3'),
('47', 'DSONNEFELD', 'Dale Sonnefeld', 'dale.sonnefeld@nacgroup.com', 'Team 3'),
('581', 'GSOLAN', 'Greg Solan', 'greg.solan@nacgroup.com', 'Team 3'),
('276', 'JJUSTICE', 'John Justice', 'john.justice@nacgroup.com', 'Team 3'),
('673', 'CRUIZ', 'CJ Ruiz', 'carl.ruiz@nacgroup.com', 'Team 3'),
('1748', 'BBELL', 'Braden Bell', '', 'Team 3'),
('724', 'JJACKSON', 'John Jackson', 'john.jackson@nacgroup.com', 'Team 3'),
('668', 'NSMITH', 'Nick Smith', 'nick.smith@nacgroup.com', 'Team 3'),
('2540', 'RGEIST', 'Russell Geist', '', 'Team 3'),
('2675', 'ZMANLY', 'Zach Manly', '', 'Team 3'),
('138', 'CUNNINGHAM', 'Greg Cunningham', 'greg.cunningham@nacgroup.com', 'Team 4'),
('720', 'BBARNES', 'Bryan Barnes', 'bryan.barnes@nacgroup.com', 'Team 4'),
('444', 'BPRATHER', 'Brandon Prather', 'brandon.prather@nacgroup.com', 'Team 4'),
('1937', 'JPOOLE', 'Jude Poole', 'jude.poole@nacgroup.com', 'Team 4'),
('677', 'LAPPEL', 'Lucas Appel', 'lucas.appel@nacgroup.com', 'Team 4'),
('668', 'NRUSH', 'Nick Rush', 'nick.rush@nacgroup.com', 'Team 4'),
('660', 'SMEINHARDT', 'Shane Meinhardt', 'shane.meinhardt@nacgroup.com', 'Team 4'),
('679', 'RLEONARD', 'Rick Leonard', 'rick.leonard@nacgroup.com', 'Team 4'),
('568', 'TMURDOCK', 'Terry Murdock', 'terry.murdock@nacgroup.com', 'Team 4'),
('21', 'JVOLPE', 'Jim Volpe', 'jim.volpe@nacgroup.com', 'Team 4'),
('1597', 'JALEJANDRO', 'Jonathan Alejandro', 'jonathon.alejandro@nacgroup.com', 'Team 4'),
('2096', 'JWILLIS', 'Jayden Willis', '', 'Team 4'),
('493', 'JUSTBARBEE', 'Justin Barbee', 'justin.barbee@nacgroup.com', 'Team 4'),
('648', 'MGEYER', 'Mike Geyer', 'michael.geyer@nacgroup.com', 'Team 4'),
('632', 'ZTAYLOR', 'Zach Taylor', 'zachary.taylor@nacgroup.com', 'Team 4');



UPDATE Z_Technician_team_assignments
SET TeamLeadName = 'Charlie Grabner', TeamLeadEmail = 'charlie.grabner@nacgroup.com', DispatcherName = 'Danielle Simmons', DispatcherEmail = 'danielle.simmons@nacgroup.com'
WHERE Team = 'Team 1';
UPDATE Z_Technician_team_assignments
SET TeamLeadName = 'Miguel Melgares', TeamLeadEmail = 'miguel.melgares@nacgroup.com', DispatcherName = 'Muhammed Jobe', DispatcherEmail = 'muhammed.jobe@nacgroup.com'
WHERE Team = 'Team 2';
UPDATE Z_Technician_team_assignments
SET TeamLeadName = 'TJ Cornell', TeamLeadEmail = 'tj.cornell@nacgroup.com', DispatcherName = 'Lino Ramirez', DispatcherEmail = 'joselino.ramirez@nacgroup.com'
WHERE Team = 'Team 3';
UPDATE Z_Technician_team_assignments
SET TeamLeadName = 'Greg Cunningham', TeamLeadEmail = 'greg.cunningham@nacgroup.com', DispatcherName = 'Nancy Carrero', DispatcherEmail = 'nancy.carrero@nacgroup.com'
WHERE Team = 'Team 4';


SELECT * FROM Z_Technician_team_assignments ORDER BY EmployeeName;
