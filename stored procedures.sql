DROP PROCEDURE IF EXISTS Flight.spSearchFlightByFlightType
GO
CREATE PROCEDURE Flight.spSearchFlightByFlightType(
    @FlightType int
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM Flight.Flight
    WHERE Flight.Flight.FlightTypeID = @FlightType;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchFlightByRangeOfCost;
GO
CREATE PROCEDURE Flight.spSearchFlightByRangeOfCost(
    @Min int = 0,
    @Max int
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM Flight.Flight
    WHERE Flight.FlightCost >= @Min
      AND Flight.FlightCost <= @Max;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchFlightByDestiny;
GO
CREATE PROCEDURE Flight.spSearchFlightByDestiny (
    @DestinationID int
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM Flight.Flight
    Where Flight.DestinationID = @DestinationID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchTicketByClientID
GO
CREATE PROCEDURE Flight.spSearchTicketByClientID @ClientID int
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM Flight.Ticket
    WHERE Ticket.PersonID = @ClientID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Airport.spSearchPlaneByModelID;
GO
CREATE PROCEDURE Airport.spSearchPlaneByModelID (
    @ModelID int
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM Airport.Plane
    WHERE Plane.ModelID = @ModelID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchFlightScheduleByFlight;
GO
CREATE PROCEDURE Flight.spSearchFlightScheduleByFlight (
    @FlightID int
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM Flight.FlightSchedule
    WHERE FlightSchedule.FlightID = @FlightID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchFlightScheduleByDestiny;
GO
CREATE PROCEDURE Flight.spSearchFlightScheduleByDestiny @DestinationID int
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    Declare @IDs Table
             ( id INT );
    Insert Into @IDs (id) (SELECT Flight.Flight.FlightID
                           From Flight.Flight
                           WHERE Flight.DestinationID = @DestinationID);

    SELECT *
    FROM Flight.FlightSchedule
    WHERE FlightSchedule.FlightScheduleID IN (SELECT id from @IDs);
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchFlightScheduleByRangeOfDate;
GO
CREATE PROCEDURE Flight.spSearchFlightScheduleByRangeOfDate (
    @StartDate DATETIME,
    @EndDate DATETIME
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM Flight.FlightSchedule
    WHERE Flight.FlightSchedule.ArrivalDate BETWEEN @StartDate AND @EndDate;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Airport.spSearchPlaneByID
GO
CREATE PROCEDURE Airport.spSearchPlaneByID (
    @PlaneID int
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM Airport.Plane
    WHERE Plane.PlaneID = @PlaneID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Airport.spSearchAirportByState
GO
CREATE PROCEDURE Airport.spSearchAirportByState (
    @StateID int
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM Airport.Plane
    WHERE Plane.StatusPlaneID = @StateID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Person.spSearchPersonByDocument
GO
CREATE PROCEDURE Person.spSearchPersonByDocument (
    @Document varchar(20)
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT  [PersonID] = [P].[PersonID]
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
    FROM Person.Person P
    WHERE P.Document = @Document;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Person.spSearchEmployeeByRole
GO
CREATE PROCEDURE Person.spSearchEmployeeByRole @RoleID int
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT  [PersonID] = [P].[PersonID]
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
    FROM Person.Person P
             INNER JOIN Person.Employee_EmployeeRole on Person.Employee_EmployeeRole.EmployeeID = P.PersonID
    WHERE Person.Employee_EmployeeRole.EmployeeRoleID = @RoleID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Person.spSearchAllEmployees
GO
CREATE PROCEDURE Person.spSearchAllEmployees
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT  [PersonID] = [P].[PersonID]
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
    FROM Person.Person P
         INNER JOIN Person.Employee_EmployeeRole on Person.Employee_EmployeeRole.EmployeeID = P.PersonID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Person.spSearchAllPersons
GO
CREATE PROCEDURE Person.spSearchAllPersons
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    Declare @IDs Table ( id INT );
    Insert Into @IDs (id) (SELECT P.PersonID
       FROM Person.Person P
                INNER JOIN Person.Employee_EmployeeRole
                           on Person.Employee_EmployeeRole.EmployeeID = P.PersonID);

    SELECT  [PersonID] = [P].[PersonID]
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
    FROM Person.Person P
    WHERE P.PersonID NOT IN (SELECT id from @IDs);
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Airport.spSearchPlaneByBrand
GO
CREATE PROCEDURE Airport.spSearchPlaneByBrand (
    @BrandID int
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    Declare
        @IDs Table
             (
                 id INT
             );
    Insert Into @IDs (id) (SELECT Model.ModelID
                           FROM Airport.Model
                           Where Model.BrandID = @BrandID);

    SELECT *
    FROM Airport.Plane
    WHERE Plane.ModelID IN (SELECT id from @IDs);
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Airport.spAddAirport
GO
CREATE PROCEDURE Airport.spAddAirport (
    @AirportName varchar(200),
    @DestinationID int,
    @Direction varchar(250),
    @AirportTypeID int
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO Airport.Airport
        (AirportName, DestinationID, Direction, AirportTypeID)
    VALUES (@AirportName, @DestinationID, @Direction, @AirportTypeID);
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Airport.spUpdateAirport
GO
CREATE PROCEDURE Airport.spUpdateAirport (
    @AirportID int,
    @AirportName varchar(200),
    @DestinationID int,
    @Direction varchar(250),
    @AirportTypeID int
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE Airport.Airport
    WITH (UPDLOCK, SERIALIZABLE)
    SET AirportName   = @AirportName,
        DestinationID = @DestinationID,
        Direction     = @Direction,
        AirportTypeID = @AirportTypeID
    WHERE Airport.AirportID = @AirportID
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Airport.spSearchAirportByID
GO
CREATE PROCEDURE Airport.spSearchAirportByID @AirportID int
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM Airport.Airport
    Where Airport.AirportID = @AirportID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Flight.spAddDestination
GO
CREATE PROCEDURE Flight.spAddDestination (
    @CountryID int,
    @DestinationName varchar(100),
    @Acronym varchar(4),
    @Latitude NUMERIC(10, 8),
    @Longitude NUMERIC(11, 8)
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Geo].[Destination]
        (CountryID, DestinationName, Acronym, Latitude, Longitude)
    VALUES (@CountryID, @DestinationName, @Acronym, @Latitude, @Longitude);
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Flight.spUpdateDestination
GO
CREATE PROCEDURE Flight.spUpdateDestination (
    @DestinationID int,
    @CountryID int,
    @DestinationName varchar(100),
    @Acronym varchar(4),
    @Latitude NUMERIC(10, 8),
    @Longitude NUMERIC(11, 8)
)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE [Geo].[Destination]
    WITH (UPDLOCK, SERIALIZABLE)
    SET CountryID       = @CountryID,
        DestinationName = @DestinationName,
        Acronym         = @Acronym,
        Latitude        = @Latitude,
        Longitude       = @Longitude
    WHERE Destination.DestinationID = @DestinationID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchDestinationByID
GO
CREATE PROCEDURE Flight.spSearchDestinationByID @DestinationID int
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM [Geo].[Destination]
    WHERE Destination.DestinationID = @DestinationID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Flight.spAddCountry
GO
CREATE PROCEDURE Flight.spAddCountry @ISO2 CHAR(2),
                                     @ISO3 CHAR(3),
                                     @CurrencyName varchar(100),
                                     @Latitude NUMERIC(10, 8),
                                     @Longitude NUMERIC(11, 8),
                                     @CountryName varchar(100)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Geo].[Country]
        (ISO2, ISO3, CurrencyName, Latitude, Longitude, CountryName)
    VALUES (@ISO2, @ISO3, @CurrencyName, @Latitude, @Longitude, @CountryName);
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Flight.spUpdateCountry
GO
CREATE PROCEDURE Flight.spUpdateCountry @CountryID int,
                                        @ISO2 CHAR(2),
                                        @ISO3 CHAR(3),
                                        @CurrencyName varchar(100),
                                        @Latitude NUMERIC(10, 8),
                                        @Longitude NUMERIC(11, 8),
                                        @CountryName varchar(100)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE [Geo].[Country]
    WITH (UPDLOCK, SERIALIZABLE)
    SET ISO2         = @ISO2,
        ISO3         = @ISO3,
        CurrencyName = @CurrencyName,
        Latitude     = @Latitude,
        Longitude    = @Longitude,
        CountryName  = @CountryName
    WHERE Country.CountryID = @CountryID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchCountryByID
GO
CREATE PROCEDURE Flight.spSearchCountryByID @CountryID int
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM [Geo].[Country]
    WHERE CountryID = @CountryID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Airport.spAddAirportType
GO
CREATE PROCEDURE Airport.spAddAirportType @AirportTypeName varchar(100),
                                          @Description varchar(200)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO Airport.AirportType
        ([AirportTypeName], [Description])
    VALUES (@AirportTypeName, @Description);
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Airport.spUpdateAirportType
GO
CREATE PROCEDURE Airport.spUpdateAirportType @AirportTypeID int,
                                             @AirportTypeName varchar(100),
                                             @Description varchar(200)
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE Airport.AirportType
    WITH (UPDLOCK, SERIALIZABLE)
    SET [AirportTypeName] = @AirportTypeName,
        [Description]     = @Description
    WHERE AirportTypeID = @AirportTypeID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Airport.spSearchAirportTypeByID
GO
CREATE PROCEDURE Airport.spSearchAirportTypeByID @AirportTypeID int
AS
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM Airport.AirportType
    WHERE AirportType.AirportTypeID = @AirportTypeID;
    COMMIT TRANSACTION;
GO

DROP PROCEDURE IF EXISTS Airport.spAddPlane
GO
CREATE PROCEDURE [Airport].[spAddPlane] @ModelID int
, @SeatingCapacity int
, @StatusPlaneID int
, @AdmissionDate date
, @RetirementDate date
, @BelongingAirport int
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Airport].[Plane] ( [ModelID]
                                  , [SeatingCapacity]
                                  , [StatusPlaneID]
                                  , [AdmissionDate]
                                  , [RetirementDate]
                                  , [BelongingAirport])
    VALUES ( @ModelID
           , @SeatingCapacity
           , @StatusPlaneID
           , @AdmissionDate
           , @RetirementDate
           , @BelongingAirport);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Airport.spUpdatePlane
GO
CREATE PROCEDURE [Airport].[spUpdatePlane](
    @PlaneID int
, @ModelID int
, @SeatingCapacity int
, @StatusPlaneID int
, @AdmissionDate date
, @RetirementDate date
, @BelongingAirport int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Airport].[Plane] WITH (UPDLOCK, SERIALIZABLE)
    SET [ModelID]               = @ModelID
      , [SeatingCapacity]       = @SeatingCapacity
      , [StatusPlaneID]         = @StatusPlaneID
      , [AdmissionDate]         = @AdmissionDate
      , [RetirementDate]        = @RetirementDate
      , [BelongingAirport]      = @BelongingAirport
    WHERE [PlaneID] = @PlaneID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Airport.spSearchPlaneByID
GO
CREATE PROCEDURE [Airport].[spSearchPlaneByID](
    @PlaneID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM [Airport].[Plane] AS [P]
    WHERE [P].[PlaneID] = @PlaneID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spAddFlightBenefit
GO
CREATE PROCEDURE [Flight].[spAddFlightBenefit](
    @FlightBenefitName varchar(100)
, @Description varchar(200)
, @Cost money
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Flight].[FlightBenefit] ( [FlightBenefitName]
                                         , [Description]
                                         , [Cost])
    VALUES ( @FlightBenefitName
           , @Description
           , @Cost);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spUpdateFlightBenefit
GO
CREATE PROCEDURE [Flight].[spUpdateFlightBenefit](
    @FlightBenefitID int
, @FlightBenefitName varchar(100)
, @Description varchar(200)
, @Cost money
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Flight].[FlightBenefit] WITH (UPDLOCK, SERIALIZABLE)
    SET [FlightBenefitName] = @FlightBenefitName
      , [Description]       = @Description
      , [Cost]              = @Cost
    WHERE [FlightBenefitID] = @FlightBenefitID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchFlightBenefitByID
GO
CREATE PROCEDURE [Flight].[spSearchFlightBenefitByID](
    @FlightBenefitID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM [Flight].[FlightBenefit] AS [FB]
    WHERE [FB].[FlightBenefitID] = @FlightBenefitID
    COMMIT TRANSACTION;

END;
GO

DROP PROCEDURE IF EXISTS Flight.spAddFlightType
GO
CREATE PROCEDURE [Flight].[spAddFlightType](
    @FlightTypeName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Flight].[FlightType] ( [FlightTypeName]
                                      , [Description])
    VALUES ( @FlightTypeName
           , @Description);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spUpdateFlightType
GO
CREATE PROCEDURE [Flight].[spUpdateFlightType](
    @FlightTypeID int
, @FlightTypeName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Flight].[FlightType] WITH (UPDLOCK, SERIALIZABLE)
    SET [FlightTypeName] = @FlightTypeName
      , [Description]    = @Description
    WHERE [FlightTypeID] = @FlightTypeID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchFlightTypeByID
GO
CREATE PROCEDURE [Flight].[spSearchFlightTypeByID](
    @FlightTypeID int
)
AS
BEGIN

    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [FlightTypeID]   = [FT].[FlightTypeID]
         , [FlightTypeName] = [FT].[FlightTypeName]
         , [Description]    = [FT].[Description]
    FROM [Flight].[FlightType] AS [FT]
    WHERE [FT].[FlightTypeID] = @FlightTypeID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spAddTicketType
GO
CREATE PROCEDURE [Flight].[spAddTicketType](
    @TicketTypeName varchar(100)
, @Description varchar(200)
, @Cost money
, @FreeWeight int
, @Acronym char(4)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Flight].[TicketType] ( [TicketTypeName]
                                      , [Description]
                                      , [Cost]
                                      , [FreeWeight]
                                      , [Acronym])
    VALUES ( @TicketTypeName
           , @Description
           , @Cost
           , @FreeWeight
           , @Acronym);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spUpdateTicketType
GO
CREATE PROCEDURE [Flight].[spUpdateTicketType](
    @TicketTypeID int
, @TicketTypeName varchar(100)
, @Description varchar(200)
, @Cost money
, @FreeWeight int
, @Acronym char(4)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Flight].[TicketType] WITH (UPDLOCK, SERIALIZABLE)
    SET [TicketTypeName] = @TicketTypeName
      , [Description]    = @Description
      , [Cost]           = @Cost
      , [FreeWeight]     = @FreeWeight
      , [Acronym]        = @Acronym
    WHERE [TicketType].TicketTypeID = @TicketTypeID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchTicketTypeByID
GO
CREATE PROCEDURE [Flight].[spSearchTicketTypeByID](
    @TicketTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM [Flight].[TicketType] AS [TT]
    WHERE [TT].[TicketTypeID] = @TicketTypeID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spAddFlightSchedule
GO
CREATE PROCEDURE [Flight].[spAddFlightSchedule](
    @DepartureDate datetime
, @ArrivalDate datetime
, @PlaneID int
, @Pilot int
, @CoPilot int
, @FlightID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Flight].[FlightSchedule] ( [DepartureDate]
                                          , [ArrivalDate]
                                          , [PlaneID]
                                          , [Pilot]
                                          , [CoPilot]
                                          , [FlightID])
    VALUES ( @DepartureDate
           , @ArrivalDate
           , @PlaneID
           , @Pilot
           , @CoPilot
           , @FlightID);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spUpdateFlightSchedule
GO
CREATE PROCEDURE [Flight].[spUpdateFlightSchedule](
    @FlightScheduleID int
, @DepartureDate datetime
, @ArrivalDate datetime
, @PlaneID int
, @Pilot int
, @CoPilot int
, @FlightID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Flight].[FlightSchedule] WITH (UPDLOCK, SERIALIZABLE)
    SET [DepartureDate] = @DepartureDate
      , [ArrivalDate]   = @ArrivalDate
      , [PlaneID]       = @PlaneID
      , [Pilot]         = @Pilot
      , [CoPilot]       = @CoPilot
      , [FlightID]      = @FlightID
    WHERE [FlightScheduleID] = @FlightScheduleID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchFlightScheduleByID
GO
CREATE PROCEDURE [Flight].[spSearchFlightScheduleByID](
    @FlightScheduleID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM [Flight].[FlightSchedule] AS [FS]
    WHERE [FS].[FlightScheduleID] = @FlightScheduleID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spAddStatusLuggage
GO
CREATE PROCEDURE [Flight].[spAddStatusLuggage](
    @StatusLuggageName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Flight].[StatusLuggage] ( [StatusLuggageName]
                                         , [Description])
    VALUES ( @StatusLuggageName
           , @Description);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spUpdateStatusLuggage
GO
CREATE PROCEDURE [Flight].[spUpdateStatusLuggage](
    @StatusLuggageID int
, @StatusLuggageName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Flight].[StatusLuggage] WITH (UPDLOCK, SERIALIZABLE)
    SET [StatusLuggageName] = @StatusLuggageName
      , [Description]       = @Description
    WHERE [StatusLuggageID] = @StatusLuggageID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchStatusLuggageByID
GO
CREATE PROCEDURE [Flight].[spSearchStatusLuggageByID](
    @StatusLuggageID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM [Flight].[StatusLuggage] AS [SL]
    WHERE [SL].[StatusLuggageID] = @StatusLuggageID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spGetStatusLuggage
GO
CREATE PROCEDURE [Flight].[spGetStatusLuggage]
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM [Flight].[StatusLuggage] AS [SL]
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Airport.spAddBrand
GO
CREATE PROCEDURE [Airport].[spAddBrand](
    @BrandName varchar(100)
, @Description varchar(200)
, @Email varchar(100)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Airport].[Brand] ( [BrandName]
                                  , [Description]
                                  , [Email])
    VALUES ( @BrandName
           , @Description
           , @Email);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Airport.spUpdateBrand
GO
CREATE PROCEDURE [Airport].[spUpdateBrand](
    @BrandID int
, @BrandName varchar(100)
, @Description varchar(200)
, @Email varchar(100)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Airport].[Brand] WITH (UPDLOCK, SERIALIZABLE)
    SET [BrandName]   = @BrandName
      , [Description] = @Description
      , [Email]       = @Email
    WHERE [BrandID] = @BrandID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Airport.spSearchBrandByID
GO
CREATE PROCEDURE [Airport].[spSearchBrandByID](
    @BrandID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM [Airport].[Brand] AS [B]
    WHERE [B].[BrandID] = @BrandID
    COMMIT TRANSACTION;

END;
GO

DROP PROCEDURE IF EXISTS Airport.spAddPlaneModel
GO
CREATE PROCEDURE [Airport].[spAddPlaneModel](
    @ModelName varchar(100)
, @Description varchar(250)
, @BrandID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Airport].[Model] ( [ModelName]
                                  , [Description]
                                  , [BrandID])
    VALUES ( @ModelName
           , @Description
           , @BrandID);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Airport.spUpdatePlaneModel
GO
CREATE PROCEDURE [Airport].[spUpdatePlaneModel](
    @ModelID int
, @ModelName varchar(100)
, @Description varchar(250)
, @BrandID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Airport].[Model] WITH (UPDLOCK, SERIALIZABLE)
    SET [ModelName]   = @ModelName
      , [Description] = @Description
      , [BrandID]     = @BrandID
    WHERE [ModelID] = @ModelID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Airport.spSearchPlaneModelByID
GO
CREATE PROCEDURE [Airport].[spSearchPlaneModelByID](
    @ModelID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [ModelID]     = [M].[ModelID]
         , [ModelName]   = [M].[ModelName]
         , [Description] = [M].[Description]
         , [BrandID]     = [M].[BrandID]
    FROM [Airport].[Model] AS [M]
    WHERE [M].[ModelID] = @ModelID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Person.spAddPerson
GO
CREATE PROCEDURE [Person].[spAddPerson](
    @FirstName varchar(100)
, @LastName varchar(100)
, @AdmissionDate date
, @Nationality int
, @Gender char(1)
, @Document varchar(20)
, @DocumentTypeID int
, @PhoneNumber varchar(15)
, @DOB date
, @BloodType int
, @Direction varchar(250)
, @Email varchar(100)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Person].[Person] ( [FirstName]
                                  , [LastName]
                                  , [AdmissionDate]
                                  , [Nationality]
                                  , [Gender]
                                  , [Document]
                                  , [DocumentTypeID]
                                  , [PhoneNumber]
                                  , [DOB]
                                  , [BloodType]
                                  , [Direction]
                                  , [Email])
    VALUES ( @FirstName
           , @LastName
           , @AdmissionDate
           , @Nationality
           , @Gender
           , @Document
           , @DocumentTypeID
           , @PhoneNumber
           , @DOB
           , @BloodType
           , @Direction
           , @Email);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Person.spUpdatePerson
GO
CREATE PROCEDURE [Person].[spUpdatePerson](
    @PersonID int
, @FirstName varchar(100)
, @LastName varchar(100)
, @AdmissionDate date
, @Nationality int
, @Gender char(1)
, @Document varchar(20)
, @DocumentTypeID int
, @PhoneNumber varchar(15)
, @DOB date
, @BloodType int
, @Direction varchar(250)
, @Email varchar(100)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Person].[Person] WITH (UPDLOCK, SERIALIZABLE)
    SET [FirstName]      = @FirstName
      , [LastName]       = @LastName
      , [AdmissionDate]  = @AdmissionDate
      , [Nationality]    = @Nationality
      , [Gender]         = @Gender
      , [Document]       = @Document
      , [DocumentTypeID] = @DocumentTypeID
      , [PhoneNumber]    = @PhoneNumber
      , [DOB]            = @DOB
      , [BloodType]      = @BloodType
      , [Direction]      = @Direction
      , [Email]          = @Email
    WHERE [PersonID] = @PersonID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Person.spSearchPersonByID
GO
CREATE PROCEDURE [Person].[spSearchPersonByID](
    @PersonID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [PersonID]       = [P].[PersonID]
         , [FirstName]      = [P].[FirstName]
         , [LastName]       = [P].[LastName]
         , [AdmissionDate]  = [P].[AdmissionDate]
         , [Nationality]    = [P].[Nationality]
         , [Gender]         = [P].[Gender]
         , [Document]       = [P].[Document]
         , [DocumentTypeID] = [P].[DocumentTypeID]
         , [PhoneNumber]    = [P].[PhoneNumber]
         , [DOB]            = [P].[DOB]
         , [BloodType]      = [P].[BloodType]
         , [Direction]      = [P].[Direction]
         , [Email]          = [P].[Email]
    FROM [Person].[Person] AS [P]
    WHERE [P].[PersonID] = @PersonID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Person.spAddDocumentType
GO
CREATE PROCEDURE [Person].[spAddDocumentType](
    @DocumentTypeName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Person].[DocumentType] ( [DocumentTypeName]
                                        , [Description])
    VALUES ( @DocumentTypeName
           , @Description);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Person.spUpdateDocumentType
GO
CREATE PROCEDURE [Person].[spUpdateDocumentType](
    @DocumentTypeID int
, @DocumentTypeName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Person].[DocumentType] WITH (UPDLOCK, SERIALIZABLE)
    SET [DocumentTypeName] = @DocumentTypeName
      , [Description]      = @Description
    WHERE [DocumentTypeID] = @DocumentTypeID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Person.spSearchDocumentTypeByID
GO
CREATE PROCEDURE [Person].[spSearchDocumentTypeByID](
    @DocumentTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [DocumentTypeID]   = [DT].[DocumentTypeID]
         , [DocumentTypeName] = [DT].[DocumentTypeName]
         , [Description]      = [DT].[Description]
    FROM [Person].[DocumentType] AS [DT]
    WHERE [DT].[DocumentTypeID] = @DocumentTypeID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Person.spAddEmployeeRole
GO
CREATE PROCEDURE [Person].[spAddEmployeeRole](
    @EmployeeRoleName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Person].[EmployeeRole] ( [EmployeeRoleName]
                                        , [Description])
    VALUES ( @EmployeeRoleName
           , @Description);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Person.spUpdateEmployeeRole
GO
CREATE PROCEDURE [Person].[spUpdateEmployeeRole](
    @EmployeeRoleID int
, @EmployeeRoleName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Person].[EmployeeRole] WITH (UPDLOCK, SERIALIZABLE)
    SET [EmployeeRoleName] = @EmployeeRoleName
      , [Description]      = @Description
    WHERE [EmployeeRoleID] = @EmployeeRoleID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Person.spSearchEmployeeRoleByID
GO
CREATE PROCEDURE [Person].[spSearchEmployeeRoleByID](
    @EmployeeRoleID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM [Person].[EmployeeRole] AS [ER]
    WHERE [ER].[EmployeeRoleID] = @EmployeeRoleID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spAddFlight
GO
CREATE PROCEDURE [Flight].[spAddFlight](
    @DestinationID int
, @DestinationAirportID int
, @TravelDistance int
, @FlightCost int
, @TravelDuration time(7)
, @FlightTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Flight].[Flight] ( [DestinationID]
                                  , [DestinationAirportID]
                                  , [TravelDistance]
                                  , [FlightCost]
                                  , [TravelDuration]
                                  , [FlightTypeID])
    VALUES ( @DestinationID
           , @DestinationAirportID
           , @TravelDistance
           , @FlightCost
           , @TravelDuration
           , @FlightTypeID);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spUpdateFlight
GO
CREATE PROCEDURE [Flight].[spUpdateFlight](
    @FlightID int
, @DestinationID int
, @DestinationAirportID int
, @TravelDistance int
, @FlightCost int
, @TravelDuration time(7)
, @FlightTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Flight].[Flight] WITH (UPDLOCK, SERIALIZABLE)
    SET [DestinationID]        = @DestinationID
      , [DestinationAirportID] = @DestinationAirportID
      , [TravelDistance]       = @TravelDistance
      , [FlightCost]           = @FlightCost
      , [TravelDuration]       = @TravelDuration
      , [FlightTypeID]         = @FlightTypeID
    WHERE [FlightID] = @FlightID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchFlightByID
GO
CREATE PROCEDURE [Flight].[spSearchFlightByID](
    @FlightID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT *
    FROM [Flight].[Flight] AS [F]
    WHERE [F].[FlightID] = @FlightID
    COMMIT TRANSACTION;
END;
GO

-- Probar desde aqui
DROP PROCEDURE IF EXISTS [Flight].[spSearchFlightTypeByID];
GO
CREATE PROCEDURE [Flight].[spSearchFlightTypeByID](
    @FlightTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [FlightTypeID]   = [FT].[FlightTypeID]
         , [FlightTypeName] = [FT].[FlightTypeName]
         , [Description]    = [FT].[Description]
    FROM [Flight].[FlightType] AS [FT]
    WHERE [FT].[FlightTypeID] = @FlightTypeID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spGetFlightType];
GO
CREATE PROCEDURE [Flight].[spGetFlightType]
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [FlightTypeID]   = [FT].[FlightTypeID]
         , [FlightTypeName] = [FT].[FlightTypeName]
         , [Description]    = [FT].[Description]
    FROM [Flight].[FlightType] AS [FT]
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spFlightUpdate];
GO
CREATE PROCEDURE [Flight].[spFlightUpdate](
    @FlightID int
, @DestinationID int
, @DestinationAirportID int
, @TravelDistance int
, @FlightCost int
, @TravelDuration time(7)
, @FlightTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Flight].[Flight] WITH (UPDLOCK, SERIALIZABLE)
    SET [DestinationID]        = @DestinationID
      , [DestinationAirportID] = @DestinationAirportID
      , [TravelDistance]       = @TravelDistance
      , [FlightCost]           = @FlightCost
      , [TravelDuration]       = @TravelDuration
      , [FlightTypeID]         = @FlightTypeID
    WHERE [FlightID] = @FlightID;
    COMMIT TRANSACTION;
END;
GO


DROP PROCEDURE IF EXISTS [Flight].[spAddFlightType];
GO
CREATE PROCEDURE [Flight].[spAddFlightType](
    @FlightTypeName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Flight].[FlightType] ( [FlightTypeName]
                                      , [Description])
    VALUES ( @FlightTypeName
           , @Description);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Airport].[spAddModel];
GO
CREATE PROCEDURE [Airport].[spAddModel](
    @ModelName varchar(100)
, @Description varchar(250)
, @BrandID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Airport].[Model] ( [ModelName]
                                  , [Description]
                                  , [BrandID])
    VALUES ( @ModelName
           , @Description
           , @BrandID);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Airport].[spUpdateModel];
GO
CREATE PROCEDURE [Airport].[spUpdateModel](
    @ModelID int
, @ModelName varchar(100)
, @Description varchar(250)
, @BrandID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Airport].[Model] WITH (UPDLOCK, SERIALIZABLE)
    SET [ModelName]   = @ModelName
      , [Description] = @Description
      , [BrandID]     = @BrandID
    WHERE [ModelID] = @ModelID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Airport].[spSearchBrandByID];
GO
CREATE PROCEDURE [Airport].[spSearchBrandByID](
    @ModelID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [ModelID]     = [M].[ModelID]
         , [ModelName]   = [M].[ModelName]
         , [Description] = [M].[Description]
         , [BrandID]     = [M].[BrandID]
    FROM [Airport].[Model] AS [M]
    WHERE [M].[ModelID] = @ModelID
    COMMIT TRANSACTION;

END;
GO

DROP PROCEDURE IF EXISTS [Airport].[spGetBrand];
GO
CREATE PROCEDURE [Airport].[spGetBrand]
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [ModelID]     = [M].[ModelID]
         , [ModelName]   = [M].[ModelName]
         , [Description] = [M].[Description]
         , [BrandID]     = [M].[BrandID]
    FROM [Airport].[Model] AS [M]
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Airport].[spUpdateStatusPlane];
GO
CREATE PROCEDURE [Airport].[spUpdateStatusPlane](
    @StatusPlaneID int
, @StatusPlaneName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Airport].[StatusPlane] WITH (UPDLOCK, SERIALIZABLE)
    SET [StatusPlaneName] = @StatusPlaneName
      , [Description]     = @Description
    WHERE [StatusPlaneID] = @StatusPlaneID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Airport].[spAddStatusPlane];
GO
CREATE PROCEDURE [Airport].[spAddStatusPlane](
    @StatusPlaneName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Airport].[StatusPlane] ( [StatusPlaneName]
                                        , [Description])
    VALUES ( @StatusPlaneName
           , @Description);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Airport].[spSearchStatusPlaneByID];
GO
CREATE PROCEDURE [Airport].[spSearchStatusPlaneByID](
    @StatusPlaneID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [StatusPlaneID]   = [SP].[StatusPlaneID]
         , [StatusPlaneName] = [SP].[StatusPlaneName]
         , [Description]     = [SP].[Description]
    FROM [Airport].[StatusPlane] AS [SP]
    WHERE [SP].[StatusPlaneID] = @StatusPlaneID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Airport].[spGetStatusPlane];
GO
CREATE PROCEDURE [Airport].[spGetStatusPlane]
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [StatusPlaneID]   = [SP].[StatusPlaneID]
         , [StatusPlaneName] = [SP].[StatusPlaneName]
         , [Description]     = [SP].[Description]
    FROM [Airport].[StatusPlane] AS [SP]
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spUpdateLuggageType];
GO
CREATE PROCEDURE [Flight].[spUpdateLuggageType](
    @LuggageTypeID int
, @LuggageTypeName varchar(100)
, @Description varchar(200)
, @Cost money
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Flight].[LuggageType] WITH (UPDLOCK, SERIALIZABLE)
    SET [LuggageTypeName] = @LuggageTypeName
      , [Description]     = @Description
      , [Cost] = @Cost
    WHERE [LuggageTypeID] = @LuggageTypeID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spAddLuggageType];
GO
CREATE PROCEDURE [Flight].[spAddLuggageType](
    @LuggageTypeName varchar(100)
, @Description varchar(200)
, @Cost money
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Flight].[LuggageType] ( [LuggageTypeName]
                                       , [Description], [Cost])
    VALUES ( @LuggageTypeName
           , @Description, @Cost);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchLuggageTypeByID];
GO
CREATE PROCEDURE [Flight].[spSearchLuggageTypeByID](
    @LuggageTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [LuggageTypeID]   = [LT].[LuggageTypeID]
         , [LuggageTypeName] = [LT].[LuggageTypeName]
         , [Description]     = [LT].[Description]
         , [Cost]            = [LT].[Cost]
    FROM [Flight].[LuggageType] AS [LT]
    WHERE [LT].[LuggageTypeID] = @LuggageTypeID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spGetLuggageType];
GO
CREATE PROCEDURE [Flight].[spGetLuggageType]
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [LuggageTypeID]   = [LT].[LuggageTypeID]
         , [LuggageTypeName] = [LT].[LuggageTypeName]
         , [Description]     = [LT].[Description]
         , [Cost]            = [LT].[Cost]
    FROM [Flight].[LuggageType] AS [LT]
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spUpdateBloodType];
GO
CREATE PROCEDURE [Person].[spUpdateBloodType](
    @BloodTypeID int
, @BloodTypeName varchar(4)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Person].[BloodType] WITH (UPDLOCK, SERIALIZABLE)
    SET [BloodTypeName] = @BloodTypeName
      , [Description]   = @Description
    WHERE [BloodTypeID] = @BloodTypeID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spAddBloodType];
GO
CREATE PROCEDURE [Person].[spAddBloodType](
    @BloodTypeName varchar(4)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Person].[BloodType] ( [BloodTypeName]
                                     , [Description])
    VALUES ( @BloodTypeName
           , @Description);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spSearchBloodTypeByID];
GO
CREATE PROCEDURE [Person].[spSearchBloodTypeByID](
    @BloodTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [BloodTypeID]   = [BT].[BloodTypeID]
         , [BloodTypeName] = [BT].[BloodTypeName]
         , [Description]   = [BT].[Description]
    FROM [Person].[BloodType] AS [BT]
    WHERE [BT].[BloodTypeID] = @BloodTypeID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spGetBloodType];
GO
CREATE PROCEDURE [Person].[spGetBloodType]
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [BloodTypeID]   = [BT].[BloodTypeID]
         , [BloodTypeName] = [BT].[BloodTypeName]
         , [Description]   = [BT].[Description]
    FROM [Person].[BloodType] AS [BT]
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spAddStatusEmployee];
GO
CREATE PROCEDURE [Person].[spAddStatusEmployee](
    @StatusEmployeeName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Person].[StatusEmployee] ( [StatusEmployeeName]
                                          , [Description])
    VALUES ( @StatusEmployeeName
           , @Description);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spUpdateStatusEmployee];
GO
CREATE PROCEDURE [Person].[spUpdateStatusEmployee](
    @StatusEmployeeID int
, @StatusEmployeeName varchar(100)
, @Description varchar(200)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Person].[StatusEmployee] WITH (UPDLOCK, SERIALIZABLE)
    SET [StatusEmployeeName] = @StatusEmployeeName
      , [Description]        = @Description
    WHERE [StatusEmployeeID] = @StatusEmployeeID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spSearchStatusEmployeeByID];
GO
CREATE PROCEDURE [Person].[spSearchStatusEmployeeByID](
    @StatusEmployeeID int
)
AS
BEGIN

    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [StatusEmployeeID]   = [SE].[StatusEmployeeID]
         , [StatusEmployeeName] = [SE].[StatusEmployeeName]
         , [Description]        = [SE].[Description]
    FROM [Person].[StatusEmployee] AS [SE]
    WHERE [SE].[StatusEmployeeID] = @StatusEmployeeID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spGetStatusEmployee];
GO
CREATE PROCEDURE [Person].[spGetStatusEmployee]
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [StatusEmployeeID]   = [SE].[StatusEmployeeID]
         , [StatusEmployeeName] = [SE].[StatusEmployeeName]
         , [Description]        = [SE].[Description]
    FROM [Person].[StatusEmployee] AS [SE]
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spAddFlightBenefit_FlightTypeCreate];
GO
CREATE PROCEDURE [Flight].[spAddFlightBenefit_FlightTypeCreate](
    @FlightBenefitID int
, @FlightTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Flight].[FlightBenefit_FlightType] ( [FlightBenefitID]
                                                    , [FlightTypeID])
    VALUES ( @FlightBenefitID
           , @FlightTypeID);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spUpdateFlightBenefit_FlightType];
GO
CREATE PROCEDURE [Flight].[spUpdateFlightBenefit_FlightType](
    @FlightBenefitID int
, @FlightTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Flight].[FlightBenefit_FlightType] WITH (UPDLOCK, SERIALIZABLE)
    SET [FlightBenefitID] = @FlightBenefitID
      , [FlightTypeID]    = @FlightTypeID
    WHERE [FlightBenefitID] = @FlightBenefitID
      AND [FlightTypeID] = @FlightTypeID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchFlightBenefit_FlightTypeReadByFlightBenefitIDAndFlightTypeID];
GO
CREATE PROCEDURE [Flight].[spSearchFlightBenefit_FlightTypeReadByFlightBenefitIDAndFlightTypeID](
    @FlightBenefitID int
, @FlightTypeID int
)
AS
BEGIN

    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [FlightBenefitID] = [FBFT].[FlightBenefitID]
         , [FlightTypeID]    = [FBFT].[FlightTypeID]
    FROM [Flight].[FlightBenefit_FlightType] AS [FBFT]
    WHERE [FBFT].[FlightBenefitID] = @FlightBenefitID
      AND [FBFT].[FlightTypeID] = @FlightTypeID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchFlightBenefit_FlightTypeByFlightBenefitID];
GO
CREATE PROCEDURE [Flight].[spSearchFlightBenefit_FlightTypeByFlightBenefitID](
    @FlightBenefitID int
)
AS
BEGIN

    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [FlightBenefitID] = [FBFT].[FlightBenefitID]
         , [FlightTypeID]    = [FBFT].[FlightTypeID]
    FROM [Flight].[FlightBenefit_FlightType] AS [FBFT]
    WHERE [FBFT].[FlightBenefitID] = @FlightBenefitID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchFlightBenefit_FlightTypeByFlightTypeID];
