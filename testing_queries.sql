CALL procedureClientAdd('Body', 'Christ', 'body@bgc.com', '324561897','Al. Ujazdowskie','4A/7','66-558','Warszawa',
						'87130215687', 'WSD78654');
CALL procedureClientAdd('Bonus', 'BGC', 'łazarskirejon@bgc.com', '419753621','Caliera','3/2','61-895','Poznan',
						'91031048621', 'AMZ74598');
CALL procedureClientAdd('Marcin', 'Sprusiński', 'wuwunio@palhajs.com', '124532789','Kościuszki','7B/3','65-143',
						'Sosnowiec','87210564859', 'WXQ78244');
CALL procedureClientAdd('Tiger', 'Bonzo', 'tajger@bęc.com', '945378621','Przemysłowa','3','62-456','Łódz',
						'92130915324', 'TRA45678');
CALL procedureClientAdd('Jan', 'Kowalski', 'jkow@gmail.com', '168596124','Kościuszki','7B/3','65-143',
						'Sosnowiec','14250637891', 'SHW14523');


CALL procedureSelectAllPESEL();
CALL procedureClientSelectEmail('wuwunio@palhajs.com');
CALL procedureClientSelectByPESEL('87210564859');

#POKOJE / REZERWACJE##

#CALL procedureAddRoom(1,11,40,'Pokój standard dla jednej osoby - SGL. Zawiera: Łóżko, stolik nocny,
#					  garderobę, lampkę nocną, wieszak ścienny na odzież wierzchnią, prysznic, telefon, TV LED 30", WI-FI',1);
#CALL procedureAddRoom(1,12,120,'Pokój superior dla dwóch osób - DBL. Zawiera: Łóżko king size,klimatyzacja,
#					  wanna, telefon TV LED 50", WI-FI',2);
#CALL procedureAddRoom(1,13,90,'Pokój dwuosobowy z dwoma łóżkami - TWIN. Zawiera: Dwa łóżka (osobno), stoliki nocne,
#					  garderoba, lampka nocna, prysznic, telefon, TV LED 40", WI-FI',2);
#CALL procedureAddRoom(2,21,300,'Pokój deluxe dla dwóch osób. Zawiera: Łóżko king size, balkon - widok na morze,
#					  klimatyzacja, wanna, garderoba, ekspres do kawy, bezpłatny minibar, TV LED 60", WI-FI',3);
#CALL procedureAddRoom(2,22,120,'Pokój executive dla jednej osoby. Zawiera: Łóżko, stolik nocny,garderobę, biurko,
#			          lampkę nocną, wieszak ścienny na odzież wierzchnią, prysznic, telefon, TV LED 40", WI-FI',1);
#CALL procedureAddRoom(2,23,400,'Pokój rodzinny deluxe - maks.5 osób. Zawiera: Łóżko king size, balkon - widok na morze,
#                      dwa dodatkowe łóżka (osobno), klimatyzacja, wanna, garderoba, ekspres do kawy, bezpłatny minibar,
#                      konsola PS4, TV LED 60", WI-FI',5);
#CALL procedureAddRoom(2,24,350,'Pokój rodzinny deluxe - maks.5 osób. Zawiera: Łóżko king size, balkon - widok na morze,
#                      dwa dodatkowe łóżka (osobno), klimatyzacja, wanna, garderoba, ekspres do kawy, bezpłatny minibar,
#                      konsola PS4, TV LED 60", WI-FI',5);
#CALL procedureAddRoom(2,210,120,'Pokój executive dla jednej osoby. Zawiera: Łóżko, stolik nocny,garderobę, biurko,
#			          lampkę nocną, wieszak ścienny na odzież wierzchnią, prysznic, telefon, TV LED 40", WI-FI',1);


