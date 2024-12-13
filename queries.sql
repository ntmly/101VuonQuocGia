USE vuonquocgia;

-- TRUY VẤN SỬ DỤNG INNER JOIN
-- 1. Nhân viên nghiên cứu các động vật nguy cấp
SELECT DISTINCT s.StaffID, s.FullName, a.AnimalID, a.CommonName, es.Threats FROM staff s
JOIN research r on s.StaffID = r.StaffID
JOIN animals a on r.AnimalID = a.AnimalID
JOIN endangeredspecies es on a.AnimalID = es.AnimalID;

-- 2. Các khu vực có ít nhất 3 sự kiện và các loài động vật xuất hiện tại khu vực đó
SELECT pz.ZoneName, COUNT(DISTINCT e.EventID) AS EventCount, COUNT(DISTINCT al.AnimalLocationID) as ObservationCount
FROM parkzones pz
JOIN events e ON pz.ZoneID = e.ZoneID
JOIN animallocations al on pz.ZoneID = al.ZoneID
GROUP BY pz.ZoneName
HAVING COUNT(e.EventID) >= 10
ORDER BY EventCount DESC;

-- 3. Những động vật vừa có trong nghiên cứu khoa học, vừa xuất hiện trong chuyến tham quan và thuộc danh sách động vật nguy cấp
SELECT DISTINCT a.AnimalID, a.CommonName
FROM animals a
JOIN research r on a.AnimalID = r.AnimalID
JOIN animallocations al ON a.AnimalID = al.AnimalID
JOIN parkzones pz ON al.ZoneID = pz.ZoneID
JOIN tourists t ON pz.ZoneID = t.ZoneID
WHERE a.AnimalID in (SELECT a.AnimalID
		     FROM animals a
		     JOIN endangeredspecies es ON a.AnimalID = es.AnimalID);
					
-- 4. Số lượng động vật nguy cấp của từng môi trường sống
SELECT h.HabitatID, h.HabitatType, COUNT(a.AnimalID) as EndangeredSpeciesCount
FROM habitats h
JOIN animals a on h.HabitatID = a.HabitatID
WHERE a.AnimalID IN (SELECT AnimalID FROM endangeredspecies)
GROUP BY h.HabitatID;

-- 5. Các khu vực có động vật nguy cấp và những nghiên cứu được thực hiện về chúng
SELECT pz.ZoneID, a.AnimalID, a.CommonName, r.ResearchID, r.Title
FROM parkzones pz
JOIN animallocations al ON pz.ZoneID = al.ZoneID
JOIN animals a ON al.AnimalID = a.AnimalID
JOIN endangeredspecies es ON a.AnimalID = es.AnimalID
LEFT JOIN research r ON a.AnimalID = r.AnimalID;

-- 6. Liệt kê các sự kiện và tên nhân viên quản lý khu vực tổ chức
SELECT e.EventID, pz.ZoneID, pz.ZoneName
FROM events e
JOIN parkzones pz ON e.ZoneID = pz.ZoneID
JOIN staff s on pz.ZoneID = s.ZoneID
ORDER BY e.EventID;

-- 7. Xếp loại những khu vực có nhiều động vật được nghiên cứu nhất
SELECT pz.ZoneID, pz.ZoneName, COUNT(r.ResearchID) AS ResearchCount
FROM parkzones pz
JOIN animallocations al ON pz.ZoneID = al.ZoneID
JOIN animals a ON al.AnimalID = a.AnimalID
JOIN research r ON a.AnimalID = r.AnimalID
GROUP BY pz.ZoneID
ORDER BY ResearchCount DESC;

-- 8. Các sự kiện có nhiều loài động vật nhất được quan sát
SELECT e.EventName, pz.ZoneName, COUNT(DISTINCT a.AnimalID) AS AnimalCount
FROM events e
JOIN parkzones pz ON e.ZoneID = pz.ZoneID
JOIN animallocations al ON pz.ZoneID = al.ZoneID
JOIN animals a ON al.AnimalID = a.AnimalID
GROUP BY e.EventName, pz.ZoneName
ORDER BY AnimalCount DESC;

-- TRUY VẤN SỬ DỤNG SUBQUERY TRONG FROM
-- 1. Liệt kê các khu vực và số lượng lần quan sát được các động vật ở mỗi khu vực
SELECT pz.ZoneName, animal_data.AnimalCount
FROM (SELECT al.ZoneID, COUNT(DISTINCT al.AnimalID) AS AnimalCount
     FROM animallocations al
     GROUP BY al.ZoneID) AS animal_data
JOIN parkzones pz ON animal_data.ZoneID = pz.ZoneID;

-- 2. Liệt kê các loài động vật, số lượng nghiên cứu liên quan đến từng loài, và số lượng nhân viên phụ trách
SELECT animal_data.AnimalID, animal_data.ResearchCount, staff_data.StaffCount
FROM (SELECT a.AnimalID, a.CommonName, COUNT(DISTINCT r.ResearchID) AS ResearchCount
     FROM animals a
     LEFT JOIN research r ON a.AnimalID = r.AnimalID
     GROUP BY a.AnimalID, a.CommonName) AS animal_data
JOIN (SELECT r.AnimalID, COUNT(DISTINCT r.StaffID) AS StaffCount
     FROM research r
     GROUP BY r.AnimalID) AS staff_data
ON animal_data.AnimalID = staff_data.AnimalID;

-- 3. Liệt kê các động vật nguy cấp và số lượng sự kiện liên quan đến chúng
SELECT endangered_data.AnimalID, endangered_data.CommonName, endangered_data.EventCount
FROM (SELECT a.AnimalID, a.CommonName, COUNT(DISTINCT e.EventID) AS EventCount
     FROM animals a
     JOIN endangeredspecies es ON a.AnimalID = es.AnimalID
     JOIN animallocations al ON a.AnimalID = al.AnimalID
     JOIN events e ON al.ZoneID = e.ZoneID
     GROUP BY a.AnimalID, a.CommonName) AS endangered_data;
    
-- 4. Liệt kê các khu vực và các loài động vật xuất hiện trong khu vực đó, cũng như nhân viên quản lý
SELECT zone_data.ZoneName, zone_data.CommonName, zone_data.FullName as Manager
FROM (SELECT pz.ZoneID, pz.ZoneName, a.CommonName, s.FullName
     FROM ParkZones pz
     JOIN AnimalLocations al ON pz.ZoneID = al.ZoneID
     JOIN Animals a ON al.AnimalID = a.AnimalID
     JOIN Staff s ON pz.ZoneID = s.ZoneID) AS zone_data;
     
-- 5. Liệt kê các khu và các động vật xuất hiện tại các khu vực đó 
SELECT animal_data.ZoneName, 
    GROUP_CONCAT(animal_data.CommonName ORDER BY animal_data.CommonName SEPARATOR ', ') AS Animals
FROM (SELECT pz.ZoneName, a.CommonName
     FROM ParkZones pz
     JOIN AnimalLocations al ON pz.ZoneID = al.ZoneID
     JOIN Animals a ON al.AnimalID = a.AnimalID) AS animal_data
GROUP BY animal_data.ZoneName;
