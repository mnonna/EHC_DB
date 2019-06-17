#procedury do wyciągania informacji z bazy na podstawie zadanych parametrów 
DELIMITER $$
CREATE PROCEDURE procedureClientSelectEmail(paramEmail VARCHAR(60))
BEGIN 

SELECT *FROM allehcclients WHERE `clientEmail` = paramEmail;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procedureSelectAllPESEL()
BEGIN

SELECT clientID,clientPESEL FROM clients ORDER BY clientID;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procedureClientSelectByPESEL(paramPESEL VARCHAR(11))
BEGIN 

SELECT *FROM allehcclients WHERE pesel = paramPesel;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procedureClientSelect(paramName VARCHAR(30), paramSurname VARCHAR(30), paramPESEL VARCHAR(11))
BEGIN 

SELECT *FROM allehcclients
WHERE `clientName` = paramName AND `clientSurname` = paramSurname AND pesel = paramPesel;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procedureShowClients()
BEGIN 

SELECT *FROM allehcclients;

END$$
DELIMITER ;


#DODAWANIE NOWEGO KLIENTA DO BAZY
DELIMITER $$
CREATE PROCEDURE procedureClientAdd(paramClName VARCHAR(30), paramClSurname VARCHAR(30), paramEMail VARCHAR(60),
									paramPhNumber VARCHAR(9),paramStreet VARCHAR(30), paramAddress VARCHAR(120),paramPostalCode VARCHAR(6),
                                    paramCity VARCHAR(50),paramPESEL VARCHAR(11),paramIDNum VARCHAR(8))
BEGIN
INSERT INTO clients (clientName,clientSurname,e_mail,phoneNumber,clientRegistrationTime,street,address,postalCode,
					city,clientPESEL,idCardNumber)
VALUES (paramClName, paramClSurname, paramEmail, paramPhNumber, NOW(),paramStreet,paramAddress,paramPostalCode,
		paramCity,paramPESEL,paramIDNum);

END$$
DELIMITER ;

## INFO O POKOJU NA PODSTAWIE NUMERU 
## Z UWZGLEDNIENIEM UPRAWNIEN ##
DELIMITER $$
CREATE PROCEDURE procedureRoomInfo(paramLabel SMALLINT, permissionParam TINYINT)
BEGIN

#ADMIN
IF (permissionParam=1) THEN
SELECT `clientID`,`clientName`, `clientSurname`, `clientEmail`, `pesel`, `roomLabel`,`roomDescription`, `totalPrice`,
 `reservationID`,`roomID`, `reservationStart`, `reservationEnd` FROM clientsandreservations WHERE `roomLabel`=paramLabel;
 
SELECT room.roomID AS 'roomID', room.label AS 'roomLabel', room.roomStatus AS 'roomStatus', room.capacity AS 'roomCapacity',
room.isCleaningNeeded AS 'cleaningNeeded',room.isServiceNeeded AS 'serviceNeeded', room.dayPrice AS 'dayPrice',
room.roomDescription AS 'roomDescription'
FROM room WHERE room.label = paramLabel;

#RECEPCJONISTKA
ELSEIF (permissionParam=3)THEN
SELECT `clientName`,`clientSurname`,`pesel`,`roomLabel`,`reservationID`,`roomDescription`,
`reservationStart`,`reservationEnd` FROM clientsandreservations WHERE  `roomLabel`=paramLabel;

SELECT room.roomID AS 'roomID', room.label AS 'roomLabel', room.roomStatus AS 'roomStatus', room.capacity AS 'roomCapacity',
room.isCleaningNeeded AS 'cleaningNeeded',room.isServiceNeeded AS 'serviceNeeded', room.dayPrice AS 'dayPrice',
room.roomDescription AS 'roomDescription'
FROM room WHERE room.label = paramLabel;

#SPRZĄTACZKA
ELSEIF (permissionParam=2)THEN
SELECT room.roomID AS 'roomID', room.label AS 'roomLabel', room.roomStatus AS 'roomStatus', room.capacity AS 'roomCapacity',
room.isCleaningNeeded AS 'cleaningNeeded',room.dayPrice AS 'dayPrice',room.roomDescription AS 'roomDescription'
FROM room WHERE room.label = paramLabel;

#SERWISANT
ELSEIF(permissionParam=4)THEN
SELECT room.roomID AS 'roomID', room.label AS 'roomLabel', room.roomStatus AS 'roomStatus', room.capacity AS 'roomCapacity',
room.isServiceNeeded AS 'serviceNeeded', room.dayPrice AS 'dayPrice',room.roomDescription AS 'roomDescription'
FROM room WHERE room.label = paramLabel;

