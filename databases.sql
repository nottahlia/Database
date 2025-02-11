drop table Role cascade constraints; 
drop table Location cascade constraints; 
drop table Staff_Member cascade constraints; 
drop table Project cascade constraints; 
drop table Road cascade constraints; 
drop table Contract_Manager cascade constraints; 
drop table Contractor_Company cascade constraints; 
drop table Contract cascade constraints; 
drop table RoadProject cascade constraints;   

CREATE TABLE Role ( 
    Role_Name VARCHAR2(50) PRIMARY KEY, 
    Role_Description VARCHAR2 (100), 
    Date_Assigned DATE NOT NULL, 
    Date_Ended DATE NOT NULL 
); 

CREATE TABLE Location ( 
    Location_ID NUMBER(10) PRIMARY KEY, 
    Location_Name VARCHAR2(50),  
    Latitude NUMBER(10, 8), 
    Longitude NUMBER (11, 8), 
    Location_Description VARCHAR2(50), 
    Start_Location_ID NUMBER (8), 
    End_Location_ID NUMBER (8)
); 

CREATE TABLE Staff_Member ( 
    Employee_ID NUMBER(8) PRIMARY KEY, 
    First_Name VARCHAR2(50) NOT NULL, 
    Last_Name VARCHAR2(50) NOT NULL, 
    Employee_Employed DATE NOT NULL,  
    Date_of_Birth DATE NOT NULL, 
    Gender VARCHAR2 (6) NOT NULL, 
    Address VARCHAR2 (50) NOT NULL, 
    Phone_Number NUMBER (10) NOT NULL, 
    Email VARCHAR2 (50) NOT NULL, 
    Role_Name VARCHAR2(50), 
    CONSTRAINT fk_Role FOREIGN KEY (Role_Name) REFERENCES Role(Role_Name) 
); 

CREATE TABLE Road ( 
    Road_ID NUMBER (8) PRIMARY KEY, 
    Road_Name VARCHAR2 (50), 
    Road_Description VARCHAR2 (50), 
    Road_Category VARCHAR2 (50) NOT NULL, 
    Road_Length NUMBER (5,2) NOT NULL, 
    Start_Location_ID NUMBER (8), 
    End_Location_ID NUMBER (8), 
    CONSTRAINT fk_StartLocation FOREIGN KEY (Start_Location_ID) REFERENCES Location(Location_ID), 
    CONSTRAINT fk_EndLocation FOREIGN KEY (End_Location_ID) REFERENCES Location(Location_ID) 
); 

CREATE TABLE Project ( 
    Project_Code NUMBER (8) PRIMARY KEY, 
    Project_Name VARCHAR2 (50), 
    Project_Description VARCHAR2 (100), 
    Project_Started DATE, 
    Project_Completed DATE, 
    Road_ID NUMBER (8), 
    Employee_ID NUMBER (8), 
    CONSTRAINT fk_Road FOREIGN KEY (Road_ID) REFERENCES Road(Road_ID), 
    CONSTRAINT fk_Employee FOREIGN KEY (Employee_ID) REFERENCES Staff_Member(Employee_ID) 
); 

CREATE TABLE Contract_Manager ( 
    Manager_Contract_Number NUMBER(8) PRIMARY KEY, 
    Employee_ID NUMBER(8) NOT NULL, 
    Start_Date DATE NOT NULL, 
    End_Date DATE, 
    CONSTRAINT fk_Employee_ContractManager FOREIGN KEY (Employee_ID) REFERENCES Staff_Member(Employee_ID) 
); 

CREATE TABLE Contractor_Company ( 
    Contractor_ID NUMBER(8) PRIMARY KEY, 
    Contractor_Name VARCHAR2(50) NOT NULL,  
    Contractor_Address VARCHAR2(50) NOT NULL, 
    Preferred_Contact_Details VARCHAR2(50) NOT NULL,
    Employee_ID NUMBER(8) NOT NULL, 
    CONSTRAINT fk_Employee_ContractCompany FOREIGN KEY (Employee_ID) REFERENCES Staff_Member(Employee_ID) 
); 

