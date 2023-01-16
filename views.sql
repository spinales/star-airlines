DROP VIEW IF EXISTS Person.vEmployee;
GO
CREATE VIEW Person.vEmployee AS
    SELECT EER.EmployeeID, P.FirstName + ' ' + P.LastName AS Name, ER.EmployeeRoleName AS EmployeeRole, P.AdmissionDate, C.CountryName AS Nationality, P.Gender,
           P.Document, DT.DocumentTypeName AS DocumentType,P.PhoneNumber, P.DOB AS DateOfBirth, BT.BloodTypeName AS BloodType,P.Direction, P.Email
    FROM Person.Employee_EmployeeRole EER
    INNER JOIN Person.Person P on P.PersonID = EER.EmployeeID
    INNER JOIN [Geo].[Country] C on C.CountryID = P.Nationality
    INNER JOIN Person.DocumentType DT on DT.DocumentTypeID = P.DocumentTypeID
    INNER JOIN Person.BloodType BT on P.BloodType = BT.BloodTypeID
    INNER JOIN Person.EmployeeRole ER on ER.EmployeeRoleID = EER.EmployeeRoleID;
GO

--vAirport
DROP VIEW IF EXISTS Airport.vAirport;
GO
CREATE VIEW Airport.vAirport AS
    SELECT A.AirportID, A.AirportName AS Name, A.Direction, D.DestinationName AS City, D.Acronym, C.CountryName AS Country, GC.ContinentName,
        AT.AirportTypeName AS AiportType, AT.Description
    FROM Airport.Airport A
    INNER JOIN [Geo].[Destination] D ON A.DestinationID =  D.DestinationID
    INNER JOIN [Geo].[Country] C ON  D.CountryID = C.CountryID
    INNER JOIN Airport.AirportType AT ON A.AirportTypeID = AT.AirportTypeID
    INNER JOIN Geo.Continent GC ON GC.ContinentID = C.ContinentID
GO

--vDestinos
DROP VIEW IF EXISTS Geo.vDestination;
GO
CREATE VIEW Geo.vDestination AS
    SELECT D.Acronym, D.DestinationName AS Destination, C.CountryName AS Country, D.Latitude, D.Longitude,
         C.ISO2, C.ISO3, C.CurrencyName AS Currency,GC.ContinentName
    FROM [Geo].[Destination] D
    INNER JOIN [Geo].[Country] C ON C.CountryID = D.CountryID
    INNER JOIN Geo.Continent GC ON GC.ContinentID = C.ContinentID;
GO

--vAvion
DROP VIEW IF EXISTS Airport.vPlane;
GO
CREATE VIEW Airport.vPlane AS
    SELECT P.PlaneID, M.ModelName AS Model, B.BrandName AS Brand, M.Description, SP.StatusPlaneName AS StatusPlane, P.AdmissionDate,
           P.RetirementDate,
           A.AirportName AS BelongingAirport
    FROM Airport.Plane P
    INNER JOIN Airport.Model M ON P.ModelID = M.ModelID
    INNER JOIN Airport.Brand B ON M.BrandID = B.BrandID
    INNER JOIN Airport.StatusPlane SP ON SP.StatusPlaneID = P.StatusPlaneID
    INNER JOIN Airport.Airport A ON A.AirportID = P.BelongingAirport;
GO

--vVuelos
DROP VIEW IF EXISTS Flight.vFlight;
GO
CREATE VIEW Flight.vFlight AS
    SELECT F.FlightID, D.DestinationName AS Destination, D.Acronym, D.Latitude, D.Longitude, C.CountryName AS Country, C.ISO2, C.ISO3,
           A.AirportName AS DestinationAirport, F.TravelDistance, F.TravelDuration,
           F.FlightCost AS Cost, FT.FlightTypeName AS FlightType, FT.Description, GC.ContinentName
    FROM Flight.Flight F
    INNER JOIN [Geo].[Destination] D ON F.DestinationID = D.DestinationID
    INNER JOIN [Geo].[Country] C ON C.CountryID = D.CountryID
    INNER JOIN Airport.Airport A ON F.DestinationAirportID = A.AirportID
    INNER JOIN Flight.FlightType FT ON F.FlightTypeID = FT.FlightTypeID
    INNER JOIN Geo.Continent GC ON GC.ContinentID = C.ContinentID
GO

