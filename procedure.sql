USE vuonquocgia;

-- 1. Lấy thông tin động vật theo môi trường sống
DELIMITER //
CREATE PROCEDURE GetAnimalsByHabitat(IN HabitatID VARCHAR(50))
BEGIN
    SELECT a.AnimalID, a.CommonName, h.HabitatType, al.ZoneID, pz.ZoneName
    FROM Animals a
    JOIN AnimalLocations al ON a.AnimalID = al.AnimalID
    JOIN ParkZones pz ON al.ZoneID = pz.ZoneID
    JOIN Habitats h ON a.HabitatID = h.HabitatID  
    WHERE h.HabitatID = HabitatID  
    ORDER BY a.CommonName; 
END //
DELIMITER ;

CALL GetAnimalsByHabitat('H001');
CALL GetAnimalsByHabitat('H005');

-- 2. Lấy thông tin nhân viên phụ trách các khu vực
DELIMITER //
CREATE PROCEDURE GetStaffByZone(IN StaffID VARCHAR(50))
BEGIN
    SELECT s.StaffID, s.FullName, pz.ZoneName
    FROM Staff s
    JOIN ParkZones pz ON s.ZoneID = pz.ZoneID
    WHERE s.StaffID = StaffID  
    ORDER BY pz.ZoneName; 
END //
DELIMITER ;

CALL GetStaffByZone('S001');
CALL GetStaffByZone('S009');

-- 3. Liệt kê các khu vực có nhiều sự kiện nhất và số lượng động vật xuất hiện
DELIMITER //
CREATE PROCEDURE GetTopEventZones()
BEGIN
    SELECT pz.ZoneName, COUNT(DISTINCT e.EventID) AS TotalEvents, COUNT(DISTINCT a.AnimalID) AS TotalAnimals
    FROM parkzones pz
    LEFT JOIN Events e ON pz.ZoneID = e.ZoneID
    LEFT JOIN animallocations al ON pz.ZoneID = al.ZoneID
    LEFT JOIN animals a ON al.AnimalID = a.AnimalID
    GROUP BY pz.ZoneID
    ORDER BY TotalEvents DESC, TotalAnimals DESC
    LIMIT 5;
END //
DELIMITER ;

CALL GetTopEventZones();

-- 4. Liệt kê danh sách nhân viên quản lý khu vực có động vật nguy cấp
DELIMITER //
CREATE PROCEDURE GetStaffManagingEndangeredZones()
BEGIN
    SELECT s.FullName, pz.ZoneName, COUNT(DISTINCT es.AnimalID) AS TotalEndangeredAnimals
    FROM  staff s
    JOIN parkzones pz ON s.ZoneID = pz.ZoneID
    JOIN animallocations al ON pz.ZoneID = al.ZoneID
    JOIN EndangeredSpecies es ON al.AnimalID = es.AnimalID
    GROUP BY s.StaffID, pz.ZoneID
    HAVING TotalEndangeredAnimals > 0
    ORDER BY TotalEndangeredAnimals DESC;
END //
DELIMITER ;

CALL GetStaffManagingEndangeredZones();

-- 5. Liệt kê các sự kiện có động vật nguy cấp tham gia
DELIMITER //
CREATE PROCEDURE GetEventsWithEndangeredAnimals()
BEGIN
    SELECT e.EventName, pz.ZoneName,
        GROUP_CONCAT(DISTINCT es.AnimalID ORDER BY es.AnimalID SEPARATOR ', ') AS EndangeredAnimals
    FROM events e
    JOIN parkzones pz ON e.ZoneID = pz.ZoneID
    JOIN animallocations al ON pz.ZoneID = al.ZoneID
    JOIN endangeredspecies es ON al.AnimalID = es.AnimalID
    GROUP BY e.EventID, pz.ZoneID
    HAVING EndangeredAnimals IS NOT NULL
    ORDER BY e.EventName;
END //
DELIMITER ;

CALL GetEventsWithEndangeredAnimals();