CALL procedureAddRoom(1,101,40,'SGL',1);
CALL procedureAddRoom(1,102,120,'DBL',2);
CALL procedureAddRoom(1,103,90,'TWIN',2);
CALL procedureAddRoom(2,201,300,'Deluxe',3);
CALL procedureAddRoom(2,202,120,'Executive SGL',1);
CALL procedureAddRoom(2,203,400,'Deluxe',5);
#CALL procedureAddRoom(2,24,350,'Deluxe',5);
CALL procedureAddRoom(2,205,40,'SGL',1);
CALL procedureAddRoom(2,206,90,'TWIN',2);
CALL procedureAddRoom(2,207,120,'Executive SGL',1);
CALL procedureAddRoom(2,208,350,'Deluxe',5);
CALL procedureAddRoom(2,209,40,'SGL',1);
CALL procedureAddRoom(2,210,90,'TWIN',2);
CALL procedureAddRoom(2,211,120,'Executive SGL',1);
CALL procedureAddRoom(2,212,120,'Executive SGL',1);

SELECT *FROM room;
SELECT *FROM allhotelrooms;

CALL makeRoomReservation(102,'92130915324','2019-06-18 18:00:00','2019-06-20 10:00:00',60,2);
CALL markRoomAsReserved(102);
CALL makeRoomReservation(103,'92130915324','2019-06-18 18:00:00','2019-06-20 10:00:00',60,2);
CALL markRoomAsReserved(103);
CALL makeRoomReservation(102,'87210564859','2019-07-22 18:00:00','2019-07-25 10:00:00',120,2);
CALL markRoomAsReserved(102);
CALL makeRoomReservation(101,'87210564859','2019-05-22 18:00:00','2019-05-23 10:00:00',120,2);
CALL markRoomAsReserved(101);
CALL makeRoomReservation(201,'91031048621','2019-05-20 18:00:00','2019-05-23 10:00:00',120,3);
CALL markRoomAsReserved(201);
CALL makeRoomReservation(202,'92130915324','2019-05-22 18:00:00','2019-05-25 10:00:00',120,1);
CALL markRoomAsReserved(202);
CALL makeRoomReservation(202,'87210564859','2019-06-18 18:00:00','2019-06-26 10:00:00',120,1);
CALL markRoomAsReserved(202);
CALL makeRoomReservation(103,'91031048621','2019-06-18 18:00:00','2019-06-26 10:00:00',90,2);
CALL markRoomAsReserved(103);
CALL makeRoomReservation(205,'87210564859','2019-06-15 18:00:00','2019-06-17 10:00:00',120,3);
CALL markRoomAsReserved(205);
CALL makeRoomReservation(211,'87210564859','2019-07-04 18:00:00','2019-07-07 10:00:00',70,1);
CALL markRoomAsReserved(211);
CALL markAdvanceAsPaid(2);
CALL markAdvanceNotPaid(2);
SELECT *FROM clientsandreservations;
SELECT last_insert_id();
CALL procedureSendReservationInfo();

#CALL makeRoomReservation(25,'17210564859','2019-06-15 18:00:00','2019-06-17 10:00:00',120,1,3);
#Wywołanie powyższego spowoduje włączenie triggera na rezerwację na klienta który nie istnieje 

# Wywołanie tego spowoduje uaktywnienie triggera - rezerwacja na nieistniejący pokój:
#CALL makeRoomReservation(24,'Marcin', 'Sprusiński','2019-06-15 18:00:00','2019-06-17 10:00:00',120,1,3);

CALL selectAllReservations();
CALL selectReservation(5);
CALL selectReservationsPastNow();
CALL chooseClientEmailWhereRoomDeleted(102);
CALL deleteRoom(102);
SELECT *FROM reservation;

CALL selectReservationByRoom(103);
CALL selectReservationByRoom(201);
CALL selectReservationEndingOn('2019-06-20 10:00:00');

SELECT *FROM roomsreservations;

#CALL procedureDeleteReservation(6);