END IF;

END$$
DELIMITER ;

#INFO O POKOJACH NA DANYM PIETRZE
DELIMITER $$
CREATE PROCEDURE procedureTakeRoomOnFloor(paramFloorNumber TINYINT, permissionParam TINYINT)
BEGIN

#ADMIN
IF (permissionParam=1) THEN
SELECT room.roomID AS 'roomID', room.floorNumber AS 'floorNumber',
room.label AS 'roomLabel', room.roomStatus AS 'roomStatus', 
room.capacity AS 'roomCapacity', room.isCleaningNeeded AS 'cleaningNeeded',
room.isServiceNeeded AS 'serviceNeeded', room.dayPrice AS 'dayPrice',
room.roomDescription AS 'roomDescription'
FROM room WHERE room.floorNumber = paramFloorNumber;

#RECEPCJONISTKA
ELSEIF (permissionParam=3)THEN
SELECT room.roomID AS 'roomID', room.floorNumber AS 'floorNumber', 
room.label AS 'roomLabel', room.roomStatus AS 'roomStatus', 
room.capacity AS 'roomCapacity',room.isCleaningNeeded AS 'cleaningNeeded',
room.isServiceNeeded AS 'serviceNeeded', room.dayPrice AS 'dayPrice',
room.roomDescription AS 'roomDescription'
FROM room WHERE room.floorNumber = paramFloorNumber;

#SPRZĄTACZKA
ELSEIF (permissionParam=2)THEN
SELECT room.roomID AS 'roomID', room.floorNumber AS 'floorNumber', 
room.label AS 'roomLabel', room.roomStatus AS 'roomStatus', 
room.capacity AS 'roomCapacity', room.isCleaningNeeded AS 'cleaningNeeded',
room.dayPrice AS 'dayPrice',room.roomDescription AS 'roomDescription'
FROM room WHERE room.floorNumber = paramFloorNumber;

#SERWISANT
ELSEIF(permissionParam=4)THEN
SELECT room.roomID AS 'roomID', room.floorNumber AS 'floorNumber', 
room.label AS 'roomLabel', room.roomStatus AS 'roomStatus', 
room.capacity AS 'roomCapacity', room.isServiceNeeded AS 'serviceNeeded', 
room.dayPrice AS 'dayPrice',room.roomDescription AS 'roomDescription'
FROM room WHERE room.floorNumber = paramFloorNumber;

END IF;

END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE procedureAddRoom(paramFloorNumber TINYINT,paramLabel SMALLINT ,paramDayPrice SMALLINT, 
								  paramRoomDesc VARCHAR(1000),paramCapacity TINYINT)
BEGIN

INSERT INTO room 
(floorNumber,label,room.roomStatus,room.dayPrice,room.isCleaningNeeded, room.isServiceNeeded,room.roomDescription, room.capacity)
VALUES 
(paramFloorNumber, paramLabel, 0, paramDayPrice, FALSE, FALSE, paramRoomDesc, paramCapacity);

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE makeRoomReservation(paramLabel SMALLINT, paramPesel VARCHAR(11), paramStart DATETIME, paramEnd DATETIME,
									paramAdvance SMALLINT,paramPeopleAmmount SMALLINT)
BEGIN

INSERT INTO reservation 
(fk_clientID,fk_roomID,reservation.reservationStatus,reservation.reservationStart,
reservationEnd,advanceValue,advanceStatus,peopleAmmount)
VALUES
((SELECT clients.clientID FROM clients WHERE clients.clientPESEL=paramPesel),
 (SELECT room.roomID FROM room WHERE room.label=paramLabel),0 ,paramStart,
 paramEnd,paramAdvance,0,paramPeopleAmmount);

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procedureDeleteReservation(paramResID INT)
BEGIN

DELETE FROM reservation WHERE reservation.resID = paramResID;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE markAdvanceAsPaid(paramResID INT)
BEGIN 

UPDATE reservation SET reservation.advanceStatus = 1 WHERE reservation.resID = paramResID;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE markAdvanceNotPaid(paramResID INT)
BEGIN 

UPDATE reservation SET reservation.advanceStatus = 0 WHERE reservation.resID = paramResID;

END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE markRoomAsReserved(paramLabel SMALLINT)
BEGIN 

SELECT reservation.resID FROM reservation ORDER BY reservation.resID DESC LIMIT 1;

