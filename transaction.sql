USE vuonquocgia;

-- Giao dịch 1: Thêm động vật và khu vực sống
START TRANSACTION;
INSERT INTO Animals (AnimalID, CommonName, ScientificName, Family, Species, ConservationStatus, Population, HabitatID)
VALUES ('A001', 'Bengal Tiger', 'Panthera tigris tigris', 'Felidae', 'Mammal', 'Endangered', 2500, 'H001');
INSERT INTO Habitats (HabitatID, HabitatType, Description)
VALUES ('H001', 'Tropical Forest', 'Dense jungle with rich biodiversity');
ROLLBACK;

-- Giao dịch 2: Cập nhật thông tin động vật
START TRANSACTION;
UPDATE Animals SET Population = 2400 WHERE AnimalID = 'A001';
UPDATE Habitats SET HabitatType = 'Rainforest' WHERE HabitatID = 'H001';
ROLLBACK;

-- Giao dịch 3: Xóa động vật
START TRANSACTION;
DELETE FROM Animals WHERE AnimalID = 'A001';
DELETE FROM Habitats WHERE HabitatID = 'H001';
ROLLBACK;

-- Giao dịch 4: Thêm nghiên cứu
START TRANSACTION;
INSERT INTO Research (ResearchID, Title, AnimalID, StaffID, StartDate, EndDate, Findings)
VALUES ('R001', 'Behavioral study of Bengal Tiger', 'A001', 'S001', '2024-01-01', '2024-12-31', 'No significant findings');
ROLLBACK;

-- Giao dịch 5: Cập nhật thông tin nghiên cứu
START TRANSACTION;
UPDATE Research SET Findings = 'Critical findings regarding habitat loss' WHERE ResearchID = 'R001';
ROLLBACK;

-- Giao dịch 6: Thêm nhân viên
START TRANSACTION;
INSERT INTO Staff (StaffID, FullName, Role, ContactInfo, ZoneID)
VALUES ('S001', 'John Doe', 'Biologist', 'john.doe@example.com', 'Z001');
ROLLBACK;

-- Giao dịch 7: Cập nhật thông tin nhân viên
START TRANSACTION;
UPDATE Staff SET ContactInfo = 'john.doe@newdomain.com' WHERE StaffID = 'S001';
ROLLBACK;

-- Giao dịch 8: Thêm khách du lịch
START TRANSACTION;
INSERT INTO Tourists (TouristID, FullName, VisitDate, ZoneID, Feedback)
VALUES ('T001', 'Alice Smith', '2024-01-01', 'Z001', 'Great experience!');
ROLLBACK;

-- Giao dịch 9: Cập nhật thông tin khách du lịch
START TRANSACTION;
UPDATE Tourists SET Feedback = 'Amazing visit!' WHERE TouristID = 'T001';
ROLLBACK;

-- Giao dịch 10: Thêm sự kiện
START TRANSACTION;
INSERT INTO Events (EventID, EventName, Date, ZoneID, Description)
VALUES ('E001', 'Wildlife Conservation Workshop', '2024-06-15', 'Z001', 'Workshop on wildlife conservation');
ROLLBACK;

-- Giao dịch 11: Cập nhật thông tin sự kiện
START TRANSACTION;
UPDATE Events SET Description = 'Advanced workshop on wildlife protection techniques' WHERE EventID = 'E001';
ROLLBACK;

-- Giao dịch 12: Thêm loài động vật nguy cấp
START TRANSACTION;
INSERT INTO EndangeredSpecies (AnimalID, Threats, ProtectionMeasures)
VALUES ('A001', 'Habitat destruction', 'Protected areas, awareness campaigns');
ROLLBACK;

-- Giao dịch 13: Xóa loài động vật nguy cấp
START TRANSACTION;
DELETE FROM EndangeredSpecies WHERE AnimalID = 'A001';
ROLLBACK;

-- Giao dịch 14: Cập nhật thông tin loài động vật nguy cấp
START TRANSACTION;
UPDATE EndangeredSpecies SET Threats = 'Poaching' WHERE AnimalID = 'A001';
ROLLBACK;

-- Giao dịch 15: Thêm khu vực bảo vệ
START TRANSACTION;
INSERT INTO ParkZones (ZoneID, ZoneName, Area, Description)
VALUES ('Z001', 'Northern Park Zone', 150.5, 'Main conservation area for tigers');
ROLLBACK;

-- Giao dịch 16: Cập nhật thông tin khu vực bảo vệ
START TRANSACTION;
UPDATE ParkZones SET Area = 200.5 WHERE ZoneID = 'Z001';
ROLLBACK;

-- Giao dịch 17: Xóa khu vực bảo vệ
START TRANSACTION;
DELETE FROM ParkZones WHERE ZoneID = 'Z001';
ROLLBACK;

-- Giao dịch 18: Thêm thông tin vị trí động vật
START TRANSACTION;
INSERT INTO AnimalLocations (AnimalLocationID, AnimalID, ZoneID, DateObserved)
VALUES ('L001', 'A001', 'Z001', '2024-05-10');
ROLLBACK;

-- Giao dịch 19: Cập nhật thông tin vị trí động vật
START TRANSACTION;
UPDATE AnimalLocations SET DateObserved = '2024-06-15' WHERE AnimalLocationID = 'L001';
ROLLBACK;

-- Giao dịch 20: Thêm thông tin khách du lịch và sự kiện
START TRANSACTION;
INSERT INTO Tourists (TouristID, FullName, VisitDate, ZoneID, Feedback)
VALUES ('T002', 'Bob Johnson', '2024-07-20', 'Z002', 'Wonderful tour!');
INSERT INTO Events (EventID, EventName, Date, ZoneID, Description)
VALUES ('E002', 'Tiger Conservation Talk', '2024-07-20', 'Z002', 'Talk on tiger conservation efforts');
ROLLBACK;

-- Giao dịch 21: Cập nhật thông tin khách du lịch và sự kiện
START TRANSACTION;
UPDATE Tourists SET Feedback = 'Unforgettable experience!' WHERE TouristID = 'T002';
UPDATE Events SET Description = 'In-depth discussion on tiger conservation efforts' WHERE EventID = 'E002';
ROLLBACK;