CALL procedureTakeRoomOnFloor(1,1);
CALL procedureTakeRoomOnFloor(1,2);
CALL procedureTakeRoomOnFloor(1,3);
CALL procedureTakeRoomOnFloor(1,4);

CALL TakeAllRooms();

## ZAMELDOWANIE ##
CALL procedureActivateReservation(10);
CALL procedureActivateReservedRoom(103);
#################
CALL procedureReturnPresentPeopleNumber();

## WYMELDOWANIE ##
CALL procedureCheckOutOfEHC(10);
CALL procedureSetValidRoomState(103);

########################
SELECT *FROM roomsreservations;
SELECT *FROM allhotelrooms;
CALL makeDailyReport();
CALL selectAllReservations();

##UŻYTKOWNICY##
###################################
INSERT INTO permissions (permissionDescription) VALUES ('ADMIN');
INSERT INTO permissions (permissionDescription) VALUES ('RECEPTIONIST');
INSERT INTO permissions (permissionDescription) VALUES ('CLEANING LADY');
INSERT INTO permissions (permissionDescription) VALUES ('SERVICE MAN');
INSERT INTO permissions (permissionDescription) VALUES ('CHEF');
INSERT INTO permissions (permissionDescription) VALUES ('GUEST');

CALL addEhcUser('easyhotelcontrol@gmail.com',1);

CALL addEhcUser('marcinnonna026@gmail.com',1);
CALL addEhcUser('lperski@ehc.pl',1);
CALL addEhcUser('skobkowiak@ehc.pl',2);
CALL addEhcUser('sylwia@ehc.pl',3);
CALL addEhcUser('jadzia@ehc.pl',4);
CALL addEhcUser('bonus@ehc.pl',5);
CALL addEhcUser('wndwa@ehc.pl',6);
CALL selectAllUsers();
CALL selectUserEmails(1);
SELECT *FROM allehcclients;

##SPRZĄTACZKA I MAJSTER##
CALL changeCleaningState(101);
CALL changeCleaningState(205);
CALL changeCleaningState(103);
CALL changeServiceState(101);
CALL changeServiceState(205);
CALL showRoomWhereCleaningNeeded();
CALL showRoomWhereServiceNeeded();
CALL procedureRoomInfo(205,1); ## ADM
CALL procedureRoomInfo(205,2); ## CLE
CALL procedureRoomInfo(205,3); ## REC
CALL procedureRoomInfo(205,4); ## SER
CALL procedureRoomInfoState(102);

CALL procedureChooseAvailableRoomsAllFloors('2019-04-10 18:00:00','2019-06-25 10:00:00'); #ADM

#AKTUALNE##
CALL updateRoomLastCleaning(101,'sylwia@ehc.pl');
CALL updateRoomLastService(101,'jadzia@ehc.pl');
#####

SELECT *FROM services;

## JUŻ DZIAŁA :D ##
CALL reserveAdditionalTimeTypedService('87210564859',8,'2019-07-05 12:00:00','2019-07-05 15:00:00',3);
CALL reserveAdditionalItemTypedService('87210564859',8,'2019-07-06 19:00:00',1,2);
CALL procedureReservationBillUp(8);
##########################

SELECT *FROM additionalservices;
SELECT *FROM clientsservices;

##AKTUALNE UŻYTKOWNIK EHC###
CALL addEhcUser('bonus@ehc.cs',3);
CALL selectUser('bonus@ehc.cs');
CALL deleteEhcUser('bonus@ehc.cs');
SELECT *FROM users;

##WYBÓR KLIENTA PO MAILU##
CALL procedureClientSelectEmail('body@bgc.com');
CALL procedureClientSelect('Body','Christ','87130215687');
CALL procedureClientSelectByPESEL('87130215687');

SELECT *FROM allusers;
SELECT *FROM clientsandreservations;

CALL procedureReturnFloorNumber();
SELECT *FROM permissions;