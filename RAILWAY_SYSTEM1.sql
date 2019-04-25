-- MySQL script for Railway System (Table definition and population)
-- Authors:  Emmanuel Maduwuba
		

CREATE TABLE STATION ( 
	Station_ID CHAR(1) PRIMARY KEY NOT NULL, 
	Station_name VARCHAR(50) NOT NULL );

CREATE TABLE TRACK ( 
	Track_ID INT PRIMARY KEY NOT NULL,
	Track_name VARCHAR(50) NOT NULL,
	Station_from_ID CHAR(1) NOT NULL,
    Station_to_ID CHAR(1) NOT NULL,
CONSTRAINT fk_TRACK_Station_from_ID FOREIGN KEY(Station_from_ID) REFERENCES STATION (Station_ID),
CONSTRAINT fk_TRACK_Station_to_ID FOREIGN KEY(Station_to_ID) REFERENCES STATION (Station_ID));

CREATE TABLE TRAIN (
	Train_ID CHAR(2) PRIMARY KEY NOT NULL,
    Train_name VARCHAR(50) NOT NULL,
    Number_of_coaches INT NOT NULL,
    Number_of_seats INT NOT NULL);

CREATE TABLE TRAIN_SEAT (
	Train_ID CHAR(2) NOT NULL,
    Coach_ID CHAR(2) NOT NULL,
    Seats_available INT NOT NULL,
CONSTRAINT pk_TRAIN_SEAT PRIMARY KEY(Train_ID, Coach_ID),
CONSTRAINT fk_TRAIN_SEAT_Train_ID FOREIGN KEY (Train_ID) REFERENCES TRAIN (Train_ID));

CREATE TABLE TRAIN_SCHEDULE (
	Sequence_No CHAR(6) NOT NULL,
    Train_ID CHAR(2) NOT NULL,
    Station_ID_out CHAR(1) NOT NULL,
    Time_out TIME NOT NULL,
    Station_ID_in CHAR(1) NOT NULL,
    Time_in TIME NOT NULL,
CONSTRAINT pk_TRAIN_SCHEDULE PRIMARY KEY(Sequence_No),
CONSTRAINT fk_TRAIN_SCHEDULE_Train_ID FOREIGN KEY (Train_ID) REFERENCES TRAIN (Train_ID),
CONSTRAINT fk_TRAIN_SCHEDULE_Station_ID_out FOREIGN KEY (Station_ID_out) REFERENCES TRACK (Station_from_ID),
CONSTRAINT fk_TRAIN_SCHEDULE_Station_ID_in FOREIGN KEY (Station_ID_in) REFERENCES TRACK (Station_to_ID));

CREATE TABLE PASSENGER_BOOKING (
	Passenger_First_name VARCHAR(50) NOT NULL,
    Passenger_Last_name VARCHAR(50) NOT NULL,
    Ticket_ID CHAR(8) NOT NULL,
    Booking_Date DATE NOT NULL,
    Train_ID CHAR(2) NOT NULL,
    Psg_Coach_ID CHAR(2) NOT NULL,
    Seat_no INT NOT NULL, 
    Start_station_ID CHAR(1) NOT NULL,
    Stop_station_ID CHAR(1) NOT NULL,
CONSTRAINT pk_PSG_BOOK PRIMARY KEY (Ticket_ID),
CONSTRAINT fk_PSG_BOOK_Train_ID FOREIGN KEY (Train_ID) REFERENCES TRAIN (Train_ID),
CONSTRAINT fk_PSG_BOOK_Start_station_ID FOREIGN KEY (Start_station_ID) REFERENCES STATION (Station_ID),
CONSTRAINT fk_PSG_BOOK_Stop_station_ID FOREIGN KEY (Stop_station_ID) REFERENCES STATION (Station_ID));

INSERT INTO STATION VALUES 
	('A','Anchorage'),('B','Brampton'),('C','Carlton'),('D','Donahue'),('E','Elderich'),('F','Florida');

INSERT INTO TRACK VALUES 
	(001,'track01','A','B'),(002,'track02','B','C'),(003,'track03','C','D'),(004,'track04','D','E'),
    (005,'track05','E','F'),(006,'track06','C','F'),(007,'track07','F','B'),(008,'track08','F','A');

INSERT INTO TRAIN VALUES 
	('T1','T01-Express',5,50),('T2','T02-Express',5,50),('T3','T03-Express',5,50),('T4','T04-Express',5,50);
    
