CREATE VIEW clientsandreservations AS
    SELECT 
        clients.clientID AS 'clientID',
        clients.clientName AS 'clientName',
        clients.clientSurname AS 'clientSurname',
        clients.e_mail AS 'clientEmail',
        clients.clientPESEL AS 'pesel',
        room.label AS 'roomLabel',
        room.floorNumber AS 'floorNumber',
        room.roomDescription AS 'roomDescription',
        room.dayPrice * ABS(DATEDIFF(reservation.reservationStart,
                        reservation.reservationEnd)) AS 'totalPrice',
        reservation.resID AS 'reservationID',
        reservation.fk_roomID AS 'roomID',
        reservation.reservationStart AS 'reservationStart',
        reservation.reservationEnd AS 'reservationEnd',
        reservation.reservationStatus AS 'reservationStatus',
        reservation.advanceStatus AS 'advanceStatus'
    FROM
        reservation
            LEFT JOIN
        clients ON reservation.fk_clientID = clients.clientID
            LEFT JOIN
        room ON reservation.fk_roomID = room.roomID
    ORDER BY reservation.resID;

CREATE VIEW roomsreservations AS
    SELECT 
        room.roomID AS 'roomID',
        room.floorNumber AS 'floorNumber',
        room.label AS 'roomLabel',
        room.roomStatus AS 'roomStatus',
        room.capacity AS 'roomCapacity',
        reservation.resID AS 'reservationID',
        reservation.reservationStart AS 'reservationStart',
        reservation.reservationEnd AS 'reservationEnd',
        reservation.peopleAmmount AS 'peopleAmmount',
        reservation.advanceStatus AS 'advanceStatus',
        reservation.reservationStatus AS 'reservationStatus',
        clients.clientID AS 'clientID'
    FROM
        room
            LEFT JOIN
        reservation ON room.roomID = reservation.fk_roomID
            INNER JOIN
        clients ON reservation.fk_ClientID = clients.ClientID
    ORDER BY room.roomID;

CREATE VIEW allusers AS
    SELECT 
        users.userID AS 'userID',
        users.userName AS 'userName',
        users.userEmail AS 'userEmail',
        permissions.permissionID AS 'permissionID',
        permissions.permissionDescription AS 'permissionDescription'
    FROM
        users
            LEFT JOIN
        permissions ON users.permissionGiven = permissions.permissionID
    ORDER BY users.permissionGiven;


CREATE VIEW allehcclients AS
    SELECT 
        clients.clientID AS 'clientID',
        clients.clientName AS 'clientName',
        clients.clientSurname AS 'clientSurname',
        clients.e_mail AS 'clientEmail',
        clients.clientPESEL AS 'pesel',
        clients.phoneNumber AS 'phoneNumber',
        clients.city AS 'city',
        clients.street AS 'street',
        clients.address AS 'address',
        clients.postalCode AS 'postalCode'
    FROM
        clients
    ORDER BY clients.clientName ASC , clients.clientSurname ASC;

CREATE VIEW allhotelrooms AS
    SELECT 
        room.floorNumber AS 'floorNumber',
        room.label AS 'roomLabel',
        room.dayPrice AS 'dayPrice',
        room.roomID AS 'roomID',
        room.roomDescription AS 'roomDescription',
        room.roomStatus AS 'roomStatus',
        room.capacity AS 'roomCapacity'
    FROM
        room
    ORDER BY room.floorNumber ASC , room.label ASC;

CREATE VIEW hotelroominfostate AS
    SELECT 
        room.floorNumber AS 'floorNumber',
        room.label AS 'roomLabel',
        room.roomDescription AS 'roomDescription',
        room.roomID AS 'roomID',
        room.lastClean AS 'lastCleaning',
        room.lastService AS 'lastService',
        room.isCleaningNeeded AS 'cleaningNeeded',
        room.isServiceNeeded AS 'serviceNeeded',
        room.staffID AS 'staffID',
        room.capacity AS 'roomCapacity',
        room.roomStatus AS 'roomStatus',
        roomstate.stateDesc AS 'roomState'
    FROM
        room
            INNER JOIN
        roomstate ON room.roomStatus = roomstate.stateID
    ORDER BY room.floorNumber ASC , room.label ASC;

CREATE VIEW additionalservices AS
    SELECT 
        clientsservices.addSerID AS 'serviceOrderID',
        clients.clientName AS 'clientName',
        clients.clientSurname AS 'clientSurname',
        services.serviceID AS 'timeServiceID',
        services.serviceType AS 'serviceType',
        services.serviceHourPrice AS 'hourPrice',
        itemservices.itserviceID AS 'itemServiceID',
        itemservices.serviceType AS 'itemServiceType',
        itemservices.serviceItemPrice AS 'oneItemPrice',
        clientsservices.fk_resID AS 'reservationID',
        clientsservices.serviceStart AS 'serviceStart',
        clientsservices.serviceEnd AS 'serviceEnd',
        clientsservices.itemsNumber AS 'itemsNumber'
    FROM
        clients
            LEFT OUTER JOIN
        clientsservices ON clients.clientID = clientsservices.clientID
            LEFT OUTER JOIN
        services ON services.serviceID = clientsservices.serviceID
            INNER JOIN
        itemservices ON itemservices.itserviceID = clientsservices.fk_itserviceID
    ORDER BY clients.clientID;