CREATE TABLE Contract ( 
    Contract_Number NUMBER(8) PRIMARY KEY, 
    Contract_Name VARCHAR2(50), 
    Contract_Description VARCHAR2(100), 
    Estimated_Cost NUMBER(12,2), 
    Actual_Cost NUMBER(10,2), 
    Contract_Started DATE NOT NULL, 
    Contract_Ended DATE NOT NULL, 
    Contractor_ID NUMBER(8) NOT NULL,  
    Manager_Contract_Number NUMBER(8),  
    Project_Code NUMBER(8) NOT NULL,  
    CONSTRAINT fk_Contractor FOREIGN KEY (Contractor_ID) REFERENCES Contractor_Company(Contractor_ID), 
    CONSTRAINT fk_Manager FOREIGN KEY (Manager_Contract_Number) REFERENCES Contract_Manager(Manager_Contract_Number), 
    CONSTRAINT fk_Project FOREIGN KEY (Project_Code) REFERENCES Project(Project_Code) 
); 

  

CREATE TABLE RoadProject ( 
    Road_ID NUMBER (8) NOT NULL, 
    Project_Code NUMBER (8) NOT NULL, 
    PRIMARY KEY (Road_ID, Project_Code),     
    CONSTRAINT fk_Road_RoadProject FOREIGN KEY (Road_ID) REFERENCES Road(Road_ID), 
    CONSTRAINT fk_Project_RoadProject FOREIGN KEY (Project_Code) REFERENCES Project(Project_Code) 
); 

  

INSERT INTO Role (Role_Name, Role_Description, Date_Assigned, Date_Ended) VALUES ( 
    'Architect', 
    'Specialises in designing all overall infrastructure', 
    TO_DATE ('09-05-2023', 'DD-MM-YYYY'), 
    TO_DATE ('05-09-2024', 'DD-MM-YYYY')
); 

  

INSERT INTO Role (Role_Name, Role_Description, Date_Assigned, Date_Ended) VALUES ( 
    'Surveyor', 
    'Creates measurements of the land, ensuring dimensions are correct',
    TO_DATE ('18-06-2023', 'DD-MM-YYYY'), 
    TO_DATE ('05-09-2024', 'DD-MM-YYYY') 
); 

INSERT INTO Role (Role_Name, Role_Description, Date_Assigned, Date_Ended) VALUES ( 
    'Financial Officer', 
    'Manages budget and other financial aspects of the project', 
    TO_DATE ('21-08-2023', 'DD-MM-YYYY'), 
    TO_DATE ('05-09-2024', 'DD-MM-YYYY') 
); 

INSERT INTO Role (Role_Name, Role_Description, Date_Assigned, Date_Ended) VALUES ( 
    'Supervisor', 
    'Supervises team members to ensure project goals and timelines are met', 
    TO_DATE ('28-08-2023', 'DD-MM-YYYY'), 
    TO_DATE ('05-09-2024', 'DD-MM-YYYY') 
);

INSERT INTO Role (Role_Name, Role_Description, Date_Assigned, Date_Ended) VALUES ( 
    'Planner', 
    'Develops and maintains project schedule, milestones and dealines', 
    TO_DATE ('31-03-2023', 'DD-MM-YYYY'), 
    TO_DATE ('05-09-2024', 'DD-MM-YYYY')
); 

INSERT INTO Role (Role_Name, Role_Description, Date_Assigned, Date_Ended) VALUES ( 
    'Manager', 
    'Contract oversight, budget management,  contractor coordination, quality control, risk management', 
    TO_DATE ('31-03-2023', 'DD-MM-YYYY'), 
    TO_DATE ('05-09-2024', 'DD-MM-YYYY')
); 

INSERT INTO Location (Location_ID, Location_Name, Latitude, Longitude, Location_Description, Start_Location_ID, End_Location_ID) VALUES ( 
    01, 
    'Wellington CBD', 
    41.2842, 
    174.7775, 
    'Central Business District of Wellington', 
    NULL,  
    NULL 
); 

INSERT INTO Location (Location_ID, Location_Name, Latitude, Longitude, Location_Description, Start_Location_ID, End_Location_ID) VALUES ( 
    02, 
    'Wellington Waterfront', 
    41.2842, 
    174.7835, 
    'Wellington harborside trail', 
    01,  
    NULL 
); 

INSERT INTO Location (Location_ID, Location_Name, Latitude, Longitude, Location_Description, Start_Location_ID, End_Location_ID) VALUES ( 
    03, 
    'Mount Victoria', 
    41.2966, 
    174.7854, 
    'Mount Victoria Lookout', 
    01, 
    02 
); 

