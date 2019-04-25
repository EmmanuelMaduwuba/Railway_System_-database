-- MySQL script for Railway Bookings Data Mart (Fact and Dimension Table definition)

-- Authors: Emmanuel Maduwuba





-- initialize numbers for time key

CREATE TABLE small_numbers (singular_digit INT);

INSERT INTO small_numbers VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);



CREATE TABLE big_numbers (big_digits BIGINT);

INSERT INTO big_numbers

SELECT ones.singular_digit + tens.singular_digit * 10 + hundreds.singular_digit * 100 + thousands.singular_digit * 1000
FROM small_numbers AS ones, small_numbers AS tens, small_numbers AS hundreds, small_numbers AS thousands;

-- end initializations of numbers






CREATE TABLE Time_period (

     	Date_ID          BIGINT PRIMARY KEY,
    	Date             DATE NOT NULL,

    	Day_of_week      CHAR(10) NOT NULL,

     	Month            CHAR(10) NOT NULL,

     	Month_day        INT NOT NULL,
     	Year             INT NOT NULL
);







CREATE TABLE Train_Route_Schedule (

    	Surr_Seq_ID INT AUTO_INCREMENT PRIMARY KEY,

    	Sequence_No CHAR(6) NOT NULL,

    	Train_ID CHAR(2) NOT NULL,

    	Train_name CHAR(50),

    	Station_ID_out CHAR(1) NOT NULL,

    	Station_out_name CHAR(50),

    	Time_out TIME NOT NULL,

    	Station_ID_in CHAR(1) NOT NULL,

    	Station_in_name CHAR (50),

    	Time_in TIME NOT NULL
);







CREATE TABLE P_Booking (

	Passenger_First_name CHAR(50) NOT NULL,

	Passenger_Last_name CHAR(50) NOT NULL,

	Ticket_ID CHAR(8) PRIMARY KEY NOT NULL,

	Booking_Date DATE NOT NULL,

	Train_ID CHAR(2) NOT NULL,

	Psg_Coach_ID CHAR(2) NOT NULL,

	Seat_no INT NOT NULL,

	Start_station_ID CHAR(1) NOT NULL,

	Stop_station_ID CHAR(1) NOT NULL
);







CREATE TABLE Ticket_Sales (

	Sales_ID INT AUTO_INCREMENT,

    	Date_ID BIGINT NOT NULL,

    	Surr_Seq_ID INT NOT NULL,

    	Ticket_ID CHAR(8) NOT NULL,

    	Passenger_Count INT NOT NULL,

    	Ticket_Amount DECIMAL(10,2),

CONSTRAINT pk_Ticket_Sales PRIMARY KEY (Sales_ID, Date_ID,Surr_Seq_ID, Ticket_ID),

CONSTRAINT fk_Ticket_Sales_Date_ID FOREIGN KEY (Date_ID) REFERENCES Time_period (Date_ID),

CONSTRAINT fk_Ticket_Sales_Surr_Seq_ID FOREIGN KEY (Surr_Seq_ID) REFERENCES Train_Route_Schedule (Surr_Seq_ID),

CONSTRAINT fk_Ticket_Sales_Ticket_ID FOREIGN KEY (Ticket_ID) REFERENCES P_Booking (Ticket_ID)
);


