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
VALUES 
	('1597','JALEJANDRO','Alejandro, Jonathon','jonathon.alejandro@nacgroup.com','Team 1'),
	('553','Sallnutt','Allnutt, Stacee','stacee.allnutt@nacgroup.com','Team 3'),
	('677','LAPPEL','Appel, Lucas','lucas.appel@nacgroup.com','Team 1'),
	('439','JasoBarbee','Barbee, Jason','jason.barbee@nacgroup.com','Team 4'),
	('493','JUSTBARBEE','Barbee, Justin','justin.barbee@nacgroup.com','Team 1'),
	('579','Zbarbee','Barbee, Zach','zachary.barbee@nacgroup.com','Team 3'),
	('720','Bbarnes'',''Barnes'','' Bryan','bryan.barnes@nacgroup.com','Team 1'),
	('297','Sbarnes','Barnes, Sean','sbarnes@nacgroup.com','Team 4'),
	('1748','Bbell','Bell, Braden','','Team 2'),
	('1664','Cbenton','Benton, Chad','chad.benton@nacgroup.com','Team 4'),
	('692','Zbible','Bible, Zach','','Team 4'),
	('496','Sbutland','Butland, Shawn','sbutland@nacgroup.com','Team 3'),
	('2673','SteButland','Butland, Steve','','Team 2'),
	('2137','TIENC','Coney, Tien','','Team 3'),
	('307','Ccornell','Cornell, Clint','clint.cornell@nacgroup.com','Team 2'),
	('252','TJCornell','Cornell, TJ','tjcornell@nacgroup.com','Team 2'),
	('527','Jcreegan','Creegan, Joe','jcreegan@nacgroup.com','Team 3'),
	('138','Cunningham','Cunningham, Greg','gcunningham@nacgroup.com','Team 1'),
	('1665','Ndavidson','Davidson, Noah','noah.davidson@nacgroup.com','Team 4'),
	('725','Selisio','Elisio, Sam','','Team 4'),
	('273','BrianEvans','Evans, Brian','bevans@nacgroup.com','Team 2'),
	('1663','Tfisher','Fisher-Viar, Taylor','taylor.fisher-viar@nacgroup.com','Team 4'),
	('2540','Rgeist','Geist, Russell','','Team 2'),
	('648','Mgeyer','Geyer, Michael','michael.geyer@nacgroup.com','Team 1'),
	('557','Mgouker','Gouker, Mike','michael.gouker@nacgroup.com','Team 4'),
	('303','Cgrabner','Grabner, Charles','cgrabner@nacgroup.com','Team 4'),
	('644','Dharvey','Harvey, Darrion','','Team 3'),
	('733','Whinkston','Hinkston, Bill','bill.hinkston@nacgroup.com','Team 2'),
	('724','Jjackson','Jackson, John','John.Jackson@nacgroup.com','Team 2'),
	('276','Jjustice','Justice, John','jjustice@nacgroup.com','Team 2'),
	('1635','ALaPlante','LaPlante, Arden','arden.laplante@nacgroup.com','Team 3'),
	('2326','Cleavell','Leavell, Casey','','Team 3'),
	('679','Rleonard','Leonard, Rick','rick.leonard@nacgroup.com','Team 1'),
	('591','Hmaus','Maus, Willie','','Team 3'),
	('2675','Zmanly','Manly, Zach','','Team 3'),
	('660','Smeinhardt','Meinhardt, Shane','shane.meinhardt@nacgroup.com','Team 1'),
	('510','Mmelgares','Melgares, Miguel','miguel.melgares@nacgroup.com','Team 3'),
	('1661','Ameyer','Meyer, Andrew','andrew.meyer@nacgroup.com','Team 4'),
	('526','Lmosley','Mosley, Kirk','kirk.mosley@nacgroup.com','Team 3'),
	('568','Tmurdock','Murdock, Terry','terry.murdock@nacgroup.com','Team 1'),
	('1662','Mpaddy','Paddy, Matthew','matthew.paddy@nacgroup.com','Team 4'),
	('1937','Jpoole','Poole, Jude','jude.poole@nacgroup.com','Team 1'),
	('444','Bprather','Prather, Brandon','brandon.prather@nacgroup.com','Team 1'),
	('123','Bratica','Ratica, Brian','brian.ratica@nacgroup.com','Team 2'),
	('301','Zrehman','Rehman, Zaheer','zrehman@nacgroup.com','Team 4'),
	('516','Jrock','Rock, Julian','julian.rock@nacgroup.com','Team 4'),
	('673','Cruiz','Ruiz, Carl','carl.ruiz@nacgroup.com','Team 2'),
	('668','Nrush','Rush, Nick','nick.rush@nacgroup.com','Team 1'),
	('668','Nsmith','Smith, Nick','','Team 2'),
	('581','Gsolan','Solan, Greg','greg.solan@nacgroup.com','Team 2'),
	('47','Dsonnefeld','Sonnefeld, Dale','dsonnefeld@nacgroup.com','Team 2'),
	('187','Mstrojni','Strojni, Michael','mstrojni@nacgroup.com','Team 3'),
	('632','Ztaylor','Taylor, Zachary','zachary.taylor@nacgroup.com','Team 1'),
	('21','Jvolpe','Volpe, Jim','jvolpe@nacgroup.com','Team 1'),
	('2096','JWILLIS','Willis, Jaden','','Team 1'),
	('284','Jyoung','Young, Jacob','jyoung@nacgroup.com','Team 3');



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