INSERT INTO Location (Location_ID, Location_Name, Latitude, Longitude, Location_Description, Start_Location_ID, End_Location_ID) VALUES ( 
    04,
    'Museum of New Zealand Te Papa Tongarewa', 
    41.2853, 
    174.7781, 
    'New Zealands historical place museum', 
    NULL, 
    NULL 
); 

INSERT INTO Location (Location_ID, Location_Name, Latitude, Longitude, Location_Description, Start_Location_ID, End_Location_ID) VALUES ( 
    05,
    'Wellington Batonical Garden', 
    41.2829, 
    174.7666, 
    'Specialised plant collections and more', 
    NULL, 
    NULL 
); 

INSERT INTO Staff_Member (Employee_ID, First_Name, Last_Name, Employee_Employed, Date_of_Birth, Gender, Address, Phone_Number, Email, Role_Name) VALUES ( 
    12345670, 
    'Michael', 
    'Afton',
    TO_DATE ('09-11-2022', 'DD-MM-YYYY'), 
    TO_DATE ('11-09-2011', 'DD-MM-YYYY'), 
    'Female', 
    '64 Zoo Lane', 
    12120518, 
    'fivenights@freddys.com', 
    'Architect' 
); 

INSERT INTO Staff_Member (Employee_ID, First_Name, Last_Name, Employee_Employed, Date_of_Birth, Gender, Address, Phone_Number, Email, Role_Name) VALUES ( 
    12345671, 
    'Tom', 
    'Nook', 
    TO_DATE ('19-01-2023', 'DD-MM-YYYY'), 
    TO_DATE ('31-01-2005', 'DD-MM-YYYY'),
    'Male', 
    '69 Ross Street', 
    61854425, 
    'harleyharlington@harley.har', 
    'Surveyor' 
);

INSERT INTO Staff_Member (Employee_ID, First_Name, Last_Name, Employee_Employed, Date_of_Birth, Gender, Address, Phone_Number, Email, Role_Name) VALUES ( 
    12345672, 
    'Leon',  
    'Kennedy',
    TO_DATE ('23-04-2021', 'DD-MM-YYYY'), 
    TO_DATE ('18-06-2005', 'DD-MM-YYYY'), 
    'Female', 
    '55 Meow Circuit', 
    6151820149, 
    'buckleberry@hotmail.com', 
    'Financial Officer' 
); 
  

