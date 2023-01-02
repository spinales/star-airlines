DROP VIEW IF EXISTS Person.vEmployee;
GO
CREATE VIEW Person.vEmployee AS
    SELECT EER.EmployeeID, P.FirstName + ' ' + P.LastName AS Name, ER.EmployeeRoleName AS EmployeeRole, P.AdmissionDate, C.CountryName AS Nationality, P.Gender,
           P.Document, DT.DocumentTypeName AS DocumentType,P.PhoneNumber, P.DOB AS DateOfBirth, BT.BloodTypeName AS BloodType,P.Direction, P.Email
    FROM Person.Employee_EmployeeRole EER
    INNER JOIN Person.Person P on P.PersonID = EER.EmployeeID
    INNER JOIN Flight.Country C on C.CountryID = P.Nationality
    INNER JOIN Person.DocumentType DT on DT.DocumentTypeID = P.DocumentTypeID
    INNER JOIN Person.BloodType BT on P.BloodType = BT.BloodTypeID
    INNER JOIN Person.EmployeeRole ER on ER.EmployeeRoleID = EER.EmployeeRoleID;
GO

--vAirport
DROP VIEW IF EXISTS Airport.vAirport;
GO
CREATE VIEW Airport.vAirport AS
    SELECT A.AirportID, A.AirportName AS Name, A.Direction, D.DestinationName AS Destination, D.Acronym, C.CountryName AS Country,
        AT.AirportTypeName AS AiportType, AT.Description
    FROM Airport.Airport A
    INNER JOIN Flight.Destination D ON A.DestinationID =  D.DestinationID
    INNER JOIN Flight.Country C ON  D.CountryID = C.CountryID
    INNER JOIN Airport.AirportType AT ON A.AirportTypeID = AT.AirportTypeID
GO

--vDestinos
DROP VIEW IF EXISTS Flight.vDestination;
GO
CREATE VIEW Flight.vDestination AS
    SELECT D.DestinationName AS Destination, D.Acronym, D.Latitude, D.Longitude,
        C.CountryName AS Country, C.ISO2, C.ISO3, C.CurrencyName AS Currency
    FROM Flight.Destination D
    INNER JOIN Flight.Country C ON C.CountryID = D.CountryID;
GO

--vAvion
DROP VIEW IF EXISTS Airport.vPlane;
GO
CREATE VIEW Airport.vPlane AS
    SELECT P.PlaneID, M.ModelName AS Model, B.BrandName AS Brand, M.Description, SP.StatusPlaneName AS StatusPlane, P.AdmissionDate,
           P.RetirementDate, P.SeatingCapacityHigh, P.SeatingCapacityMedium, P.SeatingCapacityLow,
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
           F.FlightCost AS Cost, FT.FlightTypeName AS FlightType, FT.Description
    FROM Flight.Flight F
    INNER JOIN Flight.Destination D ON F.DestinationID = D.DestinationID
    INNER JOIN Flight.Country C ON C.CountryID = D.CountryID
    INNER JOIN Airport.Airport A ON F.DestinationAirportID = A.AirportID
    INNER JOIN Flight.FlightType FT ON F.FlightTypeID = FT.FlightTypeID
GO

--vTicket
DROP VIEW IF EXISTS Flight.vTicket;
GO
CREATE VIEW Flight.vTicket AS
    SELECT T.TicketID, P.FirstName + ' ' + P.LastName AS Name, P.Document, D.DestinationName AS Destination, C.CountryName AS Country, F.TravelDistance AS Distance,
           F.TravelDuration AS Duration, TT.TicketTypeName AS TicketType, T.Cost AS Cost, FS.DepartureDate, FS.ArrivalDate
    FROM Flight.Ticket T
    INNER JOIN Flight.Flight F ON T.FlightID = F.FlightID
    INNER JOIN Person.Person P ON T.PersonID = P.PersonID
    INNER JOIN Flight.Destination D ON D.DestinationID = F.DestinationID
    INNER JOIN Flight.Country C on C.CountryID = D.CountryID
    INNER JOIN Flight.TicketType TT ON T.TicketTypeID = TT.TicketTypeID
    INNER JOIN Flight.FlightSchedule FS ON T.FlightScheduleID = FS.FlightScheduleID
GO

--vPerson
DROP VIEW IF EXISTS Person.vPerson;
GO
CREATE VIEW Person.vPerson AS
    SELECT P.PersonID, P.FirstName + ' ' + P.LastName AS Name, P.AdmissionDate, C.CountryName AS Nationality, P.Gender,
           P.Document, DT.DocumentTypeName AS DocumentType,P.PhoneNumber, P.DOB AS DateOfBirth, BT.BloodTypeName AS BloodType, P.Direction, P.Email
    FROM Person.Person P
    INNER JOIN Flight.Country C on C.CountryID = P.Nationality
    INNER JOIN Person.DocumentType DT on DT.DocumentTypeID = P.DocumentTypeID
    INNER JOIN Person.BloodType BT on P.BloodType = BT.BloodTypeID
GO

DROP VIEW IF EXISTS Flight.vBenefits;
GO
CREATE VIEW Flight.vBenefits AS
    SELECT FT.FlightTypeName FlightType,FT.Description, FB.FlightBenefitName Benefit, FB.Cost
    FROM Flight.FlightBenefit_FlightType FFT
    INNER JOIN Flight.FlightType FT on FT.FlightTypeID = FFT.FlightTypeID
    INNER JOIN Flight.FlightBenefit FB on FB.FlightBenefitID = FFT.FlightBenefitID
GO