GO
CREATE PROCEDURE [Flight].[spSearchFlightBenefit_FlightTypeByFlightTypeID](
    @FlightTypeID int
)
AS
BEGIN

    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [FlightBenefitID] = [FBFT].[FlightBenefitID]
         , [FlightTypeID]    = [FBFT].[FlightTypeID]
    FROM [Flight].[FlightBenefit_FlightType] AS [FBFT]
    WHERE [FBFT].[FlightTypeID] = @FlightTypeID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spGetFlightBenefit_FlightType];
GO
CREATE PROCEDURE [Flight].[spGetFlightBenefit_FlightType]
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [FlightBenefitID] = [FBFT].[FlightBenefitID]
         , [FlightTypeID]    = [FBFT].[FlightTypeID]
    FROM [Flight].[FlightBenefit_FlightType] AS [FBFT]
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spAddEmployee_EmployeeRole];
GO
CREATE PROCEDURE [Person].[spAddEmployee_EmployeeRole](
    @EmployeeID int
, @EmployeeRoleID int
, @StartDate date
, @EndDate date
, @Description varchar(100)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Person].[Employee_EmployeeRole] ( [EmployeeID]
                                                 , [EmployeeRoleID]
                                                 , [StartDate]
                                                 , [EndDate]
                                                 , [Description])
    VALUES ( @EmployeeID
           , @EmployeeRoleID
           , @StartDate
           , @EndDate
           , @Description);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spUpdateEmployee_EmployeeRole];
