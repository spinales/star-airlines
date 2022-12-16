
/*
Lista de buenas practicas:
- SET NOCOUNT ON; en todos los stored procedures
- WITH (UPDLOCK, SERIALIZABLE); en todos stored procedures
- SET ANSI_NULLS ON; todos los stored procedures
- SET QUOTED_IDENTIFIER OFF; todos los stored procedures
- 
*/
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spSearchFlightByFlightType'
)
DROP PROCEDURE Flight.spSearchFlightByFlightType
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE Flight.spSearchFlightByFlightType
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
    AND SPECIFIC_NAME = N'spSearchFlightByRangeOfCost'
)
DROP PROCEDURE Flight.spSearchFlightByRangeOfCost
GO

CREATE PROCEDURE Flight.spSearchFlightByRangeOfCost
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
    AND SPECIFIC_NAME = N'spSearchFlightByDestiny'
)
DROP PROCEDURE Flight.spSearchFlightByDestiny
GO
CREATE PROCEDURE Flight.spSearchFlightByDestiny
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
    AND SPECIFIC_NAME = N'spSearchLuggageByFlightSchedule'
)
DROP PROCEDURE Flight.spSearchLuggageByFlightSchedule
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE Flight.spSearchLuggageByFlightSchedule
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
    AND SPECIFIC_NAME = N'spSearchTicketByClientID'
)
DROP PROCEDURE Flight.spSearchTicketByClientID
GO
CREATE PROCEDURE Flight.spSearchTicketByClientID
    @ClientID int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Flight.Ticket
    WHERE Ticket.PersonID = @ClientID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spSearchTicketByFlightSchedule'
)
DROP PROCEDURE Flight.spSearchTicketByFlightSchedule
GO
CREATE PROCEDURE Flight.spSearchTicketByFlightSchedule
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
    AND SPECIFIC_NAME = N'spSearchPlaneByModelID'
)
DROP PROCEDURE Airport.spSearchPlaneByModelID
GO
CREATE PROCEDURE Airport.spSearchPlaneByModelID
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
    AND SPECIFIC_NAME = N'spSearchFlightScheduleByFlight'
)
DROP PROCEDURE Flight.spSearchFlightScheduleByFlight
GO
CREATE PROCEDURE Flight.spSearchFlightScheduleByFlight
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
    AND SPECIFIC_NAME = N'spSearchFlightScheduleByDestiny'
)
DROP PROCEDURE Flight.spSearchFlightScheduleByDestiny
GO
CREATE PROCEDURE Flight.spSearchFlightScheduleByDestiny
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
    AND SPECIFIC_NAME = N'spSearchFlightScheduleByRangeOfDate'
)
DROP PROCEDURE Flight.spSearchFlightScheduleByRangeOfDate
GO
CREATE PROCEDURE Flight.spSearchFlightScheduleByRangeOfDate
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
    AND SPECIFIC_NAME = N'spSearchPlaneByID'
)
DROP PROCEDURE Airport.spSearchPlaneByID
GO
CREATE PROCEDURE Airport.spSearchPlaneByID
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
    AND SPECIFIC_NAME = N'spSearchAirportByState'
)
DROP PROCEDURE Airport.spSearchAirportByState
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE Airport.spSearchAirportByState
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
    AND SPECIFIC_NAME = N'spSearchPersonByDocument'
)
DROP PROCEDURE Person.spSearchPersonByDocument
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE Person.spSearchPersonByDocument
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
    AND SPECIFIC_NAME = N'spSearchEmployeeByRole'
)
DROP PROCEDURE Person.spSearchEmployeeByRole
GO
CREATE PROCEDURE Person.spSearchEmployeeByRole
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
    AND SPECIFIC_NAME = N'spSearchAllEmployees'
)
DROP PROCEDURE Person.spSearchAllEmployees
GO
CREATE PROCEDURE Person.spSearchAllEmployees
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
    AND SPECIFIC_NAME = N'spSearchAllPersons'
)
DROP PROCEDURE Person.spSearchAllPersons
GO
CREATE PROCEDURE Person.spSearchAllPersons
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
    AND SPECIFIC_NAME = N'spSearchPlaneByBrand'
)
DROP PROCEDURE Airport.spSearchPlaneByBrand
GO