INSERT INTO TRAIN_SEAT VALUES 
	('T1','C1',10),('T1','C2',10),('T1','C3',10),('T1','C4',10),('T1','C5',10),
    ('T2','C1',10),('T2','C2',10),('T2','C3',10),('T2','C4',10),('T2','C5',10),
    ('T3','C1',10),('T3','C2',10),('T3','C3',10),('T3','C4',10),('T3','C5',10),
    ('T4','C1',10),('T4','C2',10),('T4','C3',10),('T4','C4',10),('T4','C5',10);
    
INSERT INTO TRAIN_SCHEDULE VALUES 
	('T10101','T1','A','8:00','B','8:30'),('T10201','T1','B','8:40','C','9:20'),('T10301','T1','C','9:30','D','9:50'),
    ('T10401','T1','D','10:00','E','10:20'),('T10501','T1','E','10:30','F','11:50'),('T10801','T1','F','12:00','A','13:10'),
    ('T10102','T1','A','13:20','B','13:50'),('T10202','T1','B','14:00','C','14:40'),('T10302','T1','C','14:50','D','15:10'),
    ('T10402','T1','D','15:20','E','15:40'),('T10502','T1','E','15:50','F','17:10'),('T10802','T1','F','17:20','A','18:30'),
    ('T10103','T1','A','18:40','B','19:10'),('T10203','T1','B','19:20','C','20:00'),('T10303','T1','C','20:10','D','20:30'),
    ('T10403','T1','D','20:40','E','21:00'),('T10503','T1','E','21:10','F','22:30'),('T10803','T1','F','22:40','A','23:50'),
    
    ('T20201','T2','B','8:00','C','8:40'),('T20601','T2','C','8:50','F','9:50'),('T20701','T2','F','10:00','B','11:00'),
	('T20202','T2','B','11:10','C','11:50'),('T20602','T2','C','12:00','F','13:00'),('T20702','T2','F','13:10','B','14:10'),
    ('T20203','T2','B','14:20','C','15:00'),('T20603','T2','C','15:10','F','16:10'),('T20703','T2','F','16:20','B','17:20'),
    ('T20204','T2','B','17:30','C','18:10'),('T20604','T2','C','18:20','F','19:20'),('T20704','T2','F','19:30','B','20:30'),
    ('T20205','T2','B','20:40','C','21:20'),('T20605','T2','C','21:30','F','22:30'),('T20705','T2','F','22:40','B','23:40'),
    
    ('T30301','T3','C','8:00','D','8:20'),('T30401','T3','D','8:30','E','8:50'),('T30501','T3','E','9:00','F','10:20'),
    ('T30701','T3','F','10:30','B','11:30'),('T30201','T3','B','11:40','C','12:20'),
    ('T30302','T3','C','12:30','D','12:50'),('T30402','T3','D','13:00','E','13:20'),('T30502','T3','E','13:30','F','14:50'),
    ('T30702','T3','F','15:00','B','16:00'),('T30202','T3','B','16:10','C','16:50'),
    ('T30303','T3','C','17:00','D','17:20'),('T30403','T3','D','17:30','E','17:50'),('T30503','T3','E','18:20','F','19:40'),
    ('T30703','T3','F','19:50','B','20:50'),('T30203','T3','B','21:00','C','21:40'),
    
    ('T40801','T4','F','8:15','A','9:25'),('T40101','T4','A','9:35','B','10:05'),('T40201','T4','B','10:15','C','10:55'),
    ('T40601','T4','C','11:05','F','12:05'),
    ('T40802','T4','F','12:15','A','13:25'),('T40102','T4','A','13:35','B','14:05'),('T40202','T4','B','14:15','C','14:55'),
    ('T40602','T4','C','15:05','F','16:05'),
    ('T40803','T4','F','16:15','A','17:25'),('T40103','T4','A','17:35','B','18:05'),('T40203','T4','B','18:15','C','18:55'),
    ('T40603','T4','C','19:05','F','20:05');

INSERT INTO PASSENGER_BOOKING VALUES 
	('Omotola-Jalade','Ekeinde','10001001', '2018-10-21','T1','C2',3,'A','E'),
    ('Shahrukh','Khan','10001002', '2018-10-21','T2','C3',6,'B','F'),
    ('Chris','Helmsworth','10001003', '2018-10-21','T2','C3',2,'B','F'),
    ('Shahrukh','Khan','10001004', '2018-10-21','T4','C1',1,'A','C'),
    ('Taron','Egerton','10001005', '2018-10-21','T4','C1',2,'A','F'),
    ('Hugh','Jackman','10001006', '2018-10-21','T3','C5',7,'C','D'),
    ('Blake','Lively','10001007', '2018-10-21','T2','C4',4,'F','C');


    

