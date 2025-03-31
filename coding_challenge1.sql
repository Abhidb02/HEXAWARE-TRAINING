-- Step 1: Drop existing tables and recreate them
DROP DATABASE IF EXISTS PetPals;
CREATE DATABASE PetPals;
USE PetPals;

-- Step 2: Create Tables
CREATE TABLE Pets (
    PetID INT PRIMARY KEY AUTO_INCREMENT,
    Namee VARCHAR(255) NOT NULL,
    Age INT NOT NULL,
    Breed VARCHAR(255) NOT NULL,
    Typee VARCHAR(50) NOT NULL,
    AvailableForAdoption BIT NOT NULL,
    OwnerID INT NULL  -- Added OwnerID column
);

CREATE TABLE Shelters (
    ShelterID INT PRIMARY KEY AUTO_INCREMENT,
    Namee VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE Donations (
    DonationID INT PRIMARY KEY AUTO_INCREMENT,
    DonorName VARCHAR(255) NOT NULL,
    DonationType VARCHAR(50) NOT NULL,
    DonationAmount DECIMAL(10,2),
    DonationItem VARCHAR(255),
    DonationDate DATETIME NOT NULL
);

CREATE TABLE AdoptionEvents (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    EventName VARCHAR(255) NOT NULL,
    EventDate DATETIME NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE Participants (
    ParticipantID INT PRIMARY KEY AUTO_INCREMENT,
    ParticipantName VARCHAR(255) NOT NULL,
    ParticipantTypee VARCHAR(50) NOT NULL,
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);

-- Create Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Namee VARCHAR(255) NOT NULL
);

CREATE TABLE Adoption (
    AdoptionID INT PRIMARY KEY AUTO_INCREMENT,
    PetID INT NOT NULL,
    UserID INT NOT NULL,
    AdoptionDate DATETIME NOT NULL,
    FOREIGN KEY (PetID) REFERENCES Pets(PetID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Step 3: Queries

-- 1. Retrieve available pets for adoption
SELECT Namee, Age, Breed, Typee 
FROM Pets 
WHERE AvailableForAdoption = 1;

-- 2. Retrieve participant names for a specific adoption event
SELECT ParticipantName, ParticipantTypee 
FROM Participants 
WHERE EventID = 1; -- Replace '1' with the actual EventID

-- 3. Drop and recreate stored procedure to update shelter info
DROP PROCEDURE IF EXISTS UpdateShelterInfo;
DELIMITER $$
CREATE PROCEDURE UpdateShelterInfo(IN shelterID INT, IN newNamee VARCHAR(255), IN newLocation VARCHAR(255))
BEGIN
    UPDATE Shelters SET Namee = newNamee, Location = newLocation WHERE ShelterID = shelterID;
END $$
DELIMITER ;

-- 4. Total donation amount per shelter
SELECT Shelters.Namee, IFNULL(SUM(DonationAmount), 0) AS TotalDonation 
FROM Shelters
LEFT JOIN Donations ON Shelters.ShelterID = Donations.DonationID
GROUP BY Shelters.Namee;

-- 5. Pets without owners
SELECT Namee, Age, Breed, Typee FROM Pets WHERE OwnerID IS NULL;

-- 6. Total donation amount per month/year
SELECT DATE_FORMAT(DonationDate, '%M %Y') AS MonthYear, SUM(DonationAmount) AS TotalDonation 
FROM Donations
GROUP BY MonthYear;

-- 7. Distinct breeds of pets aged 1-3 years or older than 5 years
SELECT DISTINCT Breed FROM Pets WHERE Age BETWEEN 1 AND 3 OR Age > 5;

-- 8. Pets and their respective shelters available for adoption
SELECT Pets.Namee, Shelters.Namee AS ShelterNamee 
FROM Pets 
JOIN Shelters ON Pets.OwnerID = Shelters.ShelterID
WHERE Pets.AvailableForAdoption = 1;

-- 9. Total participants in events by city
SELECT COUNT(Participants.ParticipantID) AS TotalParticipants
FROM Participants
JOIN AdoptionEvents ON Participants.EventID = AdoptionEvents.EventID
WHERE AdoptionEvents.Location = 'Chennai';

-- 10. Unique breeds of pets aged between 1-5 years
SELECT DISTINCT Breed FROM Pets WHERE Age BETWEEN 1 AND 5;

-- 11. Pets that have not been adopted
SELECT * FROM Pets WHERE PetID NOT IN (SELECT PetID FROM Adoption);

-- 12. Adopted pets and adopter names
SELECT Pets.Namee AS PetNamee, Users.Namee AS AdopterNamee
FROM Adoption
JOIN Pets ON Adoption.PetID = Pets.PetID
JOIN Users ON Adoption.UserID = Users.UserID;

-- 13. Shelters with count of available pets
SELECT Shelters.Namee, COUNT(Pets.PetID) AS AvailablePets
FROM Shelters
LEFT JOIN Pets ON Shelters.ShelterID = Pets.OwnerID AND Pets.AvailableForAdoption = 1
GROUP BY Shelters.Namee;

-- 14. Pairs of pets from same shelter with same breed
SELECT p1.Namee AS Pet1, p2.Namee AS Pet2, p1.Breed, s.Namee AS ShelterNamee
FROM Pets p1
JOIN Pets p2 ON p1.Breed = p2.Breed AND p1.PetID < p2.PetID
JOIN Shelters s ON p1.OwnerID = s.ShelterID;

-- 15. All possible shelter and event combinations
SELECT Shelters.Namee AS Shelter, AdoptionEvents.EventName AS Event
FROM Shelters
CROSS JOIN AdoptionEvents;

-- 16. Shelter with highest number of adopted pets
SELECT Shelters.Namee, COUNT(Adoption.PetID) AS TotalAdopted
FROM Shelters
JOIN Pets ON Shelters.ShelterID = Pets.OwnerID
JOIN Adoption ON Pets.PetID = Adoption.PetID
GROUP BY Shelters.Namee
ORDER BY TotalAdopted DESC
LIMIT 1;

-- Insert sample data
INSERT INTO Shelters (Namee, Location) VALUES 
('Happy Paws Shelter', 'Chennai'),
('Safe Haven', 'Mumbai');

INSERT INTO Pets (Namee, Age, Breed, Typee, AvailableForAdoption, OwnerID) VALUES 
('Buddy', 3, 'Labrador', 'Dog', 1, 1),
('Milo', 5, 'Persian Cat', 'Cat', 1, 2),
('Coco', 2, 'Beagle', 'Dog', 0, 1);

INSERT INTO Users (Namee) VALUES 
('John Doe'),
('Alice Smith');

INSERT INTO Adoption (PetID, UserID, AdoptionDate) VALUES 
(1, 1, NOW()),
(2, 2, NOW());

INSERT INTO AdoptionEvents (EventName, EventDate, Location) VALUES 
('Pet Adoption Day', '2025-04-10', 'Chennai');

INSERT INTO Participants (ParticipantName, ParticipantTypee, EventID) VALUES 
('John Doe', 'Adopter', 1);