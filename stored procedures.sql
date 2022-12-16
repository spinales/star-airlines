
/*
Lista de buenas practicas:
- SET NOCOUNT ON; en todos los stored procedures
- WITH (UPDLOCK, SERIALIZABLE); en todos stored procedures
- SET ANSI_NULLS ON; todos los stored procedures
- SET QUOTED_IDENTIFIER OFF; todos los stored procedures
- Quitar nulls a los campos que estan por default
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
/*
    -- faltan por probar
*/

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spAddFlightBenefit'
)
DROP PROCEDURE Flight.spAddFlightBenefit
GO
CREATE PROCEDURE [Flight].[spAddFlightBenefit] (
     @FlightBenefitName varchar(100) = NULL
    ,@Description varchar(200) = NULL
    ,@Cost money = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        INSERT INTO [Flight].[FlightBenefit] (
                [FlightBenefitName]
               ,[Description]
               ,[Cost]
        )
        VALUES (
                @FlightBenefitName
               ,@Description
               ,@Cost
        );
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spUpdateFlightBenefit'
)
DROP PROCEDURE Flight.spUpdateFlightBenefit
GO
CREATE PROCEDURE [Flight].[spUpdateFlightBenefit] (
     @FlightBenefitID int = NULL
    ,@FlightBenefitName varchar(100) = NULL
    ,@Description varchar(200) = NULL
    ,@Cost money = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        UPDATE
            [Flight].[FlightBenefit] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [FlightBenefitName] = @FlightBenefitName
            ,[Description] = @Description
            ,[Cost] = @Cost
        WHERE
            [FlightBenefitID] = @FlightBenefitID;
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spSearchFlightBenefitByID'
)
DROP PROCEDURE Flight.spSearchFlightBenefitByID
GO
CREATE PROCEDURE [Flight].[spSearchFlightBenefitByID] (
    @FlightBenefitID int
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SELECT *
        FROM
            [Flight].[FlightBenefit] AS [FB]
        WHERE
            [FB].[FlightBenefitID] = @FlightBenefitID

    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spAddFlightType'
)
DROP PROCEDURE Flight.spAddFlightType
GO
CREATE PROCEDURE [Flight].[spAddFlightType] (
     @FlightTypeName varchar(100) = NULL
    ,@Description varchar(200) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        INSERT INTO [Flight].[FlightType] (
                [FlightTypeName]
               ,[Description]
        )
        VALUES (
                @FlightTypeName
               ,@Description
        );
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spUpdateFlightType'
)
DROP PROCEDURE Flight.spUpdateFlightType
GO
CREATE PROCEDURE [Flight].[spUpdateFlightType] (
     @FlightTypeID int = NULL
    ,@FlightTypeName varchar(100) = NULL
    ,@Description varchar(200) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
		UPDATE
            [Flight].[FlightType] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [FlightTypeName] = @FlightTypeName
            ,[Description] = @Description
        WHERE
            [FlightTypeID] = @FlightTypeID;
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spSearchFlightTypeByID'
)
DROP PROCEDURE Flight.spSearchFlightTypeByID
GO
CREATE PROCEDURE [Flight].[spSearchFlightTypeByID] (
    @FlightTypeID int
)
AS
    BEGIN

        SET NOCOUNT, XACT_ABORT ON;

        SELECT
             [FlightTypeID] = [FT].[FlightTypeID]
            ,[FlightTypeName] = [FT].[FlightTypeName]
            ,[Description] = [FT].[Description]
        FROM
            [Flight].[FlightType] AS [FT]
        WHERE
            [FT].[FlightTypeID] = @FlightTypeID

    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spAddTicketType'
)
DROP PROCEDURE Flight.spAddTicketType
GO
CREATE PROCEDURE [Flight].[spAddTicketType] (
     @TicketTypeName varchar(100) = NULL
    ,@Description varchar(200) = NULL
    ,@Cost money = NULL
    ,@FreeWeight int = NULL
    ,@Acronym char(4) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        INSERT INTO [Flight].[TicketType] (
                [TicketTypeName]
               ,[Description]
               ,[Cost]
               ,[FreeWeight]
               ,[Acronym]
        )
        VALUES (
                @TicketTypeName
               ,@Description
               ,@Cost
               ,@FreeWeight
               ,@Acronym
        );
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spUpdateTicketType'
)
DROP PROCEDURE Flight.spUpdateTicketType
GO
CREATE PROCEDURE [Flight].[spUpdateTicketType] (
     @TicketTypeID int = NULL
    ,@TicketTypeName varchar(100) = NULL
    ,@Description varchar(200) = NULL
    ,@Cost money = NULL
    ,@FreeWeight int = NULL
    ,@Acronym char(4) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        UPDATE
            [Flight].[TicketType] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [TicketTypeName] = @TicketTypeName
            ,[Description] = @Description
            ,[Cost] = @Cost
            ,[FreeWeight] = @FreeWeight
            ,[Acronym] = @Acronym
        WHERE
            [TicketTypeID] = @TicketTypeID;
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spSearchTicketTypeByID'
)
DROP PROCEDURE Flight.spSearchTicketTypeByID
GO
CREATE PROCEDURE [Flight].[spSearchTicketTypeByID] (
    @TicketTypeID int
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SELECT *
        FROM
            [Flight].[TicketType] AS [TT]
        WHERE
            [TT].[TicketTypeID] = @TicketTypeID
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spAddFlightSchedule'
)
DROP PROCEDURE Flight.spAddFlightSchedule
GO
CREATE PROCEDURE [Flight].[spAddFlightSchedule] (
     @DepartureDate datetime = NULL
    ,@ArrivalDate datetime = NULL
    ,@PlaneID int = NULL
    ,@Pilot int = NULL
    ,@CoPilot int = NULL
    ,@FlightID int = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        INSERT INTO [Flight].[FlightSchedule] (
                [DepartureDate]
               ,[ArrivalDate]
               ,[PlaneID]
               ,[Pilot]
               ,[CoPilot]
               ,[FlightID]
        )
        VALUES (
                @DepartureDate
               ,@ArrivalDate
               ,@PlaneID
               ,@Pilot
               ,@CoPilot
               ,@FlightID
        );
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spUpdateFlightSchedule'
)
DROP PROCEDURE Flight.spUpdateFlightSchedule
GO
CREATE PROCEDURE [Flight].[spUpdateFlightSchedule] (
     @FlightScheduleID int = NULL
    ,@DepartureDate datetime = NULL
    ,@ArrivalDate datetime = NULL
    ,@PlaneID int = NULL
    ,@Pilot int = NULL
    ,@CoPilot int = NULL
    ,@FlightID int = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        UPDATE
            [Flight].[FlightSchedule] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [DepartureDate] = @DepartureDate
            ,[ArrivalDate] = @ArrivalDate
            ,[PlaneID] = @PlaneID
            ,[Pilot] = @Pilot
            ,[CoPilot] = @CoPilot
            ,[FlightID] = @FlightID
        WHERE
            [FlightScheduleID] = @FlightScheduleID;
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spSearchFlightScheduleByID'
)
DROP PROCEDURE Flight.spSearchFlightScheduleByID
GO
CREATE PROCEDURE [Flight].[spSearchFlightScheduleByID] (
    @FlightScheduleID int
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SELECT *
        FROM
            [Flight].[FlightSchedule] AS [FS]
        WHERE
            [FS].[FlightScheduleID] = @FlightScheduleID
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spAddStatusLuggage'
)
DROP PROCEDURE Flight.spAddStatusLuggage
GO
CREATE PROCEDURE [Flight].[spAddStatusLuggage] (
     @StatusLuggageName varchar(100) = NULL
    ,@Description varchar(200) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        INSERT INTO [Flight].[StatusLuggage] (
                [StatusLuggageName]
               ,[Description]
        )
        VALUES (
                @StatusLuggageName
               ,@Description
        );
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spUpdateStatusLuggage'
)
DROP PROCEDURE Flight.spUpdateStatusLuggage
GO
CREATE PROCEDURE [Flight].[spUpdateStatusLuggage] (
     @StatusLuggageID int = NULL
    ,@StatusLuggageName varchar(100) = NULL
    ,@Description varchar(200) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        UPDATE
            [Flight].[StatusLuggage] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [StatusLuggageName] = @StatusLuggageName
            ,[Description] = @Description
        WHERE
            [StatusLuggageID] = @StatusLuggageID;
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spSearchStatusLuggageByID'
)
DROP PROCEDURE Flight.spSearchStatusLuggageByID
GO
CREATE PROCEDURE [Flight].[spSearchStatusLuggageByID] (
    @StatusLuggageID int
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SELECT *
        FROM
            [Flight].[StatusLuggage] AS [SL]
        WHERE
            [SL].[StatusLuggageID] = @StatusLuggageID
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spAddBrand'
)
DROP PROCEDURE Airport.spAddBrand
GO
CREATE PROCEDURE [Airport].[spAddBrand] (
     @BrandName varchar(100) = NULL
    ,@Description varchar(200) = NULL
    ,@Email varchar(100) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        INSERT INTO [Airport].[Brand] (
                [BrandName]
               ,[Description]
               ,[Email]
        )
        VALUES (
                @BrandName
               ,@Description
               ,@Email
        );
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spUpdateBrand'
)
DROP PROCEDURE Airport.spUpdateBrand
GO
CREATE PROCEDURE [Airport].[spUpdateBrand] (
     @BrandID int = NULL
    ,@BrandName varchar(100) = NULL
    ,@Description varchar(200) = NULL
    ,@Email varchar(100) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        UPDATE
            [Airport].[Brand] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [BrandName] = @BrandName
            ,[Description] = @Description
            ,[Email] = @Email
        WHERE
            [BrandID] = @BrandID;
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spSearchBrandByID'
)
DROP PROCEDURE Airport.spSearchBrandByID
GO
CREATE PROCEDURE [Airport].[spSearchBrandByID] (
    @BrandID int
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SELECT *
        FROM
            [Airport].[Brand] AS [B]
        WHERE
            [B].[BrandID] = @BrandID

    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spAddPlaneModel'
)
DROP PROCEDURE Airport.spAddPlaneModel
GO
CREATE PROCEDURE [Airport].[spAddPlaneModel] (
     @ModelName varchar(100) = NULL
    ,@Description varchar(250) = NULL
    ,@BrandID int = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        INSERT INTO [Airport].[Model] (
                [ModelName]
               ,[Description]
               ,[BrandID]
        )
        VALUES (
                @ModelName
               ,@Description
               ,@BrandID
        );
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spUpdatePlaneModel'
)
DROP PROCEDURE Airport.spUpdatePlaneModel
GO
CREATE PROCEDURE [Airport].[spUpdatePlaneModel] (
     @ModelID int = NULL
    ,@ModelName varchar(100) = NULL
    ,@Description varchar(250) = NULL
    ,@BrandID int = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        UPDATE
            [Airport].[Model] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [ModelName] = @ModelName
            ,[Description] = @Description
            ,[BrandID] = @BrandID
        WHERE
            [ModelID] = @ModelID;
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Airport'
    AND SPECIFIC_NAME = N'spSearchPlaneModelByID'
)
DROP PROCEDURE Airport.spSearchPlaneModelByID
GO
CREATE PROCEDURE [Airport].[spSearchPlaneModelByID] (
    @ModelID int
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SELECT
             [ModelID] = [M].[ModelID]
            ,[ModelName] = [M].[ModelName]
            ,[Description] = [M].[Description]
            ,[BrandID] = [M].[BrandID]
        FROM
            [Airport].[Model] AS [M]
        WHERE
            [M].[ModelID] = @ModelID
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'spAddPerson'
)
DROP PROCEDURE Person.spAddPerson
GO
CREATE PROCEDURE [Person].[spAddPerson] (
     @FirstName varchar(100) = NULL
    ,@LastName varchar(100) = NULL
    ,@AdmissionDate date = NULL
    ,@Nationality int = NULL
    ,@Gender char(1) = NULL
    ,@Document varchar(20) = NULL
    ,@DocumentTypeID int = NULL
    ,@PhoneNumber varchar(15) = NULL
    ,@DOB date = NULL
    ,@BloodType int = NULL
    ,@Direction varchar(250) = NULL
    ,@Email varchar(100) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        INSERT INTO [Person].[Person] (
                [FirstName]
               ,[LastName]
               ,[AdmissionDate]
               ,[Nationality]
               ,[Gender]
               ,[Document]
               ,[DocumentTypeID]
               ,[PhoneNumber]
               ,[DOB]
               ,[BloodType]
               ,[Direction]
               ,[Email]
        )
        VALUES (
                @FirstName
               ,@LastName
               ,@AdmissionDate
               ,@Nationality
               ,@Gender
               ,@Document
               ,@DocumentTypeID
               ,@PhoneNumber
               ,@DOB
               ,@BloodType
               ,@Direction
               ,@Email
        );
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'spUpdatePerson'
)
DROP PROCEDURE Person.spUpdatePerson
GO
CREATE PROCEDURE [Person].[spUpdatePerson] (
     @PersonID int = NULL
    ,@FirstName varchar(100) = NULL
    ,@LastName varchar(100) = NULL
    ,@AdmissionDate date = NULL
    ,@Nationality int = NULL
    ,@Gender char(1) = NULL
    ,@Document varchar(20) = NULL
    ,@DocumentTypeID int = NULL
    ,@PhoneNumber varchar(15) = NULL
    ,@DOB date = NULL
    ,@BloodType int = NULL
    ,@Direction varchar(250) = NULL
    ,@Email varchar(100) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        UPDATE
            [Person].[Person] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [FirstName] = @FirstName
            ,[LastName] = @LastName
            ,[AdmissionDate] = @AdmissionDate
            ,[Nationality] = @Nationality
            ,[Gender] = @Gender
            ,[Document] = @Document
            ,[DocumentTypeID] = @DocumentTypeID
            ,[PhoneNumber] = @PhoneNumber
            ,[DOB] = @DOB
            ,[BloodType] = @BloodType
            ,[Direction] = @Direction
            ,[Email] = @Email
        WHERE
            [PersonID] = @PersonID;
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'spSearchPersonByID'
)
DROP PROCEDURE Person.spSearchPersonByID
GO
CREATE PROCEDURE [Person].[spSearchPersonByID] (
    @PersonID int
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SELECT
             [PersonID] = [P].[PersonID]
            ,[FirstName] = [P].[FirstName]
            ,[LastName] = [P].[LastName]
            ,[AdmissionDate] = [P].[AdmissionDate]
            ,[Nationality] = [P].[Nationality]
            ,[Gender] = [P].[Gender]
            ,[Document] = [P].[Document]
            ,[DocumentTypeID] = [P].[DocumentTypeID]
            ,[PhoneNumber] = [P].[PhoneNumber]
            ,[DOB] = [P].[DOB]
            ,[BloodType] = [P].[BloodType]
            ,[Direction] = [P].[Direction]
            ,[Email] = [P].[Email]
        FROM
            [Person].[Person] AS [P]
        WHERE
            [P].[PersonID] = @PersonID
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'spAddDocumentType'
)
DROP PROCEDURE Person.spAddDocumentType
GO
CREATE PROCEDURE [Person].[spAddDocumentType] (
     @DocumentTypeName varchar(100) = NULL
    ,@Description varchar(200) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        INSERT INTO [Person].[DocumentType] (
                [DocumentTypeName]
               ,[Description]
        )
        VALUES (
                @DocumentTypeName
               ,@Description
        );
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'spUpdateDocumentType'
)
DROP PROCEDURE Person.spUpdateDocumentType
GO
CREATE PROCEDURE [Person].[spUpdateDocumentType] (
     @DocumentTypeID int = NULL
    ,@DocumentTypeName varchar(100) = NULL
    ,@Description varchar(200) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        UPDATE
            [Person].[DocumentType] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [DocumentTypeName] = @DocumentTypeName
            ,[Description] = @Description
        WHERE
            [DocumentTypeID] = @DocumentTypeID;
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'spSearchDocumentTypeByID'
)
DROP PROCEDURE Person.spSearchDocumentTypeByID
GO
CREATE PROCEDURE [Person].[spSearchDocumentTypeByID] (
    @DocumentTypeID int
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SELECT
             [DocumentTypeID] = [DT].[DocumentTypeID]
            ,[DocumentTypeName] = [DT].[DocumentTypeName]
            ,[Description] = [DT].[Description]
        FROM
            [Person].[DocumentType] AS [DT]
        WHERE
            [DT].[DocumentTypeID] = @DocumentTypeID
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'spAddEmployeeRole'
)
DROP PROCEDURE Person.spAddEmployeeRole
GO
CREATE PROCEDURE [Person].[spAddEmployeeRole] (
     @EmployeeRoleName varchar(100) = NULL
    ,@Description varchar(200) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        INSERT INTO [Person].[EmployeeRole] (
                [EmployeeRoleName]
               ,[Description]
        )
        VALUES (
                @EmployeeRoleName
               ,@Description
        );
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'spUpdateEmployeeRole'
)
DROP PROCEDURE Person.spUpdateEmployeeRole
GO
CREATE PROCEDURE [Person].[spUpdateEmployeeRole] (
     @EmployeeRoleID int = NULL
    ,@EmployeeRoleName varchar(100) = NULL
    ,@Description varchar(200) = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        UPDATE
            [Person].[EmployeeRole] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [EmployeeRoleName] = @EmployeeRoleName
            ,[Description] = @Description
        WHERE
            [EmployeeRoleID] = @EmployeeRoleID;
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Person'
    AND SPECIFIC_NAME = N'spSearchEmployeeRoleByID'
)
DROP PROCEDURE Person.spSearchEmployeeRoleByID
GO
CREATE PROCEDURE [Person].[spSearchEmployeeRoleByID] (
    @EmployeeRoleID int
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SELECT *
        FROM
            [Person].[EmployeeRole] AS [ER]
        WHERE
            [ER].[EmployeeRoleID] = @EmployeeRoleID
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spAddFlight'
)
DROP PROCEDURE Flight.spAddFlight
GO
CREATE PROCEDURE [Flight].[spAddFlight] (
     @DestinationID int = NULL
    ,@DestinationAirportID int = NULL
    ,@TravelDistance int = NULL
    ,@FlightCost int = NULL
    ,@TravelDuration time(7) = NULL
    ,@FlightTypeID int = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        INSERT INTO [Flight].[Flight] (
                [DestinationID]
               ,[DestinationAirportID]
               ,[TravelDistance]
               ,[FlightCost]
               ,[TravelDuration]
               ,[FlightTypeID]
        )
        VALUES (
                @DestinationID
               ,@DestinationAirportID
               ,@TravelDistance
               ,@FlightCost
               ,@TravelDuration
               ,@FlightTypeID
        );
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spUpdateFlight'
)
DROP PROCEDURE Flight.spUpdateFlight
GO
CREATE PROCEDURE [Flight].[spUpdateFlight] (
     @FlightID int = NULL
    ,@DestinationID int = NULL
    ,@DestinationAirportID int = NULL
    ,@TravelDistance int = NULL
    ,@FlightCost int = NULL
    ,@TravelDuration time(7) = NULL
    ,@FlightTypeID int = NULL
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        UPDATE
            [Flight].[Flight] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [DestinationID] = @DestinationID
            ,[DestinationAirportID] = @DestinationAirportID
            ,[TravelDistance] = @TravelDistance
            ,[FlightCost] = @FlightCost
            ,[TravelDuration] = @TravelDuration
            ,[FlightTypeID] = @FlightTypeID
        WHERE
            [FlightID] = @FlightID;
    END;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Flight'
    AND SPECIFIC_NAME = N'spSearchFlightByID'
)
DROP PROCEDURE Flight.spSearchFlightByID
GO
CREATE PROCEDURE [Flight].[spSearchFlightByID] (
    @FlightID int
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SELECT *
        FROM
            [Flight].[Flight] AS [F]
        WHERE
            [F].[FlightID] = @FlightID
    END;
GO






























-- Test cases
-- example to execute the stored procedure we just created
EXECUTE Flight.spAddFlightBenefit 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spUpdateFlightBenefit 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spSearchFlightBenefitByID 1
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spAddFlightType 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spUpdateFlightType 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spSearchFlightTypeByID 1
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spAddTicketType 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spUpdateTicketType 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spSearchTicketTypeByID 1
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spAddFlightSchedule 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spUpdateFlightSchedule 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spSearchFlightScheduleByID 1
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spAddStatusLuggage 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spUpdateStatusLuggage 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spSearchStatusLuggageByID 1
GO
-- example to execute the stored procedure we just created
EXECUTE Airport.spAddBrand 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Airport.spUpdateBrand 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Airport.spSearchBrandByID 1
GO
-- example to execute the stored procedure we just created
EXECUTE Airport.spAddPlaneModel 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Airport.spUpdatePlaneModel 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Airport.spSearchPlaneModelByID 1
GO
-- example to execute the stored procedure we just created
EXECUTE Person.spAddPerson 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Person.spUpdatePerson 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Person.spSearchPersonByID 1
GO
-- example to execute the stored procedure we just created
EXECUTE Person.spAddDocumentType 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Person.spUpdateDocumentType 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Person.spSearchDocumentTypeByID 1
GO
-- example to execute the stored procedure we just created
EXECUTE Person.spAddEmployeeRole 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Person.spUpdateEmployeeRole 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Person.spSearchEmployeeRoleByID 1
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spAddFlight 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spUpdateFlight 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
-- example to execute the stored procedure we just created
EXECUTE Flight.spSearchFlightByID 1
GO