/*public*/
DENY SELECT,DELETE,UPDATE,INSERT ON SCHEMA :: Person TO [public];
GO
DENY SELECT,DELETE,UPDATE,INSERT ON SCHEMA :: Flight TO [public];
GO
DENY SELECT,DELETE,UPDATE,INSERT ON SCHEMA :: Airport TO [public];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchDestinationByDestinationName
    TO [public];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchDestinationByID
    TO [public];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByDestiny
    TO [public];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByFlight
    TO [public];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByID
    TO [public];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByRangeOfDate
    TO [public];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightByDestiny
    TO [public];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightByFlightType
    TO [public];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightByID
    TO [public];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightByRangeOfCost
    TO [public];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightBenefitByID
    TO [public];
GO
/* db_owner */

/* SalesPerson */
CREATE ROLE sales_person AUTHORIZATION db_owner;
GO

DENY SELECT,DELETE,UPDATE,INSERT ON SCHEMA :: Person TO [sales_person];
GO
DENY SELECT,DELETE,UPDATE,INSERT ON SCHEMA :: Flight TO [sales_person];
GO
DENY SELECT,DELETE,UPDATE,INSERT ON SCHEMA :: Airport TO [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spAddLuggage
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spUpdateLuggage
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spGetLuggage
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByFlightScheduleID
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByLuggageID
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByLuggageStatusID
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByLuggageTypeID
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByPersonID
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByDestiny
    TO [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByFlight
    TO [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByID
    TO [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByRangeOfDate
    TO [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Person.spAddPerson
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchAllPersons
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByDocument
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByDocument
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByFirstName
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByID
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Person.spUpdatePerson
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spAddTicket
    TO  [sales_person];
GO
GRANT EXECUTE ON OBJECT:: Flight.spGetTicket
    TO  [sales_person];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByClientID
    TO  [sales_person];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByFlightID
    TO  [sales_person];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByFlightScheduleID
    TO  [sales_person];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByPersonID
    TO  [sales_person];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByTicketID
    TO  [sales_person];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByTicketTypeID
    TO  [sales_person];
GO
GRANT EXECUTE ON OBJECT:: Flight.spUpdateTicket
    TO  [sales_person];
GO


/*
basic_reader
*/
CREATE ROLE basic_reader AUTHORIZATION db_owner;
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchDestinationByDestinationName
    TO [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchDestinationByID
    TO [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByDestiny
    TO [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByFlight
    TO [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByID
    TO [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByRangeOfDate
    TO [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightByDestiny
    TO [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightByFlightType
    TO [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightByID
    TO [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightByRangeOfCost
    TO [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightBenefitByID
    TO [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Airport.spSearchPlaneByBrand
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Airport.spSearchPlaneByID
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Airport.spSearchPlaneByModelID
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spGetLuggage
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByFlightScheduleID
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByLuggageID
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByLuggageStatusID
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByLuggageTypeID
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByPersonID
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchAllPersons
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByDocument
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByDocument
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByFirstName
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByID
    TO  [basic_reader];
GO

GRANT EXECUTE ON OBJECT:: Flight.spGetTicket
    TO  [basic_reader];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByClientID
    TO  [basic_reader];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByFlightID
    TO  [basic_reader];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByFlightScheduleID
    TO  [basic_reader];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByPersonID
    TO  [basic_reader];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByTicketID
    TO  [basic_reader];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByTicketTypeID
    TO  [basic_reader];
GO

/* HR */
CREATE ROLE hr AUTHORIZATION db_owner;
GO

DENY SELECT,DELETE,UPDATE,INSERT ON SCHEMA :: Person TO [hr];
GO
DENY SELECT,DELETE,UPDATE,INSERT ON SCHEMA :: Flight TO [hr];
GO
DENY SELECT,DELETE,UPDATE,INSERT ON SCHEMA :: Airport TO [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spAddPerson
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchAllPersons
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByDocument
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByDocument
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByFirstName
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByID
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spUpdatePerson
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spAddDocumentType
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchDocumentTypeByID
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spUpdateDocumentType
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spAddEmployeeRole
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchEmployeeRoleByID
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spUpdateEmployeeRole
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spAddStatusEmployee
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spGetStatusEmployee
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchStatusEmployeeByID
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spUpdateStatusEmployee
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spAddEmployee_StatusEmployee
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spGetEmployee_StatusEmployee
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchEmployee_StatusEmployeeByEmployeeID
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchEmployee_StatusEmployeeByEmployeeIDAndStatusEmployeeID
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchEmployee_StatusEmployeeByStatusEmployeeID
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spUpdateEmployee_StatusEmployee
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spAddEmployee_EmployeeRole
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spGetEmployee_EmployeeRole
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchEmployee_EmployeeRoleByEmployeeID
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchEmployee_EmployeeRoleByEmployeeRoleID
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchEmployee_EmployeeRoleReadByEmployeeIDAndEmployeeRoleID
    TO  [hr];
GO

GRANT EXECUTE ON OBJECT:: Person.spUpdateEmployee_EmployeeRole
    TO  [hr];
GO

/*
technician
*/
CREATE ROLE technician AUTHORIZATION db_owner;
GO

DENY SELECT,DELETE,UPDATE,INSERT ON SCHEMA :: Person TO [technician];
GO
DENY SELECT,DELETE,UPDATE,INSERT ON SCHEMA :: Flight TO [technician];
GO
DENY SELECT,DELETE,UPDATE,INSERT ON SCHEMA :: Airport TO [technician];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchAllPersons
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByDocument
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByDocument
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByFirstName
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Person.spSearchPersonByID
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spGetTicket
    TO  [technician];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByClientID
    TO  [technician];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByFlightID
    TO  [technician];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByFlightScheduleID
    TO  [technician];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByPersonID
    TO  [technician];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByTicketID
    TO  [technician];
GO
GRANT EXECUTE ON OBJECT:: Flight.spSearchTicketByTicketTypeID
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByDestiny
    TO [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByFlight
    TO [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByID
    TO [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchFlightScheduleByRangeOfDate
    TO [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spGetLuggageType
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByLuggageTypeID
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageTypeByID
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spUpdateLuggageType
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByLuggageStatusID
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spGetStatusLuggage
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spUpdateLuggage
    TO  [sales_person];
GO

GRANT EXECUTE ON OBJECT:: Flight.spGetLuggage
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByFlightScheduleID
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByLuggageID
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByLuggageStatusID
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByLuggageTypeID
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spSearchLuggageByPersonID
    TO  [technician];
GO

GRANT EXECUTE ON OBJECT:: Flight.spGetStatusLuggage
    TO  [technician];
GO
/*
semi_owner
*/
CREATE ROLE semi_owner AUTHORIZATION db_owner;
GO

ALTER ROLE db_owner add member semi_owner;

DENY DELETE ON SCHEMA :: Person TO [semi_owner];
GO
DENY DELETE ON SCHEMA :: Flight TO [semi_owner];
GO
DENY DELETE ON SCHEMA :: Airport TO [semi_owner];
GO
