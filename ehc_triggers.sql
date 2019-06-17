########### TRIGGERY - zapobieganie niepożądanym insertom do tablic ############
#preventReservationOnNonExistingRoom - zapobieganie rezerwacji na nie istniejący pokój#
DELIMITER //
CREATE TRIGGER preventReservationOnNonExistingRoom BEFORE INSERT ON reservation
FOR EACH ROW 
BEGIN 
IF NEW.fk_roomID IS NULL
THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Seems that given room does not exist. Please check the existing ones.';
END IF;
END; //
DELIMITER ;
#########

##rezerwacja na nieistniejącego klienta##
DELIMITER //
CREATE TRIGGER preventReservationOnNonExistingClient BEFORE INSERT ON reservation
FOR EACH ROW 
BEGIN 
IF NEW.fk_clientID IS NULL
THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Seems that client does not exist. Please check the existing ones.';
END IF;
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER preventInvalidServiceBooking BEFORE INSERT ON clientsservices
FOR EACH ROW 
BEGIN 
IF (NEW.clientID IS NULL)
THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'You have just done invalid service booking. Please check the data.';
END IF;
END; //
DELIMITER ;