GO
CREATE PROCEDURE [Person].[spUpdateEmployee_EmployeeRole](
    @EmployeeID int
, @EmployeeRoleID int
, @StartDate date
, @EndDate date
, @Description varchar(100)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Person].[Employee_EmployeeRole] WITH (UPDLOCK, SERIALIZABLE)
    SET [EmployeeID]     = @EmployeeID
      , [EmployeeRoleID] = @EmployeeRoleID
      , [StartDate]      = @StartDate
      , [EndDate]        = @EndDate
      , [Description]    = @Description
    WHERE EmployeeID = @EmployeeID
      AND EmployeeRoleID = @EmployeeRoleID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spSearchEmployee_EmployeeRoleReadByEmployeeIDAndEmployeeRoleID];
GO
CREATE PROCEDURE [Person].[spSearchEmployee_EmployeeRoleReadByEmployeeIDAndEmployeeRoleID](
    @EmployeeID int
, @EmployeeRoleID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [EmployeeID]     = [EER].[EmployeeID]
         , [EmployeeRoleID] = [EER].[EmployeeRoleID]
         , [StartDate]      = [EER].[StartDate]
         , [EndDate]        = [EER].[EndDate]
         , [Description]    = [EER].[Description]
    FROM [Person].[Employee_EmployeeRole] AS [EER]
    WHERE EmployeeID = @EmployeeID
      AND EmployeeRoleID = @EmployeeRoleID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spSearchEmployee_EmployeeRoleByEmployeeID];
