USE vuonquocgia;
-- FK Animals
ALTER TABLE Animals
ADD CONSTRAINT fk_animals
FOREIGN KEY (HabitatID)
REFERENCES Habitats(HabitatID);

-- FK AnimalLocations
ALTER TABLE AnimalLocations
ADD CONSTRAINT fk_animalLocation_1 FOREIGN KEY (AnimalID) 
	REFERENCES Animals(AnimalID),
ADD CONSTRAINT fk_animalLocation_2 FOREIGN KEY (ZoneID) 
	REFERENCES ParkZones(ZoneID);

-- FK Staff
ALTER TABLE Staff
ADD CONSTRAINT fk_staff
FOREIGN KEY (ZoneID)
REFERENCES ParkZones(ZoneID);

-- FK Reasearch
ALTER TABLE Research
ADD CONSTRAINT fk_research_1 FOREIGN KEY (AnimalID) 
	REFERENCES Animals(AnimalID),
ADD CONSTRAINT fk_Research_2 FOREIGN KEY (StaffID) 
	REFERENCES Staff(StaffID);
    
-- FK Tourists
ALTER TABLE Tourists
ADD CONSTRAINT fk_tourists 
FOREIGN KEY (ZoneID)
REFERENCES ParkZones(ZoneID);

-- FK Events
ALTER TABLE Events
ADD CONSTRAINT fk_events
FOREIGN KEY (ZoneID)
REFERENCES ParkZones(ZoneID);

-- FK EndangeredSpecies
ALTER TABLE EndangeredSpecies
ADD CONSTRAINT fk_EndangeredSpecies
FOREIGN KEY (AnimalID)
REFERENCES Animals(AnimalID);

-- Ràng buộc UNIQUE tránh phản hồi trùng lặp cùng ngày
ALTER TABLE Tourists
ADD CONSTRAINT unique_tourist_feedback UNIQUE (VisitDate, Feedback);

-- Ràng buộc Population trong bảng Animals phải là số không âm
ALTER TABLE Animals
ADD CONSTRAINT chk_population CHECK (Population >= 0);

-- Ràng buộc NOT NULL đảm bảo các cột quan trọng không được NULL trong bảng Animals
ALTER TABLE Animals
MODIFY CommonName VARCHAR(100) NOT NULL,
MODIFY ScientificName VARCHAR(100) NOT NULL,
MODIFY Population INT NOT NULL;