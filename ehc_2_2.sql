CREATE TABLE permissions (
    permissionID TINYINT AUTO_INCREMENT UNIQUE NOT NULL,
    permissionDescription VARCHAR(20),
    PRIMARY KEY (permissionID)
);

CREATE TABLE services (
    serviceID TINYINT UNIQUE AUTO_INCREMENT,
    serviceType VARCHAR(20) NOT NULL,
    serviceTag VARCHAR(10) NOT NULL,
    serviceHourPrice SMALLINT,
    PRIMARY KEY (serviceID)
);

CREATE TABLE itemservices (
    itserviceID TINYINT UNIQUE AUTO_INCREMENT,
    serviceType VARCHAR(20) NOT NULL,
    serviceTag VARCHAR(10) NOT NULL,
    serviceItemPrice SMALLINT,
    PRIMARY KEY (itserviceID)
);

CREATE TABLE roomstate (
    stateID TINYINT,
    stateDesc VARCHAR(30),
    PRIMARY KEY (stateID)
);

INSERT INTO roomstate (stateID,stateDesc) VALUES(0,'FREE');
INSERT INTO roomstate (stateID,stateDesc) VALUES(1,'RESERVED');
INSERT INTO roomstate (stateID,stateDesc) VALUES(2,'OCCUPIED');
INSERT INTO itemservices (serviceType,serviceTag,serviceItemPrice) VALUES ('Butelka szampana','VIP',250);
INSERT INTO services (serviceType,serviceTag,serviceHourPrice) VALUES ('Wynajem roweru','STD',10);
INSERT INTO services (serviceType,serviceTag,serviceHourPrice) VALUES ('Wynajem Boiska','STD',100);
INSERT INTO services (serviceType,serviceTag,serviceHourPrice) VALUES ('Wynajem samochodu','STD',70);

CREATE TABLE users (
    userID INT NOT NULL AUTO_INCREMENT,
    permissionGiven TINYINT,
    userLogin VARCHAR(60) UNIQUE,
    PRIMARY KEY (userID),
    FOREIGN KEY (permissionGiven)
        REFERENCES permissions (permissionID)
);

CREATE TABLE clients (
    clientID INT NOT NULL AUTO_INCREMENT,
    clientName VARCHAR(30) NOT NULL,
    clientSurname VARCHAR(30) NOT NULL,
    e_mail VARCHAR(30) NOT NULL UNIQUE,
    phoneNumber VARCHAR(9) NOT NULL,
    clientRegistrationTime DATETIME,
    address VARCHAR(10) NOT NULL,
    street VARCHAR(30) NOT NULL,
    postalCode VARCHAR(6) NOT NULL,
    city VARCHAR(50) NOT NULL,
    clientPESEL VARCHAR(11) NOT NULL UNIQUE,
    idCardNumber VARCHAR(8) UNIQUE,
    advancePaid BOOLEAN,
    PRIMARY KEY (clientID)
);

CREATE TABLE room (
    roomID SMALLINT NOT NULL AUTO_INCREMENT,
    floorNumber TINYINT,
    label SMALLINT UNIQUE,
    roomStatus TINYINT,
    dayPrice SMALLINT,
    lastClean DATETIME,
    lastService DATETIME,
    staffID INT,
    isCleaningNeeded BOOLEAN,
    isServiceNeeded BOOLEAN,
    roomDescription VARCHAR(1000),
    capacity TINYINT,
    PRIMARY KEY (roomID),
    
    FOREIGN KEY (roomStatus)
        REFERENCES roomstate (stateID)
        ON DELETE SET NULL,
    FOREIGN KEY (staffID)
        REFERENCES users (userID)
);

CREATE TABLE reservation (
    resID INT NOT NULL AUTO_INCREMENT,
    fk_clientID INT,
    fk_roomID SMALLINT,
    reservationStatus TINYINT,
    reservationStart DATETIME,
    reservationEnd DATETIME,
    advanceValue SMALLINT NOT NULL,
    advanceStatus TINYINT NOT NULL,
    peopleAmmount SMALLINT,
    PRIMARY KEY (resID),
    
    FOREIGN KEY (fk_clientID)
        REFERENCES clients (clientID)
        ON DELETE SET NULL,
    FOREIGN KEY (fk_roomID)
        REFERENCES room (roomID)
        ON DELETE CASCADE
);

CREATE TABLE clientsservices (
    addSerID INT NOT NULL AUTO_INCREMENT,
    clientID INT,
    fk_resID INT,
    serviceID TINYINT,
    fk_itserviceID TINYINT,
    serviceStart DATETIME,
    serviceEnd DATETIME,
    itemsNumber TINYINT,
    PRIMARY KEY (addSerID),
    
    FOREIGN KEY (clientID)
        REFERENCES clients (clientID),
    FOREIGN KEY (serviceID)
        REFERENCES services (serviceID),
    FOREIGN KEY (fk_resID)
        REFERENCES reservation (resID)
        ON DELETE CASCADE,
    FOREIGN KEY (fk_itserviceID)
        REFERENCES itemservices (itserviceID)
        ON DELETE CASCADE
);