CREATE PROCEDURE Airport.spSearchPlaneByBrand
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

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spAddAirport'
)
DROP PROCEDURE Airport.spAddAirport
GO
CREATE PROCEDURE Airport.spAddAirport
    @AirportName varchar(200),
    @DestinationID int,
    @Direction varchar(250),
    @AirportTypeID int 
AS
    SET NOCOUNT ON;
    INSERT INTO Airport.Airport
    (AirportName,DestinationID,Direction,AirportTypeID)
    VALUES
    (@AirportName,@DestinationID,@Direction,@AirportTypeID);
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spUpdateAirport'
)
DROP PROCEDURE Airport.spUpdateAirport
GO
CREATE PROCEDURE Airport.spUpdateAirport
    @AirportID int,
    @AirportName varchar(200),
    @DestinationID int,
    @Direction varchar(250),
    @AirportTypeID int
AS
    SET NOCOUNT ON;
    UPDATE Airport.Airport
    SET 
        AirportName = @AirportName,
        DestinationID = @DestinationID,
        Direction = @Direction,
        AirportTypeID = @AirportTypeID
    WHERE Airport.AirportID = @AirportID
    GO
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spSearchAirportByID'
)
DROP PROCEDURE Airport.spSearchAirportByID
GO
CREATE PROCEDURE Airport.spSearchAirportByID
    @AirportID int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Airport.Airport
    Where Airport.AirportID = @AirportID;
GO
EXECUTE Airport.spSearchAirportByID 1
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spAddDestination'
)
DROP PROCEDURE Flight.spAddDestination
GO
CREATE PROCEDURE Flight.spAddDestination
    @CountryID int,
    @DestinationName varchar(100),
    @Acronym varchar(4),
    @Latitude NUMERIC(10,8),
    @Longitude NUMERIC(11,8)
AS
    SET NOCOUNT ON;
    INSERT INTO Flight.Destination
    (CountryID,DestinationName,Acronym,Latitude,Longitude)
    VALUES
    (@CountryID,@DestinationName,@Acronym,@Latitude,@Longitude);
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spUpdateDestination'
)
DROP PROCEDURE Flight.spUpdateDestination
GO
CREATE PROCEDURE Flight.spUpdateDestination
    @DestinationID int,
    @CountryID int,
    @DestinationName varchar(100),
    @Acronym varchar(4),
    @Latitude NUMERIC(10,8),
    @Longitude NUMERIC(11,8)
AS
    SET NOCOUNT ON;
    UPDATE Flight.Destination
    SET
        CountryID = @CountryID,
        DestinationName = @DestinationName,
        Acronym = @Acronym,
        Latitude = @Latitude,
        Longitude = @Longitude
    WHERE Destination.DestinationID = @DestinationID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spSearchDestinationByID'
)
DROP PROCEDURE Flight.spSearchDestinationByID
GO
CREATE PROCEDURE Flight.spSearchDestinationByID
    @DestinationID int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Flight.Destination
    WHERE Destination.DestinationID = @DestinationID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spAddCountry'
)
DROP PROCEDURE Flight.spAddCountry
GO
CREATE PROCEDURE Flight.spAddCountry
    @ISO2 CHAR(2),
    @ISO3 CHAR(3),
    @CurrencyName varchar(100),
    @Latitude NUMERIC(10,8),
    @Longitude NUMERIC(11,8),
    @CountryName varchar(100)
AS
    SET NOCOUNT ON;
    INSERT INTO Flight.Country
    (ISO2,ISO3,CurrencyName,Latitude,Longitude,CountryName)
    VALUES
    (@ISO2,@ISO3,@CurrencyName,@Latitude,@Longitude,@CountryName);
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spUpdateCountry'
)
DROP PROCEDURE Flight.spUpdateCountry
GO
CREATE PROCEDURE Flight.spUpdateCountry
    @CountryID int,
    @ISO2 CHAR(2),
    @ISO3 CHAR(3),
    @CurrencyName varchar(100),
    @Latitude NUMERIC(10,8),
    @Longitude NUMERIC(11,8),
    @CountryName varchar(100)