GO
CREATE PROCEDURE [Person].[spSearchEmployee_EmployeeRoleByEmployeeID](
    @EmployeeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [EmployeeID]     = [EER].[EmployeeID]
         , [EmployeeRoleID] = [EER].[EmployeeRoleID]
         , [StartDate]      = [EER].[StartDate]
         , [EndDate]        = [EER].[EndDate]
         , [Description]    = [EER].[Description]
    FROM [Person].[Employee_EmployeeRole] AS [EER]
    WHERE EmployeeID = @EmployeeID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spSearchEmployee_EmployeeRoleByEmployeeRoleID];
GO
CREATE PROCEDURE [Person].[spSearchEmployee_EmployeeRoleByEmployeeRoleID](
    @EmployeeRoleID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [EmployeeID]     = [EER].[EmployeeID]
         , [EmployeeRoleID] = [EER].[EmployeeRoleID]
         , [StartDate]      = [EER].[StartDate]
         , [EndDate]        = [EER].[EndDate]
         , [Description]    = [EER].[Description]
    FROM [Person].[Employee_EmployeeRole] AS [EER]
    WHERE EmployeeRoleID = @EmployeeRoleID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spGetEmployee_EmployeeRole];
GO
CREATE PROCEDURE [Person].[spGetEmployee_EmployeeRole]
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [EmployeeID]     = [EER].[EmployeeID]
         , [EmployeeRoleID] = [EER].[EmployeeRoleID]
         , [StartDate]      = [EER].[StartDate]
         , [EndDate]        = [EER].[EndDate]
         , [Description]    = [EER].[Description]
    FROM [Person].[Employee_EmployeeRole] AS [EER];
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spAddEmployee_StatusEmployee];
GO
CREATE PROCEDURE [Person].[spAddEmployee_StatusEmployee](
    @EmployeeID int
, @StatusEmployeeID int
, @StartDate date
, @EndDate date
, @Description varchar(100)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    INSERT INTO [Person].[Employee_StatusEmployee] ( [EmployeeID]
                                                   , [StatusEmployeeID]
                                                   , [StartDate]
                                                   , [EndDate]
                                                   , [Description])
    VALUES ( @EmployeeID
           , @StatusEmployeeID
           , @StartDate
           , @EndDate
           , @Description);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spUpdateEmployee_StatusEmployee];
