CREATE DATABASE assignment;
USE assignment;

CREATE TABLE Member (
    MemberID varchar(10) PRIMARY KEY,
    MemberFName varchar(20),
    MemberLName varchar(20),
    MemberLoc varchar(20)
);

CREATE TABLE Vehicle (
    VehicleReg varchar(10) PRIMARY KEY,
    VehicleMake varchar(10),
    VehicleModel varchar(10),
    MemberID varchar(10),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE Engineer (
    EngineerID int PRIMARY KEY,
    EngineerFName varchar(20),
    EngineerLName varchar(20)
);

CREATE TABLE Breakdown (
    BreakdownID int PRIMARY KEY,
    VehicleReg varchar(10),
    EngineerID int,
    BreakdownDATE date,
    BreakdownTIME time,
    BreakdownLoc varchar(20),
    FOREIGN KEY (VehicleReg) REFERENCES Vehicle(VehicleReg),
    FOREIGN KEY (EngineerID) REFERENCES Engineer(EngineerID)
);

INSERT INTO Member (MemberID, MemberFName, MemberLName, MemberLoc)
VALUES 
    ('M1', 'John', 'Doe', 'London'),
    ('M2', 'Jane', 'Smith', 'Coventry'),
    ('M3', 'Bob', 'Johnson', 'Manchester'),
    ('M4', 'Alice', 'Williams', 'Newcastle'),
    ('M5', 'Charlie', 'Brown', 'Brighton');

UPDATE MEMBER 
SET Memberloc = 'Brighton'
WHERE MemberID = 'M5';
SELECT * FROM Member;

INSERT INTO Vehicle (VehicleReg, VehicleMake, VehicleModel, MemberID)
VALUES 
    ('V1', 'Toyota', 'Camry', 'M1'),
    ('V2', 'Honda', 'Civic', 'M2'),
    ('V3', 'Ford', 'Focus', 'M3'),
    ('V4', 'Chevrolet', 'Malibu', 'M4'),
    ('V5', 'Nissan', 'Altima', 'M5'),
    ('V6', 'Toyota', 'Corolla', 'M1'),
    ('V7', 'Honda', 'Accord', 'M2'),
    ('V8', 'Ford', 'Fusion', 'M3');

INSERT INTO Engineer (EngineerID, EngineerFName, EngineerLName)
VALUES 
    (1, 'Robert', 'Smith'),
    (2, 'Jennifer', 'Jones'),
    (3, 'Michael', 'Davis');

INSERT INTO Breakdown (BreakdownID, VehicleReg, EngineerID, BreakdownDATE, BreakdownTIME, BreakdownLoc)
VALUES 
    (1, 'V1', 1, '2024-02-15', '08:30:00', 'London'),
    (2, 'V2', 2, '2024-03-10', '12:45:00', 'Coventry'),
    (3, 'V3', 3, '2024-04-20', '15:20:00', 'Middlesborough'),
    (4, 'V4', 1, '2024-05-05', '10:00:00', 'Brighton'),
    (5, 'V5', 2, '2024-06-12', '14:30:00', 'Newcastle'),
    (6, 'V1', 3, '2024-07-08', '09:15:00', 'Liverpool'),
    (7, 'V2', 1, '2024-08-25', '11:00:00', 'Birmingham'),
    (8, 'V3', 2, '2024-09-14', '13:45:00', 'Leeds'),
    (9, 'V4', 3, '2024-10-03', '16:30:00', 'Huddersfield'),
    (10, 'V5', 1, '2024-11-19', '08:00:00', 'Nottingham'),
    (11, 'V6', 2, '2024-12-07', '10:45:00', 'Southampton'),
    (12, 'V7', 3, '2024-12-07', '15:00:00', 'Bristol');
    
    SELECT MemberFName, MemberLName
FROM Member
WHERE MemberLoc = 'London';

	SELECT *
FROM Vehicle
WHERE VehicleMake = 'Nissan';

	SELECT COUNT(*)
FROM Engineer;

	SELECT COUNT(*)
FROM Member;

	SELECT *
FROM Breakdown
WHERE BreakdownDATE < '2024-07-08';

	SELECT *
FROM Breakdown
WHERE BreakdownDATE BETWEEN '2024-08-01' AND '2024-10-01';

	SELECT COUNT(*)
FROM Breakdown
WHERE VehicleReg = 'V1';

	SELECT VehicleReg, COUNT(*) AS BreakdownCount
FROM Breakdown
GROUP BY VehicleReg
HAVING COUNT(*) > 1;

SELECT Member.MemberFName, Member.MemberLName, Vehicle.* FROM Member
JOIN Vehicle ON Member.MemberID = Vehicle.MemberID
WHERE Member.MemberFName = 'Matt';

SELECT Member.MemberFName, Member.MemberLName, COUNT(Vehicle.VehicleReg) AS VehicleCount FROM Member
LEFT JOIN Vehicle ON Member.MemberID = Vehicle.MemberID
GROUP BY Member.MemberID, Member.MemberFName, Member.MemberLName
ORDER BY VehicleCount ;

SELECT Member.MemberFName, Member.MemberLName, Vehicle.* FROM Member
JOIN Vehicle ON Member.MemberID = Vehicle.MemberID
JOIN Breakdown ON Vehicle.VehicleReg = Breakdown.VehicleReg
WHERE Breakdown.BreakdownLoc = 'Huddersfield';

SELECT Member.MemberFName, Member.MemberLName, Breakdown.*, Engineer.*
FROM Member
JOIN Vehicle ON Member.MemberID = Vehicle.MemberID
JOIN Breakdown ON Vehicle.VehicleReg = Breakdown.VehicleReg
JOIN Engineer ON Breakdown.EngineerID = Engineer.EngineerID
WHERE Breakdown.BreakdownDATE BETWEEN '2024-06-01' AND '2024-09-01';

SELECT Member.MemberFName, Member.MemberLName, Breakdown.*, Engineer.*
FROM Member
JOIN Vehicle ON Member.MemberID = Vehicle.MemberID
JOIN Breakdown ON Vehicle.VehicleReg = Breakdown.VehicleReg
JOIN Engineer ON Breakdown.EngineerID = Engineer.EngineerID
WHERE Breakdown.BreakdownLoc = 'Southampton';

SELECT Member.MemberFName, Member.MemberLName, Vehicle.VehicleReg, COUNT(*) AS BreakdownCount
FROM Member
JOIN Vehicle ON Member.MemberID = Vehicle.MemberID
JOIN Breakdown ON Vehicle.VehicleReg = Breakdown.VehicleReg
GROUP BY Member.MemberID, Member.MemberFName, Member.MemberLName, Vehicle.VehicleReg
ORDER BY BreakdownCount DESC
LIMIT 1;

SELECT Member.MemberFName, Member.MemberLName, Breakdown.*
FROM Member
JOIN Vehicle ON Member.MemberID = Vehicle.MemberID
JOIN Breakdown ON Vehicle.VehicleReg = Breakdown.VehicleReg
JOIN Engineer ON Breakdown.EngineerID = Engineer.EngineerID
WHERE Engineer.EngineerLName = 'Smith';

-- AVG (Average):
	-- Description: Computes the average value of a numeric column in a set of rows.
	-- Syntax: SELECT AVG(Age) FROM Member;
    
-- MAX (Maximum):
	-- Description: Returns the highest value in a set of rows for a specific column.
	-- Syntax: SELECT MAX(Salary) FROM Employees;
    
-- MIN (Minimum):
	-- Description: Returns the lowest value in a set of rows for a specific column.
	-- Syntax: SELECT MIN(Temperature) FROM WeatherData;
    
-- SUM (Summation):
	-- Description: Adds up all the values in a numeric column for a set of rows.
	-- Syntax: SELECT SUM(SalesAmount) FROM Sales;
    


DELIMITER $$

CREATE PROCEDURE DisplayCarCountForMember(IN FirstName VARCHAR(20), IN LastName VARCHAR(20))
BEGIN
    DECLARE MemberID_var VARCHAR(10);

    SELECT MemberID INTO MemberID_var
    FROM Member
    WHERE MemberFName = FirstName AND MemberLName = LastName
    LIMIT 1;

    IF (MemberID_var IS NOT NULL) THEN
        SELECT 
            COUNT(VehicleReg) AS CarCount, 
            CASE 
                WHEN COUNT(VehicleReg) > 1 THEN 'Multi-car policy'
                ELSE 'Single-car policy'
            END AS PolicyType
        FROM Vehicle
        WHERE MemberID = MemberID_var;
    ELSE
        SELECT 'Member not found' AS Result;
    END IF;
END $$

CALL DisplayCarCountForMember('John', 'Doe');













 










