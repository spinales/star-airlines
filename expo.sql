-- flight schedule
DECLARE @D1 datetime = Convert(date, getdate());
DECLARE @D2 date = DATEADD(day, 2, GETDATE());
EXECUTE Flight.spAddFlightSchedule @D1, @D2, 1,
    92,93,39;
-- person
DECLARE @Dt datetime = Convert(date, getdate());
DECLARE @DOB date = DATEADD(year, -20, GETDATE());
EXECUTE Person.spAddPerson
    'Aaron',
    'Paul',
     @DT,
    1,
    'M',
    '58772079599',
    1,'8095553525',@DOB,1,'7977 Smith Store Street Helotes, TX 78023',
    'chevyman1119@mailcuk.com';
-- luggage
DECLARE @flight int;
SELECT TOP(1) @flight = FlightScheduleID FROM Flight.FlightSchedule ORDER BY FlightScheduleID DESC;
DECLARE @person int;
SELECT @person =PersonID from Person.Person WHERE Document = '58772079599';
EXECUTE Flight.spAddTicket @FlightID = @flight, @PersonID = @person, @TicketTypeID = 2, @FlightScheduleID = @flight, @SeatPlane = '001AEXE';

DECLARE @f int;
SELECT TOP(1) @f = Flight.FlightID FROM Flight.Flight
INNER JOIN Flight.FlightSchedule FS on Flight.FlightID = FS.FlightID
WHERE FS.FlightScheduleID = @flight;
EXECUTE Flight.spAddLuggage @PersonID = @person, @FlightScheduleID = @flight, @Weight = 15, @LuggageTypeID = 1, @LuggageStatusID = 1, @TicketTypeID = 2;
EXECUTE Flight.spAddLuggage @PersonID = @person, @FlightScheduleID = @flight, @Weight = 3, @LuggageTypeID = 1, @LuggageStatusID = 1, @TicketTypeID = 2;
-- ticket