INSERT INTO Staff_Member (Employee_ID, First_Name, Last_Name, Employee_Employed, Date_of_Birth, Gender, Address, Phone_Number, Email, Role_Name) VALUES ( 
    12345673, 
    'Simon', 
    'Says',
    TO_DATE ('19-11-2023', 'DD-MM-YYYY'), 
    TO_DATE ('09-05-2005', 'DD-MM-YYYY'), 
    'Male', 
    '1738 Silent Hill', 
    231231984, 
    'sirqueefus@yahoo.com', 
    'Supervisor' 
); 

  INSERT INTO Staff_Member (Employee_ID, First_Name, Last_Name, Employee_Employed, Date_of_Birth, Gender, Address, Phone_Number, Email, Role_Name) VALUES ( 
    12345674, 
    'Taylor', 
    'Smith', 
    TO_DATE ('19-11-2023', 'DD-MM-YYYY'), 
    TO_DATE ('24-12-2004', 'DD-MM-YYYY'), 
    'Male', 
    '911 Racoon City', 
    12947612, 
    'mumpitysplizard@gmail.com', 
    'Planner' 
); 

  INSERT INTO Staff_Member (Employee_ID, First_Name, Last_Name, Employee_Employed, Date_of_Birth, Gender, Address, Phone_Number, Email, Role_Name) VALUES ( 
    12345675, 
    'Robert', 
    'Bobert', 
    TO_DATE ('17-04-2022', 'DD-MM-YYYY'), 
    TO_DATE ('21-08-2004', 'DD-MM-YYYY'), 
    'Male', 
    '666 Deez Nauts Lane', 
    23412397, 
    'glizzygawbler@outlook.com', 
    'Manager' 
); 

  INSERT INTO Staff_Member (Employee_ID, First_Name, Last_Name, Employee_Employed, Date_of_Birth, Gender, Address, Phone_Number, Email, Role_Name) VALUES ( 
    12345676, 
    'Man', 
    'Muffin', 
    TO_DATE ('23-04-2023', 'DD-MM-YYYY'), 
    TO_DATE ('03-09-1943', 'DD-MM-YYYY'), 
    'Male', 
    '4 Drury Lane', 
    911342123, 
    'nambla@gmail.com', 
    'Manager'
); 

  INSERT INTO Staff_Member (Employee_ID, First_Name, Last_Name, Employee_Employed, Date_of_Birth, Gender, Address, Phone_Number, Email, Role_Name) VALUES ( 
    12345677, 
    'Tyrone', 
    'Jarquevius the Fourth', 
    TO_DATE ('17-05-2023', 'DD-MM-YYYY'), 
    TO_DATE ('01-09-2000', 'DD-MM-YYYY'), 
    'Female', 
    '67 France Lane', 
    911, 
    'squibidisqualler@fornut.com', 
    'Manager'
); 

  INSERT INTO Staff_Member (Employee_ID, First_Name, Last_Name, Employee_Employed, Date_of_Birth, Gender, Address, Phone_Number, Email, Role_Name) VALUES ( 
    12345678, 
    'Vittoria', 
    'Toscano', 
    TO_DATE ('17-04-2022', 'DD-MM-YYYY'), 
    TO_DATE ('23-12-1977', 'DD-MM-YYYY'), 
    'Male', 
    '666 Ailaikmin Lane', 
    911983479, 
    'robertbobertlover@yahoo.com', 
    'Manager'
); 

  INSERT INTO Staff_Member (Employee_ID, First_Name, Last_Name, Employee_Employed, Date_of_Birth, Gender, Address, Phone_Number, Email, Role_Name) VALUES ( 
    12345679, 
    'Detective', 
    'Tapp', 
    TO_DATE ('27-03-2023', 'DD-MM-YYYY'), 
    TO_DATE ('27-06-1966', 'DD-MM-YYYY'), 
    'Male', 
    '8609 Everywhere Place', 
    28764273, 
    'ilikepumpkin@yahoo.com', 
    'Manager'
); 

INSERT INTO Road (Road_ID, Road_Name, Road_Description, Road_Category, Road_Length, Start_Location_ID, End_Location_ID) VALUES ( 
    100, 
    'Lambton Quay', 
    'Main street in the CBD',
    'Main Highway', 
    2.5, 
    01, 
    02
);
  

INSERT INTO Road (Road_ID, Road_Name, Road_Description, Road_Category, Road_Length, Start_Location_ID, End_Location_ID) VALUES ( 
    101, 
    'Jerquavis Avenue', 
    'Road along the Waterfront', 
    'Main Highway', 
    1.2, 
    02, 
    NULL 
);

INSERT INTO Road (Road_ID, Road_Name, Road_Description, Road_Category, Road_Length, Start_Location_ID, End_Location_ID) VALUES ( 
    102, 
    'Bingus Court', 
    'Main street in the CBD', 
    'Secondary Road', 
    2.5, 
    01, 
    02 
); 

INSERT INTO Road (Road_ID, Road_Name, Road_Description, Road_Category, Road_Length, Start_Location_ID, End_Location_ID) VALUES ( 
    103, 
    'Courtenay Place', 
    'Main entertainment street', 
    'Secondary Road', 
    3, 
    01, 
    03
); 

INSERT INTO Road (Road_ID, Road_Name, Road_Description, Road_Category, Road_Length, Start_Location_ID, End_Location_ID) VALUES ( 
    104, 
    'Skeebeedee Lane', 
    'Waterfront Road', 
    'Secondary Road', 
    1.2, 
    02, 
    03
); 

INSERT INTO Road (Road_ID, Road_Name, Road_Description, Road_Category, Road_Length, Start_Location_ID, End_Location_ID) VALUES ( 
    105, 
    'Telleo Drive', 
    'Commercial Street', 
    'Secondary Road', 
    3, 
    02, 
    03
); 

INSERT INTO Project (Project_Code, Project_Name, Project_Description, Project_Started, Project_Completed, Road_ID, Employee_ID) VALUES ( 
    11111111, 
    'City Road Maintenance', 
    'Routine maintenance of major city roads', 
    TO_DATE('15-02-2024', 'DD-MM-YYYY'), 
    TO_DATE('30-05-2024', 'DD-MM-YYYY'), 
    102, 
    12345670 
);