GO
CREATE PROCEDURE [Person].[spUpdateEmployee_StatusEmployee](
    @EmployeeID int
, @StatusEmployeeID int
, @StartDate date
, @EndDate date
, @Description varchar(100)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    UPDATE
        [Person].[Employee_StatusEmployee] WITH (UPDLOCK, SERIALIZABLE)
    SET [EmployeeID]       = @EmployeeID
      , [StatusEmployeeID] = @StatusEmployeeID
      , [StartDate]        = @StartDate
      , [EndDate]          = @EndDate
      , [Description]      = @Description
    WHERE EmployeeID = @EmployeeID
      AND StatusEmployeeID = @StatusEmployeeID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spSearchEmployee_StatusEmployeeByEmployeeIDAndStatusEmployeeID];
GO
CREATE PROCEDURE [Person].[spSearchEmployee_StatusEmployeeByEmployeeIDAndStatusEmployeeID](
    @EmployeeID int
, @StatusEmployeeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [EmployeeID]       = [ESE].[EmployeeID]
         , [StatusEmployeeID] = [ESE].[StatusEmployeeID]
         , [StartDate]        = [ESE].[StartDate]
         , [EndDate]          = [ESE].[EndDate]
         , [Description]      = [ESE].[Description]
    FROM [Person].[Employee_StatusEmployee] AS [ESE]
    WHERE EmployeeID = @EmployeeID
      AND StatusEmployeeID = @StatusEmployeeID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spSearchEmployee_StatusEmployeeByEmployeeID];
