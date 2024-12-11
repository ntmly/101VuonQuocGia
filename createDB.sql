use vuonquocgia;

-- 1. Tao bang Animals
CREATE TABLE Animals (
    AnimalID NVARCHAR(20) PRIMARY KEY,
    CommonName NVARCHAR(100),
    ScientificName NVARCHAR(100),
    Family NVARCHAR(100),
    Species NVARCHAR(100),
    ConservationStatus NVARCHAR(50),
    Population INT,
    HabitatID NVARCHAR(20)
);

-- 2. Tao bang Habitats
CREATE TABLE Habitats (
	HabitatID NVARCHAR(20) PRIMARY KEY,
    HabitatType NVARCHAR(100),
    Description NVARCHAR(255)
);

-- 3. Tao bang ParkZones
CREATE TABLE ParkZones (
	ZoneID NVARCHAR(20) PRIMARY KEY,
    ZoneName NVARCHAR(100),
    Area DECIMAL(10,2),
    Description NVARCHAR(255)
);

-- 4. Tao bang AnimalLocations
CREATE TABLE AnimalLocations (
	AnimalLocationID NVARCHAR(20) PRIMARY KEY,
    AnimalID NVARCHAR(20),
    ZoneID NVARCHAR(20),
    DateObserved Date
);

-- 5. Tao bang Staff
CREATE TABLE Staff (
	StaffID NVARCHAR(20) PRIMARY KEY,
    FullName NVARCHAR(100),
    Role NVARCHAR(50),
    ContactInfo NVARCHAR(255),
    ZoneID NVARCHAR(20)
);

-- 6. Tao bang Research
CREATE TABLE RESEARCH (
	ResearchID NVARCHAR(20) PRIMARY KEY,
    Title NVARCHAR(255),
    AnimalID NVARCHAR(20),
    StaffID NVARCHAR(20),
    StartDate DATE,
    EndDate DATE,
    Findings NVARCHAR(255)
);

-- 7. Tao bang Tourists
CREATE TABLE Tourists (
	TouristID NVARCHAR(20) PRIMARY KEY,
    FullName NVARCHAR(100),
    VisitDate DATE,
    ZoneID NVARCHAR(20),
    Feedback NVARCHAR(255)
);

-- 8. Tao bang Events
CREATE TABLE Events (
	EventID NVARCHAR(20) PRIMARY KEY,
    EventName NVARCHAR(100),
    Date DATE,
    ZoneID NVARCHAR(20),
    Description NVARCHAR(255)
);

-- 9. Tao bang EndangeredSpecies
CREATE TABLE EndangeredSpecies (
	SpeciesID NVARCHAR(20) PRIMARY KEY,
    AnimalID NVARCHAR(20),
    Threats NVARCHAR(255),
    ProtectionMeasures NVARCHAR(255)
);

-- 10. Tao bang Weather 
CREATE TABLE Weather (
	WeatherID NVARCHAR(20) PRIMARY KEY,
    ZoneID NVARCHAR(20),
    Date DATE,
    Temperature DECIMAL(5,2),
    Rainfall DECIMAL(5,2),
    Description NVARCHAR(255)
);
