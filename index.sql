/*
Full text search
    idx_  regular index
    unq_  UNIQUE
    ftx_  FULLTEXT
    gis_  SPATIAL
*/
-- StarAirlinesFullTextCatalog
CREATE FULLTEXT CATALOG StarAirlinesFTCat;
GO

DROP INDEX IF EXISTS UNQ_Person_FirstName ON Person.Person;
CREATE UNIQUE INDEX UNQ_Person_FirstName ON Person.Person(FirstName);
DROP INDEX IF EXISTS UNQ_Destination_DestinationName ON Flight.Destination;
CREATE UNIQUE INDEX UNQ_Destination_DestinationName ON Flight.Destination(DestinationName);
DROP INDEX IF EXISTS UNQ_Country_CountryName ON Flight.Country;
CREATE UNIQUE INDEX UNQ_Country_CountryName ON Flight.Country(CountryName);
DROP INDEX IF EXISTS UNQ_Airport_AirportName ON Airport.Airport;
CREATE UNIQUE INDEX UNQ_Airport_AirportName ON Airport.Airport(AirportName);
GO

-- DROP FULLTEXT INDEX ON Person.Person;
-- GO
CREATE FULLTEXT INDEX ON Person.Person
(
        FirstName
        Language 1033                 --1033 is the LCID for US English
)
KEY INDEX UNQ_Person_FirstName ON StarAirlinesFTCat
WITH CHANGE_TRACKING AUTO
GO

-- DROP FULLTEXT INDEX ON Flight.Destination;
-- GO
CREATE FULLTEXT INDEX ON Flight.Destination
(
        DestinationName
        Language 1033                 --1033 is the LCID for US English
)
KEY INDEX UNQ_Destination_DestinationName ON StarAirlinesFTCat
WITH CHANGE_TRACKING AUTO
GO

-- DROP FULLTEXT INDEX ON Flight.Country;
-- GO
CREATE FULLTEXT INDEX ON Flight.Country
(
        CountryName
        Language 1033                 --1033 is the LCID for US English
)
KEY INDEX UNQ_Country_CountryName ON StarAirlinesFTCat
WITH CHANGE_TRACKING AUTO
GO

-- DROP FULLTEXT INDEX ON Airport.Airport;
-- GO
CREATE FULLTEXT INDEX ON Airport.Airport
(
        AirportName
        Language 1033                 --1033 is the LCID for US English
)
KEY INDEX UNQ_Airport_AirportName ON StarAirlinesFTCat
WITH CHANGE_TRACKING AUTO
GO

/*
NonClustered Index
IDXNC_  non clustered index
*/