AS
    SET NOCOUNT ON;
    UPDATE Flight.Country
    SET
        ISO2 = @ISO2,
        ISO3 = @ISO3,
        CurrencyName = @CurrencyName,
        Latitude = @Latitude,
        Longitude = @Longitude,
        CountryName = @CountryName
    WHERE Country.CountryID = @CountryID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spSearchCountryByID'
)
DROP PROCEDURE Flight.spSearchCountryByID
GO
CREATE PROCEDURE Flight.spSearchCountryByID
    @CountryID int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Flight.Country
    WHERE CountryID = @CountryID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spAddAirportType'
)
DROP PROCEDURE Airport.spAddAirportType
GO
CREATE PROCEDURE Airport.spAddAirportType
    @AirportTypeName varchar(100),
    @Description varchar(200)
AS
    SET NOCOUNT ON;
    INSERT INTO Airport.AirportType
    ([AirportTypeName],[Description])
    VALUES
    (@AirportTypeName,@Description);
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spUpdateAirportType'
)
DROP PROCEDURE Airport.spUpdateAirportType
GO
CREATE PROCEDURE Airport.spUpdateAirportType
    @AirportTypeID int,
    @AirportTypeName varchar(100),
    @Description varchar(200)
AS
    SET NOCOUNT ON;
    UPDATE Airport.AirportType
    SET
        [AirportTypeName] = @AirportTypeName,
        [Description] = @Description
    WHERE AirportTypeID = @AirportTypeID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spSearchAirportTypeByID'
)
DROP PROCEDURE Airport.spSearchAirportTypeByID
GO
CREATE PROCEDURE Airport.spSearchAirportTypeByID
    @AirportTypeID int
AS
    SET NOCOUNT ON;
    SELECT *
    FROM Airport.AirportType
    WHERE AirportType.AirportTypeID = @AirportTypeID;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spAddPlane'
)
DROP PROCEDURE Airport.spAddPlane
GO
CREATE PROCEDURE [Airport].[spAddPlane]
     @ModelID int
    ,@SeatingCapacity int
    ,@StatusPlaneID int
    ,@AdmissionDate date
    ,@RetirementDate date
    ,@SeatingCapacityHigh int
    ,@SeatingCapacityMedium int
    ,@SeatingCapacityLow int
    ,@BelongingAirport int

AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO [Airport].[Plane] (
            [ModelID]
            ,[SeatingCapacity]
            ,[StatusPlaneID]
            ,[AdmissionDate]
            ,[RetirementDate]
            ,[SeatingCapacityHigh]
            ,[SeatingCapacityMedium]
            ,[SeatingCapacityLow]
            ,[BelongingAirport]
        )
        VALUES (
            @ModelID
            ,@SeatingCapacity
            ,@StatusPlaneID
            ,@AdmissionDate
            ,@RetirementDate
            ,@SeatingCapacityHigh
            ,@SeatingCapacityMedium
            ,@SeatingCapacityLow
            ,@BelongingAirport
        );
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spUpdatePlane'
)
DROP PROCEDURE Airport.spUpdatePlane
GO
CREATE PROCEDURE [Airport].[spUpdatePlane] (
     @PlaneID int = NULL
    ,@ModelID int = NULL
    ,@SeatingCapacity int = NULL
    ,@StatusPlaneID int = NULL
    ,@AdmissionDate date = NULL
    ,@RetirementDate date = NULL
    ,@SeatingCapacityHigh int = NULL
    ,@SeatingCapacityMedium int = NULL
    ,@SeatingCapacityLow int = NULL
    ,@BelongingAirport int = NULL
)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE
            [Airport].[Plane] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [ModelID] = @ModelID
            ,[SeatingCapacity] = @SeatingCapacity
            ,[StatusPlaneID] = @StatusPlaneID
            ,[AdmissionDate] = @AdmissionDate
            ,[RetirementDate] = @RetirementDate
            ,[SeatingCapacityHigh] = @SeatingCapacityHigh
            ,[SeatingCapacityMedium] = @SeatingCapacityMedium
            ,[SeatingCapacityLow] = @SeatingCapacityLow
            ,[BelongingAirport] = @BelongingAirport
        WHERE
            [PlaneID] = @PlaneID;
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spSearchPlaneByID'
)
DROP PROCEDURE Airport.spSearchPlaneByID
GO
CREATE PROCEDURE [Airport].[spSearchPlaneByID] (
    @PlaneID int
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SELECT
            *
        FROM
            [Airport].[Plane] AS [P]
        WHERE
            [P].[PlaneID] = @PlaneID
    END;
GO