GO
CREATE PROCEDURE [Person].[spSearchEmployee_StatusEmployeeByEmployeeID](
    @EmployeeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [EmployeeID]       = [ESE].[EmployeeID]
         , [StatusEmployeeID] = [ESE].[StatusEmployeeID]
         , [StartDate]        = [ESE].[StartDate]
         , [EndDate]          = [ESE].[EndDate]
         , [Description]      = [ESE].[Description]
    FROM [Person].[Employee_StatusEmployee] AS [ESE]
    WHERE EmployeeID = @EmployeeID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spSearchEmployee_StatusEmployeeByStatusEmployeeID];
GO
CREATE PROCEDURE [Person].[spSearchEmployee_StatusEmployeeByStatusEmployeeID](
    @StatusEmployeeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [EmployeeID]       = [ESE].[EmployeeID]
         , [StatusEmployeeID] = [ESE].[StatusEmployeeID]
         , [StartDate]        = [ESE].[StartDate]
         , [EndDate]          = [ESE].[EndDate]
         , [Description]      = [ESE].[Description]
    FROM [Person].[Employee_StatusEmployee] AS [ESE]
    WHERE StatusEmployeeID = @StatusEmployeeID;
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Person].[spGetEmployee_StatusEmployee];
GO
CREATE PROCEDURE [Person].[spGetEmployee_StatusEmployee]
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [EmployeeID]       = [ESE].[EmployeeID]
         , [StatusEmployeeID] = [ESE].[StatusEmployeeID]
         , [StartDate]        = [ESE].[StartDate]
         , [EndDate]          = [ESE].[EndDate]
         , [Description]      = [ESE].[Description]
    FROM [Person].[Employee_StatusEmployee] AS [ESE];
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spAddLuggage];
GO
CREATE PROCEDURE [Flight].[spAddLuggage](
    @PersonID int
, @FlightScheduleID int
, @Weight int
, @LuggageTypeID int
, @LuggageStatusID int
, @TicketTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    DECLARE @Cost money;

    DECLARE @FreeWeight int = Flight.ufnCalculateTheAmountOFreeWeightRemaining(@PersonID, @FlightScheduleID, @TicketTypeID);
    SET @Cost = Flight.ufnCalculateCostOfLuggage(@Weight, @LuggageTypeID, @FreeWeight)

    INSERT INTO [Flight].[Luggage] ( [PersonID]
                                   , [FlightScheduleID]
                                   , [Weight]
                                   , [Cost]
                                   , [LuggageTypeID]
                                   , [LuggageStatusID])
    VALUES ( @PersonID
           , @FlightScheduleID
           , @Weight
           , @Cost
           , @LuggageTypeID
           , @LuggageStatusID);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spUpdateLuggage];