INSERT INTO Project (Project_Code, Project_Name, Project_Description, Project_Started, Project_Completed, Road_ID, Employee_ID) VALUES ( 
    11111112, 
    'Pedestrian Walkway Extension', 
    'Extension of pedestrian walkways', 
    TO_DATE('01-03-2024', 'DD-MM-YYYY'), 
    TO_DATE('01-09-2024', 'DD-MM-YYYY'), 
    103, 
    12345671 
);

INSERT INTO Project (Project_Code, Project_Name, Project_Description, Project_Started, Project_Completed, Road_ID, Employee_ID) VALUES ( 
    11111113, 
    'Tunnel Construction', 
    'Construction of a tunnel', 
    TO_DATE('10-04-2024', 'DD-MM-YYYY'), 
    TO_DATE('15-12-2024', 'DD-MM-YYYY'), 
    104, 
    12345672 
);

INSERT INTO Project (Project_Code, Project_Name, Project_Description, Project_Started, Project_Completed, Road_ID, Employee_ID) VALUES ( 
    11111114, 
    'Inner-city Bus Lane Installation', 
    'installing bus dedicated lanes', 
    TO_DATE('05-05-2024', 'DD-MM-YYYY'), 
    TO_DATE('10-11-2024', 'DD-MM-YYYY'), 
    105, 
    12345673 
);

INSERT INTO Project (Project_Code, Project_Name, Project_Description, Project_Started, Project_Completed, Road_ID, Employee_ID) VALUES ( 
    11111115, 
    'Cyclists Lane Installation', 
    'Installing cyclist lanes', 
    TO_DATE('01-06-2024', 'DD-MM-YYYY'), 
    TO_DATE('01-12-2024', 'DD-MM-YYYY'), 
    101, 
    12345674 
);

INSERT INTO Contract_Manager (Manager_Contract_Number, Employee_ID, Start_Date, End_Date) VALUES ( 
    301,
    12345675,
    TO_DATE('01-02-2023', 'DD-MM-YYYY'),
    NULL
);

INSERT INTO Contract_Manager (Manager_Contract_Number, Employee_ID, Start_Date, End_Date) VALUES ( 
    302,
    12345676,
    TO_DATE('01-02-2023', 'DD-MM-YYYY'),
    TO_DATE('01-12-2023', 'DD-MM-YYYY')
);

INSERT INTO Contract_Manager (Manager_Contract_Number, Employee_ID, Start_Date, End_Date) VALUES ( 
    303,
    12345677,
    TO_DATE('18-06-2024', 'DD-MM-YYYY'),
    NULL
);

INSERT INTO Contract_Manager (Manager_Contract_Number, Employee_ID, Start_Date, End_Date) VALUES ( 
    304,
    12345678,
    TO_DATE('09-05-2023', 'DD-MM-YYYY'),
    NULL
);

INSERT INTO Contract_Manager (Manager_Contract_Number, Employee_ID, Start_Date, End_Date) VALUES ( 
    305,
    12345679,
    TO_DATE('01-02-2023', 'DD-MM-YYYY'),
    TO_DATE('23-12-2024', 'DD-MM-YYYY')
);

INSERT INTO Contractor_Company (Contractor_ID, Contractor_Name, Contractor_Address, Preferred_Contact_Details, Employee_ID) 
VALUES (
    501,
    'Contractor Company 1',
    '1 Contractor Street',
    'onecontracting@gmail.com',
    12345671
);

INSERT INTO Contractor_Company (Contractor_ID, Contractor_Name, Contractor_Address, Preferred_Contact_Details, Employee_ID) 
VALUES (
    502,
    'Second Contracting Company',
    '22 Con Tracting Lane',
    'secondsecond@yahoo.com', 
    12345672 
);

INSERT INTO Contractor_Company (Contractor_ID, Contractor_Name, Contractor_Address, Preferred_Contact_Details, Employee_ID) VALUES (
    503,
    'Company Contracts Three',
    '303 Contract Court',
    'three@outlook.com', 
    12345673
);

INSERT INTO Contractor_Company (Contractor_ID, Contractor_Name, Contractor_Address, Preferred_Contact_Details, Employee_ID) VALUES (
    504,
    'Four for Four Contractors',
    '4444 Company Court',
    'fourthousandfourhundredandfour@hotmail.com',
    12345674
);