UPDATE room SET room.roomStatus=1 WHERE label = paramLabel;

END$$
DELIMITER ;


#Wybieranie dostępnych pokoi na piętrze w zadanym terminie#
DELIMITER $$
CREATE PROCEDURE procedureChooseAvailableRoomsAllFloors(paramStart DATETIME, paramEnd DATETIME)
BEGIN

SELECT room.roomID AS 'roomID', room.floorNumber AS 'floorNumber', 
room.label AS 'roomLabel',room.roomStatus AS 'roomStatus',
room.capacity AS 'roomCapacity',room.isCleaningNeeded AS 'cleaningNeeded', 
room.isServiceNeeded AS 'serviceNeeded',room.dayPrice AS 'dayPrice', 
room.roomDescription AS 'roomDescription'
FROM room WHERE room.roomID NOT IN 
(SELECT reservation.fk_roomID FROM reservation
WHERE (reservation.reservationStart < paramEnd AND reservation.reservationEnd >= paramEnd) -- overlap na koncu
OR (reservation.reservationStart <= paramStart AND reservation.reservationEnd > paramStart) -- overlap na poczatku
OR (reservation.reservationStart >= paramStart AND reservation.reservationEnd <= paramEnd) -- calkowity overlap
ORDER BY reservation.fk_roomID 
);

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procedureChooseAvailableWithZero(paramFloor TINYINT)
BEGIN 

SELECT room.floorNumber,room.label,room.dayPrice,room.dayPrice,room.roomStatus,room.capacity
FROM room WHERE room.floorNumber=paramFloor AND room.roomStatus=0;

END$$
DELIMITER ;

##########################################################################
#Usuwanie pokoju#
DELIMITER $$
CREATE PROCEDURE deleteRoom(paramLabel SMALLINT)
BEGIN

DELETE FROM room WHERE label = paramLabel;

END $$
DELIMITER ;
	
    
DELIMITER $$
CREATE PROCEDURE takeAllRooms()
BEGIN

SELECT *FROM allhotelrooms;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE takeOneRoom(paramLabel SMALLINT)
BEGIN

SELECT *FROM allhotelrooms 
WHERE `roomLabel`=paramLabel;

END$$
DELIMITER ;

#Dodawanie użytkownika do systemu EHC
DELIMITER $$
CREATE PROCEDURE addEhcUser(paramEmail VARCHAR(60),paramPermission TINYINT)
BEGIN 

INSERT INTO users (permissionGiven, userLogin) VALUES (paramPermission, paramEmail);

END $$
DELIMITER ;

#Usuwanie użytkownika z EHC po emailu#
DELIMITER $$ 
CREATE PROCEDURE deleteEhcUser(paramEmail VARCHAR(60))
BEGIN

DELETE FROM users WHERE users.userLogin = paramEmail;

END $$
DELIMITER ;

##UŻYTKOWNIK PO EMAIL##
DELIMITER $$
CREATE PROCEDURE selectUser (paramEmail VARCHAR(60))
BEGIN

SELECT *FROM allusers WHERE `userLogin`=paramEmail;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE selectAllUsers ()
BEGIN

SELECT *FROM allusers;

END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE selectUserEmails (paramPermission TINYINT)
BEGIN

SELECT `userLogin` FROM allusers WHERE `permissionID`=paramPermission;

END$$
DELIMITER ;


#Update ostatniego sprzątania pokoju - sprzątaczka#
DELIMITER $$
CREATE PROCEDURE updateRoomLastCleaning (paramLabel SMALLINT, paramUserEmail VARCHAR(60))
BEGIN

UPDATE room SET room.lastClean=NOW() WHERE room.label = paramLabel;
UPDATE room SET room.staffID = (SELECT userID FROM users WHERE users.userLogin=paramUserEmail)
WHERE room.label = paramLabel;

UPDATE room SET room.isCleaningNeeded = FALSE WHERE room.label = paramLabel;

END$$
DELIMITER ;

#Update ostatniego serwisu pokoju - majster#
DELIMITER $$
CREATE PROCEDURE updateRoomLastService (paramLabel SMALLINT, paramUserEmail VARCHAR(60))
BEGIN

UPDATE room SET room.lastService=NOW() WHERE room.label = paramLabel;
UPDATE room SET room.staffID = (SELECT userID FROM users WHERE users.userLogin=paramUserEmail)
WHERE room.label = paramLabel;

UPDATE room SET room.isServiceNeeded = FALSE WHERE room.label = paramLabel;