GO
CREATE PROCEDURE [Flight].[spUpdateLuggage](
    @LuggageID int
, @PersonID int
, @FlightScheduleID int
, @Weight int
, @Cost money
, @LuggageTypeID int
, @LuggageStatusID int
, @TicketTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    DECLARE @FreeWeight int = Flight.ufnCalculateTheAmountOFreeWeightRemaining(@PersonID, @FlightScheduleID, @TicketTypeID);
    SET @Cost = Flight.ufnCalculateCostOfLuggage(@Weight, @LuggageTypeID, @FreeWeight)

    UPDATE
        [Flight].[Luggage] WITH (UPDLOCK, SERIALIZABLE)
    SET [PersonID]         = @PersonID
      , [FlightScheduleID] = @FlightScheduleID
      , [Weight]           = @Weight
      , [Cost]             = @Cost
      , [LuggageTypeID]    = @LuggageTypeID
      , [LuggageStatusID]  = @LuggageStatusID
    WHERE [LuggageID] = @LuggageID;
    COMMIT TRANSACTION;

END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spGetLuggage];
GO
CREATE PROCEDURE [Flight].[spGetLuggage]
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [LuggageID]        = [L].[LuggageID]
         , [PersonID]         = [L].[PersonID]
         , [FlightScheduleID] = [L].[FlightScheduleID]
         , [Weight]           = [L].[Weight]
         , [Cost]             = [L].[Cost]
         , [LuggageTypeID]    = [L].[LuggageTypeID]
         , [LuggageStatusID]  = [L].[LuggageStatusID]
    FROM [Flight].[Luggage] AS [L]
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchLuggageByLuggageStatusID];
GO
CREATE PROCEDURE [Flight].[spSearchLuggageByLuggageStatusID](
    @LuggageStatusID int
)
AS
BEGIN

    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [LuggageID]        = [L].[LuggageID]
         , [PersonID]         = [L].[PersonID]
         , [FlightScheduleID] = [L].[FlightScheduleID]
         , [Weight]           = [L].[Weight]
         , [Cost]             = [L].[Cost]
         , [LuggageTypeID]    = [L].[LuggageTypeID]
         , [LuggageStatusID]  = [L].[LuggageStatusID]
    FROM [Flight].[Luggage] AS [L]
    WHERE [L].[LuggageStatusID] = @LuggageStatusID
    COMMIT TRANSACTION;

END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchLuggageByLuggageTypeID];
GO
CREATE PROCEDURE [Flight].[spSearchLuggageByLuggageTypeID](
    @LuggageTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [LuggageID]        = [L].[LuggageID]
         , [PersonID]         = [L].[PersonID]
         , [FlightScheduleID] = [L].[FlightScheduleID]
         , [Weight]           = [L].[Weight]
         , [Cost]             = [L].[Cost]
         , [LuggageTypeID]    = [L].[LuggageTypeID]
         , [LuggageStatusID]  = [L].[LuggageStatusID]
    FROM [Flight].[Luggage] AS [L]
    WHERE [L].[LuggageTypeID] = @LuggageTypeID
    COMMIT TRANSACTION;

END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchLuggageByLuggageID];
GO
CREATE PROCEDURE [Flight].[spSearchLuggageByLuggageID](
    @LuggageID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [LuggageID]        = [L].[LuggageID]
         , [PersonID]         = [L].[PersonID]
         , [FlightScheduleID] = [L].[FlightScheduleID]
         , [Weight]           = [L].[Weight]
         , [Cost]             = [L].[Cost]
         , [LuggageTypeID]    = [L].[LuggageTypeID]
         , [LuggageStatusID]  = [L].[LuggageStatusID]
    FROM [Flight].[Luggage] AS [L]
    WHERE [L].[LuggageID] = @LuggageID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchLuggageByPersonID];
GO
CREATE PROCEDURE [Flight].[spSearchLuggageByPersonID](
    @PersonID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [LuggageID]        = [L].[LuggageID]
         , [PersonID]         = [L].[PersonID]
         , [FlightScheduleID] = [L].[FlightScheduleID]
         , [Weight]           = [L].[Weight]
         , [Cost]             = [L].[Cost]
         , [LuggageTypeID]    = [L].[LuggageTypeID]
         , [LuggageStatusID]  = [L].[LuggageStatusID]
    FROM [Flight].[Luggage] AS [L]
    WHERE [L].[PersonID] = @PersonID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchLuggageByFlightScheduleID];
GO
CREATE PROCEDURE [Flight].[spSearchLuggageByFlightScheduleID](
    @FlightScheduleID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [LuggageID]        = [L].[LuggageID]
         , [PersonID]         = [L].[PersonID]
         , [FlightScheduleID] = [L].[FlightScheduleID]
         , [Weight]           = [L].[Weight]
         , [Cost]             = [L].[Cost]
         , [LuggageTypeID]    = [L].[LuggageTypeID]
         , [LuggageStatusID]  = [L].[LuggageStatusID]
    FROM [Flight].[Luggage] AS [L]
    WHERE [L].[FlightScheduleID] = @FlightScheduleID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spAddTicket];
