CREATE DATABASE vuonquocgia;
USE vuonquocgia;

-- 1. Tạo bảng Animals
CREATE TABLE Animals (
    AnimalID VARCHAR(20) PRIMARY KEY,
    CommonName VARCHAR(100),
    ScientificName VARCHAR(100),
    Family VARCHAR(100),
    Species VARCHAR(100),
    ConservationStatus VARCHAR(50),
    Population INT,
    HabitatID VARCHAR(20)
);

-- 2. Tạo bảng Habitats
CREATE TABLE Habitats (
    HabitatID VARCHAR(20) PRIMARY KEY,
    HabitatType VARCHAR(100),
    Description VARCHAR(255)
);

-- 3. Tạo bảng ParkZones
CREATE TABLE ParkZones (
    ZoneID VARCHAR(20) PRIMARY KEY,
    ZoneName VARCHAR(100),
    Area DECIMAL(10,2),
    Description VARCHAR(255)
);

-- 4. Tạo bảng AnimalLocations
CREATE TABLE AnimalLocations (
    AnimalLocationID VARCHAR(20) PRIMARY KEY,
    AnimalID VARCHAR(20),
    ZoneID VARCHAR(20),
    DateObserved DATE
);

-- 5. Tạo bảng Staff
CREATE TABLE Staff (
    StaffID VARCHAR(20) PRIMARY KEY,
    FullName VARCHAR(100),
    Role VARCHAR(50),
    ContactInfo VARCHAR(255),
    ZoneID VARCHAR(20)
);

-- 6. Tạo bảng Research
CREATE TABLE Research (
    ResearchID VARCHAR(20) PRIMARY KEY,
    Title VARCHAR(255),
    AnimalID VARCHAR(20),
    StaffID VARCHAR(20),
    StartDate DATE,
    EndDate DATE,
    Findings VARCHAR(255)
);

-- 7. Tạo bảng Tourists
CREATE TABLE Tourists (
    TouristID VARCHAR(20) PRIMARY KEY,
    FullName VARCHAR(100),
    VisitDate DATE,
    ZoneID VARCHAR(20),
    Feedback VARCHAR(255)
);

-- 8. Tạo bảng Events
CREATE TABLE Events (
    EventID VARCHAR(20) PRIMARY KEY,
    EventName VARCHAR(100),
    Date DATE,
    ZoneID VARCHAR(20),
    Description VARCHAR(255)
);

-- 9. Tạo bảng EndangeredSpecies
CREATE TABLE EndangeredSpecies (
    SpeciesID VARCHAR(20) PRIMARY KEY,
    AnimalID VARCHAR(20),
    Threats VARCHAR(255),
    ProtectionMeasures VARCHAR(255)
);
