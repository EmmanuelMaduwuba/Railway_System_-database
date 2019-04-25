-- MySQL script for Railway Bookings Data Mart (ETL Select and Insert Statements)

-- Authors:Emmanuel Maduwuba






INSERT INTO Time_period (Date_ID, Date, Day_of_week, Month, Month_day, Year)

SELECT

    Date_ID,

    Date,

    DATE_FORMAT(Date, "%W"),	-- AS Day_of_week,

    DATE_FORMAT(Date, "%M"),	-- AS Month,

    DATE_FORMAT(Date, "%d"),	-- AS Month_day,

    DATE_FORMAT(Date, "%Y") 	-- AS Year

FROM (

SELECT
	
big_numbers.big_digits AS Date_ID,
 
	DATE_ADD( '2018-01-01', INTERVAL big_numbers.big_digits DAY ) AS Date

		-- DATE_ADD function adds a time/date interval to a date and then returns the date

FROM big_numbers

WHERE DATE_ADD( '2018-01-01', INTERVAL big_numbers.big_digits DAY ) BETWEEN '2018-01-01' AND '2018-12-12'

) AS timer

ORDER BY Date_ID;







INSERT INTO Train_Route_Schedule (Sequence_No, Train_ID, Station_ID_out, Time_out, Station_ID_in, Time_in)

SELECT
 
   RS.Sequence_No,

    RS.Train_ID,

    RS.Station_ID_out,

    RS.Time_out,

    RS.Station_ID_in,

    RS.Time_in

FROM railwaysys.train_schedule AS RS;


UPDATE Train_Route_Schedule

SET Train_Route_Schedule.Train_name = (

SELECT RT.Train_name

FROM railwaysys.train AS RT

WHERE Train_Route_Schedule.Train_ID = RT.Train_ID);



UPDATE Train_Route_Schedule

SET Train_Route_Schedule.Station_out_name = (

SELECT RS.Station_name 

FROM railwaysys.Station AS RS

WHERE Train_Route_Schedule.Station_ID_out = RS.Station_ID);



UPDATE Train_Route_Schedule

SET Train_Route_Schedule.Station_in_name = (

SELECT RS.Station_name 

FROM railwaysys.Station AS RS

WHERE Train_Route_Schedule.Station_ID_in = RS.Station_ID);







INSERT INTO P_Booking (Passenger_First_name, Passenger_Last_name, Ticket_ID, Booking_Date,
Train_ID, Psg_Coach_ID, Seat_no, Start_station_ID, Stop_station_ID)

SELECT
 
   RP.Passenger_First_name,

    RP.Passenger_Last_name,

    RP.Ticket_ID,

    RP.Booking_Date,

    RP.Train_ID,

    RP.Psg_Coach_ID,

    RP.Seat_no,

    RP.Start_station_ID,

    Stop_station_ID

FROM
	railwaysys.passenger_booking AS RP;





INSERT INTO Ticket_Sales (Date_ID, Surr_Seq_ID, Ticket_ID, Passenger_Count)

SELECT

    Date_ID,

    Surr_Seq_ID,

    Ticket_ID,

    Passenger_Count

FROM (

SELECT
 
   Time_period.Date_ID AS Date_ID,

    Train_Route_Schedule.Surr_Seq_ID AS Surr_Seq_ID,

    P_Booking.Ticket_ID AS Ticket_ID,

    1 AS Passenger_Count

FROM
	Time_period, Train_Route_Schedule, P_Booking
) AS ticketing;



UPDATE Ticket_Sales

SET Ticket_Sales.Ticket_Amount = (

SELECT

	CASE RP.Psg_Coach_ID

		WHEN 'C1' THEN 100.00		-- Sets sale of coach C1 ticket to $100

		WHEN 'C2' THEN 80.00		-- Sets sale of coach C2 ticket to $80

        	WHEN 'C3' THEN 70.00		-- Sets sale of coach C3 ticket to $70

	        WHEN 'C4' THEN 60.00		-- Sets sale of coach C4 ticket to $60

        	WHEN 'C5' THEN 50.00		-- Sets sale of coach C4 ticket to $50

	END

FROM railwaysys.passenger_booking AS RP

WHERE RP.Psg_Coach_ID IN ('C1','C2','C3','C4','C5') AND Ticket_Sales.Ticket_ID = RP.Ticket_ID);