GO
CREATE PROCEDURE [Flight].[spAddTicket](
    @FlightID int
, @PersonID int
, @TicketTypeID int
, @FlightScheduleID int
, @SeatPlane varchar(7)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    DECLARE @Cost money = Flight.[ufnCalculateFinalCostOfTicket](@TicketTypeID, @FlightID, @PersonID,
                                                                 @FlightScheduleID);

    IF Flight.[ufnCalculateNumberOfRemainingAvailableSeats](@FlightScheduleID) = 0
    BEGIN
        RAISERROR('No seats available', 16, 1)
    END

    IF Flight.ufnValidateSeatIfAvailable(@FlightScheduleID, @SeatPlane) = 1
    BEGIN
        RAISERROR('That seat is taken', 16, 1)
    END

    INSERT INTO [Flight].[Ticket] ( [FlightID]
                                  , [PersonID]
                                  , [TicketTypeID]
                                  , [Cost]
                                  , [FlightScheduleID]
                                  , [SeatPlane])
    VALUES ( @FlightID
           , @PersonID
           , @TicketTypeID
           , @Cost
           , @FlightScheduleID
           , @SeatPlane);
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spUpdateTicket];
GO
CREATE PROCEDURE [Flight].[spUpdateTicket](
    @TicketID int
, @FlightID int
, @PersonID int
, @TicketTypeID int
, @Cost money
, @FlightScheduleID int
, @SeatPlane varchar(7)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SET @Cost = Flight.[ufnCalculateFinalCostOfTicket](@TicketTypeID, @FlightID, @PersonID, @FlightScheduleID);

    IF Flight.ufnValidateSeatIfAvailable(@FlightScheduleID, @SeatPlane) = 1
    BEGIN
        RAISERROR('That seat is taken', 16, 1)
    END

    UPDATE
        [Flight].[Ticket] WITH (UPDLOCK, SERIALIZABLE)
    SET [FlightID]         = @FlightID
      , [PersonID]         = @PersonID
      , [TicketTypeID]     = @TicketTypeID
      , [Cost]             = @Cost
      , [FlightScheduleID] = @FlightScheduleID
      , [SeatPlane]        = @SeatPlane
    WHERE [TicketID] = @TicketID;
    COMMIT TRANSACTION;

END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchTicketByFlightID];
GO
CREATE PROCEDURE [Flight].[spSearchTicketByFlightID](
    @FlightID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [TicketID]         = [T].[TicketID]
         , [FlightID]         = [T].[FlightID]
         , [PersonID]         = [T].[PersonID]
         , [TicketTypeID]     = [T].[TicketTypeID]
         , [Cost]             = [T].[Cost]
         , [FlightScheduleID] = [T].[FlightScheduleID]
         , [SeatPlane]        = [T].[SeatPlane]
    FROM [Flight].[Ticket] AS [T]
    WHERE [T].[FlightID] = @FlightID
    COMMIT TRANSACTION;
END;
GO


DROP PROCEDURE IF EXISTS [Flight].[spSearchTicketByPersonID];
GO
CREATE PROCEDURE [Flight].[spSearchTicketByPersonID](
    @PersonID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [TicketID]         = [T].[TicketID]
         , [FlightID]         = [T].[FlightID]
         , [PersonID]         = [T].[PersonID]
         , [TicketTypeID]     = [T].[TicketTypeID]
         , [Cost]             = [T].[Cost]
         , [FlightScheduleID] = [T].[FlightScheduleID]
         , [SeatPlane]        = [T].[SeatPlane]
    FROM [Flight].[Ticket] AS [T]
    WHERE [T].[PersonID] = @PersonID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchTicketByTicketTypeID];
GO
CREATE PROCEDURE [Flight].[spSearchTicketByTicketTypeID](
    @TicketTypeID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [TicketID]         = [T].[TicketID]
         , [FlightID]         = [T].[FlightID]
         , [PersonID]         = [T].[PersonID]
         , [TicketTypeID]     = [T].[TicketTypeID]
         , [Cost]             = [T].[Cost]
         , [FlightScheduleID] = [T].[FlightScheduleID]
         , [SeatPlane]        = [T].[SeatPlane]
    FROM [Flight].[Ticket] AS [T]
    WHERE [T].[TicketTypeID] = @TicketTypeID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchTicketByFlightScheduleID];
GO
CREATE PROCEDURE [Flight].[spSearchTicketByFlightScheduleID](
    @FlightScheduleID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [TicketID]         = [T].[TicketID]
         , [FlightID]         = [T].[FlightID]
         , [PersonID]         = [T].[PersonID]
         , [TicketTypeID]     = [T].[TicketTypeID]
         , [Cost]             = [T].[Cost]
         , [FlightScheduleID] = [T].[FlightScheduleID]
         , [SeatPlane]        = [T].[SeatPlane]
    FROM [Flight].[Ticket] AS [T]
    WHERE [T].[FlightScheduleID] = @FlightScheduleID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spSearchTicketByTicketID];
GO
CREATE PROCEDURE [Flight].[spSearchTicketByTicketID](
    @TicketID int
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [TicketID]         = [T].[TicketID]
         , [FlightID]         = [T].[FlightID]
         , [PersonID]         = [T].[PersonID]
         , [TicketTypeID]     = [T].[TicketTypeID]
         , [Cost]             = [T].[Cost]
         , [FlightScheduleID] = [T].[FlightScheduleID]
         , [SeatPlane]        = [T].[SeatPlane]
    FROM [Flight].[Ticket] AS [T]
    WHERE [T].[TicketID] = @TicketID
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spGetTicket];
GO
CREATE PROCEDURE [Flight].[spGetTicket]
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [TicketID]         = [T].[TicketID]
         , [FlightID]         = [T].[FlightID]
         , [PersonID]         = [T].[PersonID]
         , [TicketTypeID]     = [T].[TicketTypeID]
         , [Cost]             = [T].[Cost]
         , [FlightScheduleID] = [T].[FlightScheduleID]
         , [SeatPlane]        = [T].[SeatPlane]
    FROM [Flight].[Ticket] AS [T]
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS [Flight].[spGetStatusLuggage];
GO
CREATE PROCEDURE [Flight].[spGetStatusLuggage]
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SET ANSI_NULLS ON;
        SET QUOTED_IDENTIFIER OFF;
        BEGIN TRANSACTION;
        SELECT
             [StatusLuggageID] = [SL].[StatusLuggageID]
            ,[StatusLuggageName] = [SL].[StatusLuggageName]
            ,[Description] = [SL].[Description]
        FROM
            [Flight].[StatusLuggage] AS [SL];
        COMMIT TRANSACTION;
    END;
go

DROP PROCEDURE IF EXISTS [Flight].[spUpdateLuggageType];
GO
CREATE PROCEDURE [Flight].[spUpdateLuggageType] (
     @LuggageTypeID int
    ,@LuggageTypeName varchar(100)
    ,@Description varchar(200)
)
AS
    BEGIN
        SET NOCOUNT, XACT_ABORT ON;
        SET ANSI_NULLS ON;
        SET QUOTED_IDENTIFIER OFF;
        BEGIN TRANSACTION;
        UPDATE
            [Flight].[LuggageType] WITH (UPDLOCK, SERIALIZABLE)
        SET
             [LuggageTypeName] = @LuggageTypeName
            ,[Description] = @Description
        WHERE
            [LuggageTypeID] = @LuggageTypeID;

        COMMIT TRANSACTION;
    END;
go


DROP PROCEDURE IF EXISTS Person.spSearchPersonByFirstName;
GO
CREATE PROCEDURE Person.spSearchPersonByFirstName(
    @FirstName varchar(100)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT  [PersonID] = [P].[PersonID]
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
    FROM Person.Person P
    WHERE FirstName LIKE '%'+@FirstName+'%';
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchDestinationByDestinationName;
GO
CREATE PROCEDURE Flight.spSearchDestinationByDestinationName(
    @DestinationName varchar(100)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [DestinationID] = [D].[DestinationID]
            ,[CountryID] = [D].[CountryID]
            ,[DestinationName] = [D].[DestinationName]
            ,[Acronym] = [D].[Acronym]
            ,[Latitude] = [D].[Latitude]
            ,[Longitude] = [D].[Longitude]
    FROM [Flight].[Destination] AS [D]
    WHERE DestinationName like '%'+@DestinationName+'%';
    COMMIT TRANSACTION;
END;
GO

DROP PROCEDURE IF EXISTS Flight.spSearchCountryByCountryName;
GO
CREATE PROCEDURE Flight.spSearchCountryByCountryName(
    @CountryName varchar(100)
)
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    BEGIN TRANSACTION;
    SELECT [CountryID] = [C].[CountryID]
            ,[ISO2] = [C].[ISO2]
            ,[ISO3] = [C].[ISO3]
            ,[CurrencyName] = [C].[CurrencyName]
            ,[Latitude] = [C].[Latitude]
            ,[Longitude] = [C].[Longitude]
            ,[CountryName] = [C].[CountryName]
    FROM [Flight].[Country] AS [C]
    WHERE CountryName like '%'+@CountryName+'%';
    COMMIT TRANSACTION;
END;
GO


/*
Full text search
*/

--
--
-- DROP PROCEDURE IF EXISTS Person.spSearchPersonByFirstName;
-- GO
-- CREATE PROCEDURE Person.spSearchPersonByFirstName(
--     @FirstName varchar(100)
-- )
-- AS
-- BEGIN
--     SET NOCOUNT, XACT_ABORT ON;
--     SET ANSI_NULLS ON;
--     SET QUOTED_IDENTIFIER OFF;
--     BEGIN TRANSACTION;
--     SELECT  [PersonID] = [P].[PersonID]
--             ,[FirstName] = [P].[FirstName]
--             ,[LastName] = [P].[LastName]
--             ,[AdmissionDate] = [P].[AdmissionDate]
--             ,[Nationality] = [P].[Nationality]
--             ,[Gender] = [P].[Gender]
--             ,[Document] = [P].[Document]
--             ,[DocumentTypeID] = [P].[DocumentTypeID]
--             ,[PhoneNumber] = [P].[PhoneNumber]
--             ,[DOB] = [P].[DOB]
--             ,[BloodType] = [P].[BloodType]
--             ,[Direction] = [P].[Direction]
--             ,[Email] = [P].[Email]
--     FROM Person.Person P
--     WHERE CONTAINS(FirstName, @FirstName);
--     COMMIT TRANSACTION;
-- END;
-- GO

-- DROP PROCEDURE IF EXISTS Flight.spSearchDestinationByDestinationName;
-- GO
-- CREATE PROCEDURE Flight.spSearchDestinationByDestinationName(
--     @DestinationName varchar(100)
-- )
-- AS
-- BEGIN
--     SET NOCOUNT, XACT_ABORT ON;
--     SET ANSI_NULLS ON;
--     SET QUOTED_IDENTIFIER OFF;
--     BEGIN TRANSACTION;
--     SELECT [DestinationID] = [D].[DestinationID]
--             ,[CountryID] = [D].[CountryID]
--             ,[DestinationName] = [D].[DestinationName]
--             ,[Acronym] = [D].[Acronym]
--             ,[Latitude] = [D].[Latitude]
--             ,[Longitude] = [D].[Longitude]
--     FROM [Flight].[Destination] AS [D]
--     WHERE CONTAINS(DestinationName, @DestinationName);
--     COMMIT TRANSACTION;
-- END;
-- GO
--
-- DROP PROCEDURE IF EXISTS Flight.spSearchCountryByCountryName;
-- GO
-- CREATE PROCEDURE Flight.spSearchCountryByCountryName(
--     @CountryName varchar(100)
-- )
-- AS
-- BEGIN
--     SET NOCOUNT, XACT_ABORT ON;
--     SET ANSI_NULLS ON;
--     SET QUOTED_IDENTIFIER OFF;
--     BEGIN TRANSACTION;
--     SELECT [CountryID] = [C].[CountryID]
--             ,[ISO2] = [C].[ISO2]
--             ,[ISO3] = [C].[ISO3]
--             ,[CurrencyName] = [C].[CurrencyName]
--             ,[Latitude] = [C].[Latitude]
--             ,[Longitude] = [C].[Longitude]
--             ,[CountryName] = [C].[CountryName]
--     FROM [Flight].[Country] AS [C]
--     WHERE CONTAINS(CountryName, @CountryName);
--     COMMIT TRANSACTION;
-- END;
-- GO