END$$
DELIMITER ;

#Zmiana statusu pokoju - potrzebne sprzątanie#
DELIMITER $$
CREATE PROCEDURE changeCleaningState(paramLabel SMALLINT)
BEGIN 

UPDATE room SET room.isCleaningNeeded = TRUE WHERE room.label = paramLabel;

END$$
DELIMITER ;

#Zmiana statusu pokoju - potrzebny serwis#
DELIMITER $$
CREATE PROCEDURE changeServiceState(paramLabel SMALLINT)
BEGIN 

UPDATE room SET room.isServiceNeeded = TRUE WHERE room.label = paramLabel;

END$$
DELIMITER ;

#WIDOK POKOI POTRZEBUJĄCYCH SPRZĄTANIA#
DELIMITER $$
CREATE PROCEDURE showRoomWhereCleaningNeeded()
BEGIN

SELECT `roomLabel`,`lastCleaning`,`cleaningNeeded` FROM hotelroominfostate WHERE `cleaningNeeded`=TRUE
		ORDER BY `roomLabel` ASC;

END$$
DELIMITER ;

#WIDOK POKOI POTRZEBUJĄCYCH SERWISU#
DELIMITER $$
CREATE PROCEDURE showRoomWhereServiceNeeded()
BEGIN

SELECT `roomLabel`,`lastService`,`serviceNeeded` FROM hotelroominfostate WHERE `serviceNeeded`=TRUE
		ORDER BY `roomLabel` ASC;

END$$
DELIMITER ;

#ZAMAWIANIE USŁUGI DODATKOWEJ - usługa cechowana czasowo#
DELIMITER $$
CREATE PROCEDURE reserveAdditionalTimeTypedService(paramPesel VARCHAR (11),paramResID INT,paramStart DATETIME,
												   paramEnd DATETIME, paramServiceNum TINYINT)
BEGIN

INSERT INTO clientsservices
(clientID,fk_resID,serviceID,serviceStart,serviceEnd)
VALUES 
((SELECT clientID FROM clients WHERE clients.clientPESEL = paramPesel),
paramResID,paramServiceNum, paramStart, paramEnd);

END$$
DELIMITER ;


#ZAMAWIANIE USŁUGI DODATKOWEJ - usługa cechowana sztukami#
DELIMITER $$
CREATE PROCEDURE reserveAdditionalItemTypedService(paramPesel VARCHAR (11),paramResID INT, paramStart DATETIME,
												   paramServiceNum TINYINT, paramItemsNumber TINYINT)
BEGIN

INSERT INTO clientsservices
(clientID,fk_resID,fk_itserviceID,serviceStart,itemsNumber) 
VALUES 
((SELECT clientID FROM clients WHERE clients.clientPESEL=paramPesel),paramResID,
paramServiceNum, paramStart,paramItemsNumber);

END$$
DELIMITER ;

##WYBÓR REZERWACJI PRZEZ ID oraz Nazwisko klienta##
DELIMITER $$
CREATE PROCEDURE selectReservation(paramResID INT)
BEGIN

SELECT *FROM clientsandreservations WHERE `reservationID` = paramResID;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE selectReservationEndingOn(paramEnd DATETIME)
BEGIN

SELECT *FROM clientsandreservations WHERE date(`reservationEnd`) = date(paramEnd);

END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE selectReservationByRoom(paramLabel SMALLINT)
BEGIN

SELECT *FROM roomsreservations WHERE `roomLabel` = paramLabel;

END$$
DELIMITER ;
#############################################

DELIMITER $$
CREATE PROCEDURE procedureRoomInfoState(paramLabel SMALLINT)
BEGIN

SELECT `roomLabel`,`roomID`,`lastCleaning`,`lastService`,`cleaningNeeded`,`serviceNeeded`,`roomCapacity`,`roomState`
FROM hotelroominfostate WHERE `roomLabel` = paramLabel;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procedureReturnFloorNumber()
BEGIN 

SELECT MAX(room.floorNumber) AS `floorsAmount` FROM room;

END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE procedureSendReservationInfo()
BEGIN 

SELECT `clientName`,`clientSurname`,`roomLabel`,`reservationStart`,`reservationEnd`,`totalPrice` FROM clientsandreservations 

WHERE	`reservationID`=last_insert_id(); 

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procedureReturnPresentPeopleNumber()
BEGIN 

SELECT sum(`peopleAmmount`) AS 'totalPeoples' FROM roomsreservations WHERE `roomStatus`= 2 AND `reservationStatus` = 1;

