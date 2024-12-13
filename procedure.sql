USE vuonquocgia;

-- 1. Liệt kê các khu vực có nhiều sự kiện nhất và số lượng động vật xuất hiện
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

-- 2. Liệt kê danh sách nhân viên quản lý khu vực có động vật nguy cấp
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

-- 3. Liệt kê các sự kiện có động vật nguy cấp tham gia
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