-- Template
DROP INDEX IF EXISTS IDXNC_Airport_DestinationID ON Airport.Airport;
GO
CREATE NONCLUSTERED INDEX IDXNC_Airport_DestinationID
    ON Airport.Airport(DestinationID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Airport_AirportTypeID ON Airport.Airport;
GO
CREATE NONCLUSTERED INDEX IDXNC_Airport_AirportTypeID
    ON Airport.Airport(AirportTypeID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Model_BrandID ON Airport.Model;
GO
CREATE NONCLUSTERED INDEX IDXNC_Model_BrandID
    ON Airport.Model(BrandID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Plane_ModelID ON Airport.Plane;
GO
CREATE NONCLUSTERED INDEX IDXNC_Plane_ModelID
    ON Airport.Plane(ModelID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Plane_StatusPlaneID ON Airport.Plane;
GO
CREATE NONCLUSTERED INDEX IDXNC_Plane_StatusPlaneID
    ON Airport.Plane(StatusPlaneID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Plane_BelongingAirport ON Airport.Plane;
GO
CREATE NONCLUSTERED INDEX IDXNC_Plane_BelongingAirport
    ON Airport.Plane(BelongingAirport)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Plane_AdmissionDate ON Airport.Plane;
GO
CREATE NONCLUSTERED INDEX IDXNC_Plane_AdmissionDate
    ON Airport.Plane(AdmissionDate)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Destination_CountryID ON Flight.Destination;
GO
CREATE NONCLUSTERED INDEX IDXNC_Destination_CountryID
    ON Flight.Destination(CountryID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Flight_DestinationID ON Flight.Flight;
GO
CREATE NONCLUSTERED INDEX IDXNC_Flight_DestinationID
    ON Flight.Flight(DestinationID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Flight_DestinationAirportID ON Flight.Flight;
GO
CREATE NONCLUSTERED INDEX IDXNC_Flight_DestinationAirportID
    ON Flight.Flight(DestinationAirportID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_FlightBenefit_FlightType_FlightBenefitID ON Flight.FlightBenefit_FlightType;
GO
CREATE NONCLUSTERED INDEX IDXNC_FlightBenefit_FlightType_FlightBenefitID
    ON Flight.FlightBenefit_FlightType(FlightBenefitID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Flight_FlightTypeID ON Flight.Flight;
GO
CREATE NONCLUSTERED INDEX IDXNC_Flight_FlightTypeID
    ON Flight.Flight(FlightTypeID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_FlightBenefit_FlightType_FlightTypeID ON Flight.FlightBenefit_FlightType;
GO
CREATE NONCLUSTERED INDEX IDXNC_FlightBenefit_FlightType_FlightTypeID
    ON Flight.FlightBenefit_FlightType(FlightTypeID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_FlightSchedule_PlaneID ON Flight.FlightSchedule;
GO
CREATE NONCLUSTERED INDEX IDXNC_FlightSchedule_PlaneID
    ON Flight.FlightSchedule(PlaneID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_FlightSchedule_Pilot ON Flight.FlightSchedule;
GO
CREATE NONCLUSTERED INDEX IDXNC_FlightSchedule_Pilot
    ON Flight.FlightSchedule(Pilot)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_FlightSchedule_Copilot ON Flight.FlightSchedule;
GO
CREATE NONCLUSTERED INDEX IDXNC_FlightSchedule_Copilot
    ON Flight.FlightSchedule(Copilot)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_FlightSchedule_FlightID ON Flight.FlightSchedule;
GO
CREATE NONCLUSTERED INDEX IDXNC_FlightSchedule_FlightID
    ON Flight.FlightSchedule(FlightID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Luggage_PersonID ON Flight.Luggage;
GO
CREATE NONCLUSTERED INDEX IDXNC_Luggage_PersonID
    ON Flight.Luggage(PersonID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Luggage_FlightScheduleID ON Flight.Luggage;
GO
CREATE NONCLUSTERED INDEX IDXNC_Luggage_FlightScheduleID
    ON Flight.Luggage(FlightScheduleID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Luggage_LuggageTypeID ON Flight.Luggage;
GO
CREATE NONCLUSTERED INDEX IDXNC_Luggage_LuggageTypeID
    ON Flight.Luggage(LuggageTypeID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Luggage_LuggageStatusID ON Flight.Luggage;
GO
CREATE NONCLUSTERED INDEX IDXNC_Luggage_LuggageStatusID
    ON Flight.Luggage(LuggageStatusID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Ticket_FlightID ON Flight.Ticket;
GO
CREATE NONCLUSTERED INDEX IDXNC_Ticket_FlightID
    ON Flight.Ticket(FlightID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Ticket_PersonID ON Flight.Ticket;
GO
CREATE NONCLUSTERED INDEX IDXNC_Ticket_PersonID
    ON Flight.Ticket(PersonID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Ticket_TicketTypeID ON Flight.Ticket;
GO
CREATE NONCLUSTERED INDEX IDXNC_Ticket_TicketTypeID
    ON Flight.Ticket(TicketTypeID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Ticket_FlightScheduleID ON Flight.Ticket;
GO
CREATE NONCLUSTERED INDEX IDXNC_Ticket_FlightScheduleID
    ON Flight.Ticket(FlightScheduleID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Person_Nationality ON Person.Person;
GO
CREATE NONCLUSTERED INDEX IDXNC_Person_Nationality
    ON Person.Person(Nationality)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Person_Document ON Person.Person;
GO
CREATE NONCLUSTERED INDEX IDXNC_Person_Document
    ON Person.Person(Document)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Person_DocumentTypeID ON Person.Person;
GO
CREATE NONCLUSTERED INDEX IDXNC_Person_DocumentTypeID
    ON Person.Person(DocumentTypeID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Person_BloodType ON Person.Person;
GO
CREATE NONCLUSTERED INDEX IDXNC_Person_BloodType
    ON Person.Person(BloodType)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Employee_StatusEmployee_EmployeeID ON Person.Employee_StatusEmployee;
GO
CREATE NONCLUSTERED INDEX IDXNC_Employee_StatusEmployee_EmployeeID
    ON Person.Employee_StatusEmployee(EmployeeID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Employee_StatusEmployee_StatusEmployeeID ON Person.Employee_StatusEmployee;
GO
CREATE NONCLUSTERED INDEX IDXNC_Employee_StatusEmployee_StatusEmployeeID
    ON Person.Employee_StatusEmployee(StatusEmployeeID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Employee_EmployeeRole_EmployeeID ON Person.Employee_EmployeeRole;
GO
CREATE NONCLUSTERED INDEX IDXNC_Employee_EmployeeRole_EmployeeID
    ON Person.Employee_EmployeeRole(EmployeeID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

DROP INDEX IF EXISTS IDXNC_Employee_EmployeeRole_EmployeeRoleID ON Person.Employee_EmployeeRole;
GO
CREATE NONCLUSTERED INDEX IDXNC_Employee_EmployeeRole_EmployeeRoleID
    ON Person.Employee_EmployeeRole(EmployeeRoleID)
    WITH (PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
GO