END$$
DELIMITER ;

## ZAMELDOWANIE AKTYWACJA REZERWACJI##
DELIMITER $$
CREATE PROCEDURE procedureActivateReservation(paramResID INT)
BEGIN 

UPDATE reservation SET reservation.reservationStatus = 1 WHERE reservation.resID=paramResID;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procedureActivateReservedRoom(paramLabel SMALLINT)
BEGIN 

UPDATE room SET room.roomStatus = 2 WHERE room.label = paramLabel ;

END$$
DELIMITER ;

###########################################
# WYMELDOWANIE #
DELIMITER $$
CREATE PROCEDURE procedureCheckOutOfEHC(paramResID INT)
BEGIN 

UPDATE reservation SET reservation.reservationStatus = 2 
WHERE reservation.resID = paramResID;

END $$
DELIMITER ;

## USTAWIENIE ODPOWIEDNIEGO ROOM STATE PO WYMELDOWANIU , albo 0 - wolny z brakiem dalszych rezerwacji 
## albo na 1 - istnieją dalsze rezerwacje ale nie ma nikogo na pokoju##
DELIMITER $$
CREATE PROCEDURE procedureSetValidRoomState(paramLabel SMALLINT)
BEGIN 	

IF (SELECT reservation.resID FROM reservation WHERE reservation.fk_roomID IN
   (SELECT room.roomID FROM room WHERE room.label = paramLabel) AND reservation.reservationStatus = 0) 
IS NULL

THEN
UPDATE room SET room.roomStatus = 0 WHERE room.label = paramLabel ;
ELSE
UPDATE room SET room.roomStatus = 1 WHERE room.label = paramLabel ;
END IF;

END$$
DELIMITER ;
####################################################

DELIMITER $$
CREATE PROCEDURE chooseClientEmailWhereRoomDeleted(paramLabel SMALLINT)
BEGIN 

SELECT `clientEmail` FROM clientsandreservations WHERE `roomLabel` = paramLabel;

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procedureReservationBillUp(paramResID INT)
BEGIN 

SELECT abs(datediff(reservation.reservationStart,reservation.reservationEnd))*room.dayPrice AS 'reservationPrice',
	   sum(HOUR(timediff(clientsservices.serviceEnd,clientsservices.serviceStart))*services.serviceHourPrice) AS 'timeServicesPrice',
       sum(clientsservices.itemsNumber * itemservices.serviceItemPrice) AS 'itemServicesPrice',

       (abs(datediff(reservation.reservationStart,reservation.reservationEnd))*room.dayPrice +
       sum(HOUR(timediff(clientsservices.serviceEnd,clientsservices.serviceStart))*services.serviceHourPrice) +
       sum(clientsservices.itemsNumber * itemservices.serviceItemPrice)) AS 'totalPrice'
       
       FROM reservation 
       JOIN room ON room.roomID = (SELECT reservation.fk_roomID FROM reservation WHERE reservation.resID=paramResID)
       LEFT JOIN clientsservices ON clientsservices.fk_resID = paramResID 
       LEFT JOIN services ON services.serviceID = clientsservices.serviceID
       LEFT JOIN itemservices ON clientsservices.fk_itserviceID = itemservices.itserviceID
       WHERE reservation.resID = paramResID;

END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE makeDailyReport()
BEGIN

SELECT coalesce(sum(reservation.peopleAmmount),0) AS 'totalPeoples', (SELECT count(room.roomID) FROM room WHERE roomStatus = 2 ) AS 'busyRooms',
(SELECT count(roomID) FROM room WHERE roomStatus = 1 OR roomStatus = 0) AS 'freeRooms', 
(SELECT coalesce(sum(room.dayPrice), 0) FROM room WHERE room.roomStatus = 2) AS 'dayIncome', date(now()) AS 'currentDate' 
FROM reservation 
LEFT JOIN room 
ON reservation.fk_roomID = room.roomID
WHERE (reservation.reservationStatus = 1 ); 

END $$
DELIMITER ;

## WYBÓR WSZYSTKICH REZERWACJI ##
DELIMITER $$
CREATE PROCEDURE selectAllReservations()
BEGIN

SELECT *FROM roomsreservations;

END $$
DELIMITER ;

## REZERWACJE PO DZISIEJSZEJ DACIE ##
DELIMITER $$
CREATE PROCEDURE selectReservationsPastNow()
BEGIN

SELECT *FROM roomsreservations WHERE date(`reservationStart`) >= date(now());

END $$
DELIMITER ;