--vTicket
DROP VIEW IF EXISTS Flight.vTicket;
GO
CREATE VIEW Flight.vTicket AS
    SELECT T.FlightScheduleID, T.TicketID, P.PersonID, P.FirstName + ' ' + P.LastName AS Name, P.Document, D.DestinationName AS Destination, C.CountryName AS Country, F.TravelDistance AS Distance,
           F.TravelDuration AS Duration, TT.TicketTypeName AS TicketType, T.Cost AS Cost, FS.DepartureDate, FS.ArrivalDate, GC.ContinentName
    FROM Flight.Ticket T
    INNER JOIN Flight.Flight F ON T.FlightID = F.FlightID
    INNER JOIN Person.Person P ON T.PersonID = P.PersonID
    INNER JOIN [Geo].[Destination] D ON D.DestinationID = F.DestinationID
    INNER JOIN [Geo].[Country] C on C.CountryID = D.CountryID
    INNER JOIN Flight.TicketType TT ON T.TicketTypeID = TT.TicketTypeID
    INNER JOIN Flight.FlightSchedule FS ON T.FlightScheduleID = FS.FlightScheduleID
    INNER JOIN Geo.Continent GC ON GC.ContinentID = C.ContinentID
GO

--vPerson
DROP VIEW IF EXISTS Person.vPerson;
GO
CREATE VIEW Person.vPerson AS
    SELECT P.PersonID, P.FirstName + ' ' + P.LastName AS Name, P.AdmissionDate, C.CountryName AS Nationality, P.Gender,
           P.Document, DT.DocumentTypeName AS DocumentType,P.PhoneNumber, P.DOB AS DateOfBirth, BT.BloodTypeName AS BloodType, P.Direction, P.Email,
           GC.ContinentName
    FROM Person.Person P
    INNER JOIN [Geo].[Country] C on C.CountryID = P.Nationality
    INNER JOIN Person.DocumentType DT on DT.DocumentTypeID = P.DocumentTypeID
    INNER JOIN Person.BloodType BT on P.BloodType = BT.BloodTypeID
    INNER JOIN Geo.Continent GC ON GC.ContinentID = C.ContinentID
GO

DROP VIEW IF EXISTS Flight.vBenefits;
GO
CREATE VIEW Flight.vBenefits AS
    SELECT FT.FlightTypeName FlightType,FT.Description, FB.FlightBenefitName Benefit, FB.Cost
    FROM Flight.FlightBenefit_FlightType FFT
    INNER JOIN Flight.FlightType FT on FT.FlightTypeID = FFT.FlightTypeID
    INNER JOIN Flight.FlightBenefit FB on FB.FlightBenefitID = FFT.FlightBenefitID
GO

DROP VIEW IF EXISTS Flight.vFlightSchedule;
GO
CREATE VIEW Flight.vFlightSchedule AS
    SELECT FS.FlightScheduleID, FS.DepartureDate, FS.ArrivalDate,
           PP.FirstName + ' ' + PP.LastName AS Pilot, PcP.FirstName + ' ' + PcP.LastName AS CoPilot,
           D.DestinationName AS City, C.CountryName AS Country, C.ISO2, C.ISO3, F.TravelDistance,
           F.FlightCost AS Cost, FT.FlightTypeName AS FlightType, GC.ContinentName
    FROM Flight.FlightSchedule FS
    INNER JOIN Person.Person PP on PP.PersonID = FS.Pilot
    INNER JOIN Person.Person PcP on PcP.PersonID = FS.CoPilot
    INNER JOIN Flight.Flight F ON FS.FlightID = F.FlightID
    INNER JOIN [Geo].[Destination] D ON F.DestinationID = D.DestinationID
    INNER JOIN [Geo].[Country] C ON C.CountryID = D.CountryID
    INNER JOIN Airport.Airport A ON F.DestinationAirportID = A.AirportID
    INNER JOIN Flight.FlightType FT ON F.FlightTypeID = FT.FlightTypeID
    INNER JOIN Geo.Continent GC ON GC.ContinentID = C.ContinentID
GO

DROP VIEW IF EXISTS Flight.vLuggage;
GO
CREATE VIEW Flight.vLuggage AS
    SELECT L.LuggageID, L.FlightScheduleID, L.Weight, L.Cost,
    LT.LuggageTypeName, SL.StatusLuggageName,
    P.PersonID, P.FirstName + ' ' + P.LastName as Person
    FROM Flight.Luggage L
    Inner Join Flight.LuggageType LT on LT.LuggageTypeID = L.LuggageTypeID
    INNER JOIN Flight.StatusLuggage SL on SL.StatusLuggageID = L.LuggageStatusID
    INNER JOIN Person.Person P ON P.PersonID = L.PersonID
GO