INSERT INTO Contractor_Company (Contractor_ID, Contractor_Name, Contractor_Address, Preferred_Contact_Details, Employee_ID) 
VALUES (
    505,
    'Five Contracting Company',
    '5 Contracting Company Ctreet',
    'fyve@example.com',
    12345670
);

INSERT INTO Contract (Contract_Number, Contract_Name, Contract_Description, Estimated_Cost, Actual_Cost, Contract_Started, Contract_Ended, Contractor_ID, Manager_Contract_Number, Project_Code) 
VALUES (
    1001,
    'City Road Maintenance',
    'Maintenance of major roads in the city center',
    200000.00,
    190000.00,
    TO_DATE('15-02-2024', 'DD-MM-YYYY'),
    TO_DATE('30-05-2024', 'DD-MM-YYYY'),
    501,
    301,
    11111111
);

INSERT INTO Contract (Contract_Number, Contract_Name, Contract_Description, Estimated_Cost, Actual_Cost, Contract_Started, Contract_Ended, Contractor_ID, Manager_Contract_Number, Project_Code) 
VALUES (
    1002,
    'Pedestrian Walkway Extension',
    'Extension of pedestrian walkways throughout the city',
    500000.00,
    450000.00,
    TO_DATE('01-03-2024', 'DD-MM-YYYY'),
    TO_DATE('01-09-2024', 'DD-MM-YYYY'),
    502,
    302,
    11111112
);

INSERT INTO Contract (Contract_Number, Contract_Name, Contract_Description, Estimated_Cost, Actual_Cost, Contract_Started, Contract_Ended, Contractor_ID, Manager_Contract_Number, Project_Code)  VALUES (
    1003,
    'Tunnel Construction',
    'Construction of a tunnel under the city',
    2000000.00,
    1900000.00,
    TO_DATE('10-04-2024', 'DD-MM-YYYY'),
    TO_DATE('15-12-2024', 'DD-MM-YYYY'),
    503,
    303,
    11111113
);

INSERT INTO Contract (Contract_Number, Contract_Name, Contract_Description, Estimated_Cost, Actual_Cost, Contract_Started, Contract_Ended, Contractor_ID, Manager_Contract_Number, Project_Code)  VALUES (
    1004,
    'Inner-city Bus Lane Installation',
    'Installation of dedicated bus lanes',
    1500000.00,
    1450000.00,
    TO_DATE('05-05-2024', 'DD-MM-YYYY'),
    TO_DATE('10-11-2024', 'DD-MM-YYYY'),
    504,
    304,
    11111114
);

INSERT INTO Contract (Contract_Number, Contract_Name, Contract_Description, Estimated_Cost, Actual_Cost, Contract_Started, Contract_Ended, Contractor_ID, Manager_Contract_Number, Project_Code) 
VALUES (
    1005,
    'Cyclist Lane Installation',
    'Installation of cyclist lanes in urban areas',
    1200000.00,
    1150000.00,
    TO_DATE('01-06-2024', 'DD-MM-YYYY'),
    TO_DATE('01-12-2024', 'DD-MM-YYYY'),
    505,
    305,
    11111115
);

INSERT INTO RoadProject (Road_ID, Project_Code) VALUES (
    100,
    11111111
);

INSERT INTO RoadProject (Road_ID, Project_Code) VALUES (
    101,
    11111112
);

INSERT INTO RoadProject (Road_ID, Project_Code) VALUES (
    102,
    11111113
);

INSERT INTO RoadProject (Road_ID, Project_Code) VALUES (
    103,
    11111114
);

INSERT INTO RoadProject (Road_ID, Project_Code) VALUES (
    104,
    11111115
);

SELECT * FROM Role;
SELECT * FROM Location;
SELECT * FROM Staff_Member;
SELECT * FROM Project;
SELECT * FROM Road;
SELECT * FROM Contract_Manager;
SELECT * FROM Contractor_Company;
SELECT * FROM Contract;
SELECT * FROM RoadProject;
    

 

------------------------------------------------------------------------------------------------------------------------------ 

SELECT Role_Name, Role_Description 

FROM Role 

WHERE Date_Assigned > TO_DATE('01-05-2023', 'DD-MM-YYYY'); 

------------------------------------------------------------- 

SELECT Role_Name || ' ' || Role_Description as "Role and Description"  

FROM Role  

