/*
Functions
*/
DROP function IF EXISTS Flight.ufnCalculateNumberOfRemainingAvailableSeats;
GO
CREATE FUNCTION Flight.ufnCalculateNumberOfRemainingAvailableSeats (@FlightScheduleID int)
RETURNS int
AS
BEGIN
    DECLARE @PlaneID int;
    DECLARE @SeatingCapacity int;
    DECLARE @SeatingOccupied int;
    DECLARE @result int;

    SELECT @PlaneID = FlightSchedule.PlaneID
    FROM Flight.FlightSchedule
    WHERE FlightSchedule.FlightScheduleID = @FlightScheduleID;

    SELECT @SeatingCapacity = Plane.SeatingCapacity
    FROM Airport.Plane
    WHERE Plane.PlaneID = @PlaneID;

    Select @SeatingOccupied = COUNT(*)
    FROM Flight.Ticket
    WHERE Ticket.FlightScheduleID = @FlightScheduleID;

    SET @result = @SeatingCapacity - @SeatingOccupied;
    RETURN @result;
END;
GO

DROP function IF EXISTS Flight.ufnValidateSeatIfAvailable;
GO
CREATE FUNCTION Flight.ufnValidateSeatIfAvailable (@FlightScheduleID int, @SeatPlane varchar(7))
RETURNS bit
AS
BEGIN
    DECLARE @result int;

    SELECT @result = Count(*)
    FROM Flight.Ticket T
    WHERE T.FlightScheduleID = @FlightScheduleID
    AND T.SeatPlane = @SeatPlane;

    IF @result > 0
        RETURN 1;

    RETURN 0;
END;
GO

DROP function IF EXISTS Flight.ufnCalculateCostOfLuggage;
GO
CREATE FUNCTION Flight.ufnCalculateCostOfLuggage(@Weight int, @LuggageTypeID int, @TicketTypeID int)
RETURNS money
AS
BEGIN
    DECLARE @result int;

    SELECT @Weight -= TT.FreeWeight
    FROM Flight.TicketType TT
    WHERE TT.TicketTypeID = @TicketTypeID;

    SELECT TOP(1) @result = @Weight * LT.Cost
    FROM Flight.LuggageType LT
    WHERE LT.LuggageTypeID = @LuggageTypeID;

    IF @result < 0
        RETURN 0;

    RETURN @result;
END;
GO

DROP function IF EXISTS Flight.ufnGetAllEmployees;
GO
CREATE FUNCTION Flight.ufnGetAllEmployees ()
RETURNS TABLE
AS
RETURN (
    SELECT *
    FROM Person.Person P
    WHERE P.PersonID IN (SELECT EER.EmployeeID
    FROM Person.Employee_EmployeeRole EER));
GO

DROP function IF EXISTS Flight.ufnGetAllClients;
GO
CREATE FUNCTION Flight.ufnGetAllClients()
RETURNS TABLE
AS
RETURN (
    SELECT *
    FROM Person.Person P
    WHERE P.PersonID NOT IN (SELECT EER.EmployeeID
    FROM Person.Employee_EmployeeRole EER));
GO

DROP function IF EXISTS Flight.ufnCalculateFinalCostOfTicket;
GO
CREATE FUNCTION Flight.ufnCalculateFinalCostOfTicket(@TicketType int, @FlightID int, @PersonID int, @FlightScheduleID int)
RETURNS money
AS
BEGIN
    DECLARE @TicketTotalCost int;
    DECLARE @LuggageTotalCost int;
    DECLARE @TicketCost int;
    DECLARE @FlightCost int;
    DECLARE @Result money;

    -- Benefits
    SELECT @TicketTotalCost = SUM(FB.Cost)
    FROM Flight.FlightBenefit FB
    WHERE FB.FlightBenefitID IN (SELECT FFT.FlightBenefitID
    FROM Flight.FlightBenefit_FlightType FFT
    WHERE FFT.FlightTypeID = @TicketType);

    -- Luggage
    SELECT @LuggageTotalCost = SUM(L.Cost)
    FROM Flight.Luggage L
    WHERE L.PersonID = @PersonID
    AND L.FlightScheduleID = @FlightScheduleID;

    -- Cost Ticket
    SELECT @TicketCost = TT.Cost
    FROM Flight.TicketType TT
    WHERE TT.TicketTypeID = @TicketType;

    -- FlightCost
    SELECT @FlightCost = F.TravelDistance
    FROM Flight.Flight F
    WHERE F.FlightID = @FlightID;

    SET @Result = @TicketTotalCost + @LuggageTotalCost + @TicketCost + @FlightCost;
    RETURN @Result;
END;
GO
