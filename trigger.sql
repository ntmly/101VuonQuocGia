use vuonquocgia;

-- 1. Ngăn chặn xóa khu vực (Park Zone) nếu có động vật hoặc nhân viên liên quan
DELIMITER $$
CREATE TRIGGER trg_PreventDeleteZone
BEFORE DELETE ON ParkZones
FOR EACH ROW
BEGIN
    -- Kiểm tra xem có động vật nào trong khu vực không
    IF EXISTS (SELECT 1 FROM Animals WHERE HabitatID = OLD.ZoneID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete a zone that contains animals.';
    END IF;

    -- Kiểm tra xem có nhân viên nào được phân công trong khu vực không
    IF EXISTS (SELECT 1 FROM Staff WHERE ZoneID = OLD.ZoneID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete a zone assigned to staff.';
    END IF;
END $$
DELIMITER ;

-- 2. Tự động cập nhật ngày hiện tại khi thêm quan sát vào AnimalLocations
DELIMITER $$
CREATE TRIGGER trg_SetDefaultObservationDate
BEFORE INSERT ON AnimalLocations
FOR EACH ROW
BEGIN
    IF NEW.DateObserved IS NULL THEN
        SET NEW.DateObserved = CURDATE();
    END IF;
END $$
DELIMITER ;

-- 3. Ngăn xóa nhân viên nếu họ đang tham gia nghiên cứu
DELIMITER $$
CREATE TRIGGER trg_PreventDeleteStaff
BEFORE DELETE ON Staff
FOR EACH ROW
BEGIN
    DECLARE staffInResearch INT;

    -- Kiểm tra xem nhân viên có tham gia nghiên cứu không
    SELECT COUNT(*) INTO staffInResearch
    FROM Research
    WHERE StaffID = OLD.StaffID;

    -- Nếu nhân viên tham gia nghiên cứu, phát sinh lỗi
    IF staffInResearch > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete a staff member involved in research.';
    END IF;
END $$
DELIMITER ;

-- 4. Tạo thông báo cho nhân viên khi có động vật mới được phát hiện
DELIMITER $$
CREATE TRIGGER trg_NotifyStaffOnNewAnimal
AFTER INSERT ON Animals
FOR EACH ROW
BEGIN
    -- Tạo thông báo cho nhân viên về động vật mới phát hiện
    INSERT INTO Notifications (StaffID, Message, DateCreated)
    SELECT StaffID, CONCAT('A new animal has been added: ', NEW.CommonName), CURDATE()
    FROM Staff WHERE ZoneID = NEW.HabitatID;
END $$
DELIMITER ;