WHERE Role_Name = 'Manager'; 

------------------------------------------------------------------------------------------------------------------------------ 

SELECT Role_Name, Role_Description, Date_Ended - Date_Assigned AS Active_Days 

FROM Role 

WHERE Date_Ended IS NOT NULL 

ORDER BY Active_Days DESC; 

------------------------------------------------------------- 

SELECT Location_ID, Location_Number, Latitude || ' ' || Longitude AS "Lat / Long"  

FROM Location  

WHERE Location_ID = 02; 

------------------------------------------------------------------------------------------------------------------------------ 

 

 ------------------------------------------------------------------------------------------------------------------------------ 

SELECT First_Name || ' ' || Last_Name AS Full_Name, Email 

FROM Staff_Member 

WHERE Role_Name = 'Manager'; 

------------------------------------------------------------- 

SELECT Employee_ID, First_Name || ' ' || Last_Name AS "Full Name", Phone_Number  ||  

' ' || Email AS "Contact Information"  

FROM Staff_Member; 

------------------------------------------------------------------------------------------------------------------------------ SELECT COUNT(Project_Code) AS Total_Projects 

FROM Project 

WHERE Road_ID IN (SELECT Road_ID FROM Road WHERE Road_Category = 'Main Highway'); 

------------------------------------------------------------- 

SELECT Employee_ID  

FROM Staff_Member  

WHERE Employee_ID IN (SELECT Employee_ID  FROM Project   

WHERE Road_ID IN (SELECT Road_ID FROM Road  

WHERE Start_Location_ID = 01 OR End_Location_ID = 01)); 

------------------------------------------------------------------------------------------------------------------------------ 

 

------------------------------------------------------------------------------------------------------------------------------ 

SELECT Road_Name, Road_Description 

FROM Road 

WHERE Road_Category = 'Main Highway'; 

------------------------------------------------------------- 

SELECT Road_ID Number, Road_Name || ' ' || Road_Description AS "Road Information", Road_Category  

FROM Road  

WHERE Road_Category = 'Secondary Road'; 

------------------------------------------------------------------------------------------------------------------------------ 

SELECT Manager_Contract_Number, Employee_ID 

FROM Contract_Manager 

WHERE End_Date IS NULL; 

------------------------------------------------------------- 

SELECT Manager_Contract_Number 

FROM Contract_Manager 

WHERE Start_Date > TO_DATE('01-01-2023', 'DD-MM-YYYY'); 

------------------------------------------------------------------------------------------------------------------------------ 

 

------------------------------------------------------------------------------------------------------------------------------ 

SELECT Contractor_Name, Contractor_Address 

FROM Contractor_Company 

WHERE Preferred_Contact_Details LIKE '%gmail.com%'; 

------------------------------------------------------------- 

SELECT Contractor_ID || ' ' || Employee_ID AS "Contract ID | Employee ID", Preferred_Contact_Details  

FROM Contractor_Company; 

 ------------------------------------------------------------------------------------------------------------------------------ 

SELECT SUM(Actual_Cost) AS Total_Actual_Cost 

FROM Contract 

WHERE Contractor_ID = (SELECT Contractor_ID FROM Contractor_Company WHERE Contractor_Name = 'Contractor Company 1'); 

------------------------------------------------------------- 

SELECT Contract_Name, Estimated_Cost 

FROM Contract 

WHERE Estimated_Cost > 1000000; 

 ------------------------------------------------------------------------------------------------------------------------------ 

 

  

 

------------------------------------------------------------------------------------------------------------------------------ 

SELECT Road_ID, Project_Code 

FROM RoadProject 

WHERE Road_ID IN (SELECT Road_ID FROM Road WHERE Start_Location_ID = 01); 

------------------------------------------------------------- 

SELECT Road_ID || ' ' || Project_Code AS "Road ID | Project ID" 

FROM RoadProject;  

------------------------------------------------------------------------------------------------------------------------------ 

SELECT Road_Name 

FROM Road 

WHERE Road_ID IN (SELECT Road_ID FROM Project WHERE Project_Started > TO_DATE('01-01-2024', 'DD-MM-YYYY')); 

------------------------------------------------------------- 

SELECT First_Name || ' ' || Last_Name AS Full_Name, Role_Name 

FROM Staff_Member 

------------------------------------------------------------------------------------------------------------------------------ 

