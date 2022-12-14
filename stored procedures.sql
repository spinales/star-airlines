IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'SearchFlightByFlightType'
)
DROP PROCEDURE Flight.SearchFlightByFlightType
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE Flight.SearchFlightByFlightType
    @FlightType int 
AS
    -- body of the stored procedure
    SET NOCOUNT ON; 
    SELECT *
    FROM Flight.Flight
    WHERE Flight.Flight.FlightTypeID = @FlightType;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'SearchFlightByRangeOfCost'
)
DROP PROCEDURE Flight.SearchFlightByRangeOfCost
GO

CREATE PROCEDURE Flight.SearchFlightByRangeOfCost
    @Min int = 0,
    @Max int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Flight.Flight
    WHERE Flight.FlightCost >= @Min AND
    Flight.FlightCost <= @Max;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'SearchFlightByDestiny'
)
DROP PROCEDURE Flight.SearchFlightByDestiny
GO
CREATE PROCEDURE Flight.SearchFlightByDestiny
    @DestinationID int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Flight.Flight
    Where Flight.DestinationID = @DestinationID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'SearchLuggageByFlightSchedule'
)
DROP PROCEDURE Flight.SearchLuggageByFlightSchedule
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE Flight.SearchLuggageByFlightSchedule
    @FlightScheduleID int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Flight.Luggage
    Where Luggage.FlightScheduleID = @FlightScheduleID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'SearchTicketByClientID'
)
DROP PROCEDURE Flight.SearchTicketByClientID
GO
CREATE PROCEDURE Flight.SearchTicketByClientID
    @ClientID int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Flight.Ticket
    WHERE Ticket.PersonID = @ClientID;
GO

-- Create a new stored procedure called 'SearchTicketByFlightSchedule' in schema 'Flight'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'SearchTicketByFlightSchedule'
)
DROP PROCEDURE Flight.SearchTicketByFlightSchedule
GO
CREATE PROCEDURE Flight.SearchTicketByFlightSchedule
    @FlightScheduleID int 
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Flight.Ticket
    WHERE Ticket.FlightScheduleID = @FlightScheduleID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'SearchPlaneByModelID'
)
DROP PROCEDURE Airport.SearchPlaneByModelID
GO
CREATE PROCEDURE Airport.SearchPlaneByModelID
    @ModelID int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Airport.Plane
    WHERE Plane.ModelID = @ModelID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'SearchFlightScheduleByFlight'
)
DROP PROCEDURE Flight.SearchFlightScheduleByFlight
GO
CREATE PROCEDURE Flight.SearchFlightScheduleByFlight
    @FlightID int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Flight.FlightSchedule
    WHERE FlightSchedule.FlightID = @FlightID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'SearchFlightScheduleByDestiny'
)
DROP PROCEDURE Flight.SearchFlightScheduleByDestiny
GO
CREATE PROCEDURE Flight.SearchFlightScheduleByDestiny
    @DestinationID int
AS
    SET NOCOUNT ON;

    Declare @IDs Table (id INT);
    Insert Into @IDs (id) (SELECT Flight.Flight.FlightID
    From Flight.Flight
    WHERE Flight.DestinationID = @DestinationID);

    SELECT *
    FROM Flight.FlightSchedule
    WHERE FlightSchedule.FlightScheduleID IN (SELECT id from @IDs);
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'SearchFlightScheduleByRangeOfDate'
)
DROP PROCEDURE Flight.SearchFlightScheduleByRangeOfDate
GO
CREATE PROCEDURE Flight.SearchFlightScheduleByRangeOfDate
    @StartDate DATETIME,
    @EndDate DATETIME
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Flight.FlightSchedule
    WHERE Flight.FlightSchedule.ArrivalDate BETWEEN @StartDate AND @EndDate;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'SearchPlaneByID'
)
DROP PROCEDURE Airport.SearchPlaneByID
GO
CREATE PROCEDURE Airport.SearchPlaneByID
    @PlaneID int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Airport.Plane
    WHERE Plane.PlaneID = @PlaneID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'SearchAirportByState'
)
DROP PROCEDURE Airport.SearchAirportByState
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE Airport.SearchAirportByState
    @StateID int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Airport.Plane
    WHERE Plane.StatusPlaneID = @StateID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'SearchPersonByDocument'
)
DROP PROCEDURE Person.SearchPersonByDocument
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE Person.SearchPersonByDocument
    @Document varchar(20)
-- add more stored procedure parameters here
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Person.Person
    WHERE Person.Document = @Document;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'SearchEmployeeByRole'
)
DROP PROCEDURE Person.SearchEmployeeByRole
GO
CREATE PROCEDURE Person.SearchEmployeeByRole
    @RoleID int
AS
    SET NOCOUNT ON;
    SELECT P.*
    FROM Person.Person P
    INNER JOIN Person.Employee_EmployeeRole on Person.Employee_EmployeeRole.EmployeeID = P.PersonID
    WHERE Person.Employee_EmployeeRole.EmployeeRoleID = @RoleID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'SearchAllEmployees'
)
DROP PROCEDURE Person.SearchAllEmployees
GO
CREATE PROCEDURE Person.SearchAllEmployees
    -- @param1  int
AS
    SET NOCOUNT ON;
    SELECT P.*
    FROM Person.Person P
    INNER JOIN Person.Employee_EmployeeRole on Person.Employee_EmployeeRole.EmployeeID = P.PersonID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'SearchAllPersons'
)
DROP PROCEDURE Person.SearchAllPersons
GO
CREATE PROCEDURE Person.SearchAllPersons
AS
    SET NOCOUNT ON;

    Declare @IDs Table (id INT);
    Insert Into @IDs (id) (SELECT P.PersonID
    FROM Person.Person P
    INNER JOIN Person.Employee_EmployeeRole on Person.Employee_EmployeeRole.EmployeeID = P.PersonID);

    SELECT *
    FROM Person.Person
    WHERE Person.PersonID NOT IN (SELECT id from @IDs);
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'SearchPlaneByBrand'
)
DROP PROCEDURE Airport.SearchPlaneByBrand
GO

CREATE PROCEDURE Airport.SearchPlaneByBrand
    @BrandID int
AS
    SET NOCOUNT ON;

    Declare @IDs Table (id INT);
    Insert Into @IDs (id) (SELECT Model.ModelID
    FROM Airport.Model
    Where Model.BrandID = @BrandID);

    SELECT *
    FROM Airport.Plane
    WHERE Plane.ModelID IN (SELECT id from @IDs);
GO

