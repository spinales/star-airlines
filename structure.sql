CREATE DATABASE StarAirlines;
go
use StarAirlines;

/*  schemas */
IF (
  NOT EXISTS (
    SELECT
      *
    FROM
      sys.schemas
    WHERE
      name = 'Person'
  )
) BEGIN EXEC ('CREATE SCHEMA [Person] AUTHORIZATION [dbo]')
END IF (
  NOT EXISTS (
    SELECT
      *
    FROM
      sys.schemas
    WHERE
      name = 'Flight'
  )
) BEGIN EXEC ('CREATE SCHEMA [Flight] AUTHORIZATION [dbo]')
END IF (
  NOT EXISTS (
    SELECT
      *
    FROM
      sys.schemas
    WHERE
      name = 'Airport'
  )
) BEGIN EXEC ('CREATE SCHEMA [Airport] AUTHORIZATION [dbo]')
END

-- Statistics
Alter DATABASE StarAirlines SET auto_create_statistics ON
GO

-- Pais
create table
  Flight.Country(
    CountryID int identity(1, 1) not null,
    ISO2 CHAR(2) not null,
    ISO3 CHAR(3) not null,
    CurrencyName varchar(100) not null,
    Latitude NUMERIC(10,8) not null,
    Longitude NUMERIC(11,8) not null,
    CountryName varchar(100) not null,
    CONSTRAINT PK_Country_CountryID PRIMARY KEY CLUSTERED (CountryID),
    CONSTRAINT AK_ISO2 UNIQUE(ISO2),
    CONSTRAINT AK_ISO3 UNIQUE(ISO3),
    CONSTRAINT AK_CountryName UNIQUE(CountryName)
  );

-- Estado Empleado
create table
  Person.StatusEmployee(
    StatusEmployeeID int identity(1, 1) not null,
    StatusEmployeeName varchar(100) not null,
    Description varchar(200) not null,
    CONSTRAINT PK_StatusEmployee_StatusEmployeeID PRIMARY KEY CLUSTERED (StatusEmployeeID),
    CONSTRAINT AK_StatusEmployeeName UNIQUE(StatusEmployeeName)
  );

-- Tipo Equipaje
create table
  Flight.LuggageType(
    LuggageTypeID int identity(1, 1) not null,
    LuggageTypeName varchar(100) not null,
    Description varchar(200) not null,
    Cost money not null,
    CONSTRAINT PK_LuggageType_LuggageTypeID PRIMARY KEY CLUSTERED (LuggageTypeID),
    CONSTRAINT AK_LuggageTypeName UNIQUE(LuggageTypeName)
  );

-- Estado Equipaje
create table
  Flight.StatusLuggage(
    StatusLuggageID int identity(1, 1) not null,
    StatusLuggageName varchar(100) not null,
    Description varchar(200) not null,
    CONSTRAINT PK_StatusLuggage_StatusLuggageID PRIMARY KEY CLUSTERED (StatusLuggageID),
    CONSTRAINT AK_StatusLuggageName UNIQUE(StatusLuggageName)
  );

-- Estado Avion
create table
  Airport.StatusPlane(
    StatusPlaneID int identity(1, 1) not null,
    StatusPlaneName varchar(100) not null,
    Description varchar(200) not null,
    CONSTRAINT PK_StatusPlane_StatusPlaneID PRIMARY KEY CLUSTERED (StatusPlaneID),
    CONSTRAINT AK_StatusPlaneName UNIQUE(StatusPlaneName)
  );

-- Tipo Vuelo
create table
  Flight.FlightType(
    FlightTypeID int identity(1, 1) not null,
    FlightTypeName varchar(100) not null,
    Description varchar(200) not null,
    CONSTRAINT PK_FlightType_FlightTypeID PRIMARY KEY CLUSTERED (FlightTypeID),
    CONSTRAINT AK_FlightTypeName UNIQUE(FlightTypeName)
  );

-- Beneficios Vuelo
create table
  Flight.FlightBenefit(
    FlightBenefitID int identity(1, 1) not null,
    FlightBenefitName varchar(100) not null,
    Description varchar(200) not null,
    Cost money not null,
    CONSTRAINT PK_FlightBenefit_FlightBenefitID PRIMARY KEY CLUSTERED (FlightBenefitID),
    CONSTRAINT AK_FlightBenefitName UNIQUE(FlightBenefitName)
  );

-- Tipo Sangre
create table
  Person.BloodType(
    BloodTypeID int identity(1, 1) not null,
    BloodTypeName varchar(4) not null,
    Description varchar(200) not null,
    CONSTRAINT PK_BloodType_BloodTypeID PRIMARY KEY CLUSTERED (BloodTypeID),
    CONSTRAINT AK_BloodTypeName UNIQUE(BloodTypeName)
  );

-- Rol Empleado
create table
  Person.EmployeeRole(
    EmployeeRoleID int identity(1, 1) not null,
    EmployeeRoleName varchar(100) not null,
    Description varchar(200) not null,
    CONSTRAINT PK_EmployeeRole_EmployeeRoleID PRIMARY KEY CLUSTERED (EmployeeRoleID),
    CONSTRAINT AK_EmployeeRoleName UNIQUE(EmployeeRoleName)
  );

-- Tipo Documento
create table
  Person.DocumentType(
    DocumentTypeID int identity(1, 1) not null,
    DocumentTypeName varchar(100) not null,
    Description varchar(200) not null,
    CONSTRAINT PK_DocumentType_DocumentTypeID PRIMARY KEY CLUSTERED (DocumentTypeID),
    CONSTRAINT AK_DocumentTypeName UNIQUE(DocumentTypeName)
  );

-- Ciudades / Destinos
create table
  Flight.Destination(
    DestinationID int identity(1, 1) not null,
    CountryID int not null,
    DestinationName varchar(100) not null,
    Acronym varchar(4) null,
    Latitude NUMERIC(10,8) null,
    Longitude NUMERIC(11,8) null,
    CONSTRAINT PK_Destination_DestinationID PRIMARY KEY CLUSTERED (DestinationID),
    CONSTRAINT FK_Destination_Ref_Country FOREIGN KEY (CountryID) REFERENCES Flight.Country (CountryID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT AK_DestinationName UNIQUE(DestinationName)
  );

-- Tipo de aeropuerto
create table
  Airport.AirportType(
    AirportTypeID int identity(1, 1) not null,
    AirportTypeName varchar(100) not null,
    Description varchar(200) not null,
    CONSTRAINT PK_AirportType_AirportTypeID PRIMARY KEY CLUSTERED (AirportTypeID),
    CONSTRAINT AK_AirportTypeName UNIQUE(AirportTypeName)
  );

-- Marca
create table
  Airport.Brand(
    BrandID int identity(1, 1) not null,
    BrandName varchar(100) not null,
    Description varchar(200) not null,
    Email varchar(100) not null,
    CONSTRAINT PK_Brand_BrandID PRIMARY KEY CLUSTERED (BrandID),
    CONSTRAINT AK_BrandName UNIQUE(BrandName),
    CONSTRAINT AK_Email UNIQUE(Email)
  );

-- Modelo
create table
  Airport.Model(
    ModelID int identity(1,1) not null,
    ModelName varchar(100) not null,
    Description varchar(250),
    BrandID int not null,
    CONSTRAINT PK_Model_ModelID PRIMARY KEY (ModelID),
    CONSTRAINT FK_Model_Ref_Brand FOREIGN KEY (BrandID) REFERENCES Airport.Brand (BrandID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT AK_ModelName UNIQUE(ModelName)
  );

-- Tipo Ticket
create table
  Flight.TicketType(
    TicketTypeID int identity(1, 1) not null,
    TicketTypeName varchar(100) not null,
    Description varchar(200) not null,
    Cost money not null,
    FreeWeight int not null,
    Acronym char(4) not null,
    CONSTRAINT PK_TicketType_TicketTypeID PRIMARY KEY CLUSTERED (TicketTypeID),
    CONSTRAINT AK_TicketTypeName UNIQUE(TicketTypeName),
    CONSTRAINT AK_TicketType_Acronym UNIQUE(Acronym)
  );

-- Persona
create table
  Person.Person(
    PersonID int identity(1, 1) not null,
    FirstName varchar(100) not null,
    LastName varchar(100) not null,
    AdmissionDate date not null,
    Nationality int not null,
    Gender char(1) not null check(Gender in('M','F')),
    Document varchar(20) not null,
    DocumentTypeID int not null,
    PhoneNumber varchar(15) not null,
    DOB date,
    BloodType int not null,
    Direction varchar(250),
    Email varchar(100) not null,
    CONSTRAINT PK_Person_PersonID PRIMARY KEY CLUSTERED (PersonID),
    CONSTRAINT FK_Person_Ref_Country FOREIGN KEY (Nationality) REFERENCES Flight.Country (CountryID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Person_Ref_DocumentType FOREIGN KEY (DocumentTypeID) REFERENCES Person.DocumentType (DocumentTypeID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Person_Ref_BloodType FOREIGN KEY (BloodType) REFERENCES Person.BloodType (BloodTypeID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT AK_Document UNIQUE(Document)
  );

-- Aeropuerto
create table
  Airport.Airport(
    AirportID int identity(1, 1) not null,
    AirportName varchar(200) not null,
    DestinationID int not null,
    Direction varchar(250),
    AirportTypeID int not null,
    CONSTRAINT PK_Airport_AirportID PRIMARY KEY CLUSTERED (AirportID),
    CONSTRAINT FK_Airport_Ref_Destination FOREIGN KEY (DestinationID) REFERENCES Flight.Destination (DestinationID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Airport_Ref_AirportType FOREIGN KEY (AirportTypeID) REFERENCES Airport.AirportType (AirportTypeID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT AK_AirportName UNIQUE(AirportName)
  );

-- Vuelos
create table
  Flight.Flight(
    FlightID int identity(1, 1) not null,
    DestinationID int not null,
    -- DestinationID
    DestinationAirportID int not null,
    -- AirportID
    TravelDistance int not null,
    FlightCost int not null,
    TravelDuration time not null,
    FlightTypeID int not null,
    CONSTRAINT PK_Flight_Ref_FlightID PRIMARY KEY CLUSTERED (FlightID),
    CONSTRAINT FK_Flight_Ref_Destination FOREIGN KEY (DestinationID) REFERENCES Flight.Destination (DestinationID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Flight_Ref_Airport FOREIGN KEY (DestinationAirportID) REFERENCES Airport.Airport (AirportID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Flight_Ref_FlightType FOREIGN KEY (FlightTypeID) REFERENCES Flight.FlightType (FlightTypeID) ON DELETE NO ACTION ON UPDATE NO ACTION
  );

-- Avion
create table
  Airport.Plane(
    PlaneID int identity(1, 1) not null,
    ModelID int not null,
    SeatingCapacity int not null,
    StatusPlaneID int not null,
    AdmissionDate date not null,
    RetirementDate date,
    BelongingAirport int,
    -- AirportID
    CONSTRAINT PK_Plane_PlaneID PRIMARY KEY CLUSTERED (PlaneID),
    CONSTRAINT FK_Plane_Ref_Model FOREIGN KEY (ModelID) REFERENCES Airport.Model (ModelID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Plane_Ref_StatusPlane FOREIGN KEY (StatusPlaneID) REFERENCES Airport.StatusPlane (StatusPlaneID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Plane_Ref_Airport FOREIGN KEY (BelongingAirport) REFERENCES Airport.Airport (AirportID) ON DELETE NO ACTION ON UPDATE NO ACTION
  );

-- Calendario vuelos
create table
  Flight.FlightSchedule(
    FlightScheduleID int identity(1, 1) not null,
    DepartureDate datetime not null,
    ArrivalDate datetime not null,
    PlaneID int not null,
    Pilot int not null,
    -- EmplooyeeID
    CoPilot int not null,
    -- EmplooyeeID
    FlightID int not null,
    CONSTRAINT PK_FlightSchedule_FlightScheduleID PRIMARY KEY CLUSTERED (FlightScheduleID),
    CONSTRAINT FK_FlightSchedule_Ref_Plane FOREIGN KEY (PlaneID) REFERENCES Airport.Plane (PlaneID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_FlightSchedule_Ref_Person_Pilot FOREIGN KEY (Pilot) REFERENCES Person.Person (PersonID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_FlightSchedule_Ref_Person_Copilot FOREIGN KEY (CoPilot) REFERENCES Person.Person (PersonID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_FlightSchedule_Ref_Flight FOREIGN KEY (FlightID) REFERENCES Flight.Flight (FlightID) ON DELETE CASCADE ON UPDATE CASCADE
  );

-- Equipaje
create table
  Flight.Luggage(
    LuggageID int identity(1, 1) not null,
    PersonID int not null,
    FlightScheduleID int not null,
    Weight int not null,
    Cost money not null,
    LuggageTypeID int not null,
    LuggageStatusID int not null,
    CONSTRAINT PK_Luggage_LuggageID PRIMARY KEY CLUSTERED (LuggageID),
    CONSTRAINT FK_Luggage_Ref_Person FOREIGN KEY (PersonID) REFERENCES Person.Person (PersonID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Luggage_Ref_FlightSchedule FOREIGN KEY (FlightScheduleID) REFERENCES Flight.FlightSchedule (FlightScheduleID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Luggage_Ref_LuggageType FOREIGN KEY (LuggageTypeID) REFERENCES Flight.LuggageType (LuggageTypeID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Luggage_Ref_StatusLuggage FOREIGN KEY (LuggageStatusID) REFERENCES Flight.StatusLuggage (StatusLuggageID) ON DELETE NO ACTION ON UPDATE NO ACTION
  );

-- Ticket
create table
  Flight.Ticket(
    TicketID int identity(1, 1) not null,
    FlightID int not null,
    PersonID int not null,
    TicketTypeID int not null,
    Cost money not null,
    FlightScheduleID int not null,
    SeatPlane varchar(7) not null,
    CONSTRAINT PK_Ticket_TicketID PRIMARY KEY CLUSTERED (TicketID),
    CONSTRAINT FK_Ticket_Ref_Person FOREIGN KEY (PersonID) REFERENCES Person.Person (PersonID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Ticket_Ref_Flight FOREIGN KEY (FlightID) REFERENCES Flight.Flight (FlightID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Ticket_Ref_TicketType FOREIGN KEY (TicketTypeID) REFERENCES Flight.TicketType (TicketTypeID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Ticket_Ref_FlightSchedule FOREIGN KEY (FlightScheduleID) REFERENCES Flight.FlightSchedule (FlightScheduleID) ON DELETE NO ACTION ON UPDATE NO ACTION
  );

-- Entidades puentes
-- Beneficios_Vuelo <---> Tipo_Vuelo
create table
  Flight.FlightBenefit_FlightType(
    FlightBenefitID int not null,
    FlightTypeID int not null,
    -- Cost money not null,
    CONSTRAINT PK_FlightBenefit_FlightType PRIMARY KEY CLUSTERED (FlightBenefitID, FlightTypeID),
    CONSTRAINT FK_FlightBenefit_FlightType_Ref_FlightBenefit FOREIGN KEY (FlightBenefitID) REFERENCES Flight.FlightBenefit (FlightBenefitID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_FlightBenefit_FlightType_Ref_FlightType FOREIGN KEY (FlightTypeID) REFERENCES Flight.FlightType (FlightTypeID) ON DELETE CASCADE ON UPDATE CASCADE
  );

create table
  Person.Employee_EmployeeRole (
    EmployeeID int not null,
    EmployeeRoleID int not null,
    StartDate date not null,
    EndDate date,
    Description varchar(100),
    CONSTRAINT FK_Employee_EmployeeRole_Ref_Person FOREIGN KEY (EmployeeID) REFERENCES Person.Person (PersonID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Employee_EmployeeRole_Ref_EmployeeRole FOREIGN KEY (EmployeeRoleID) REFERENCES Person.EmployeeRole (EmployeeRoleID) ON DELETE NO ACTION ON UPDATE NO ACTION
  );

create table
  Person.Employee_StatusEmployee (
    EmployeeID int not null,
    StatusEmployeeID int not null,
    StartDate date not null,
    EndDate date,
    Description varchar(100),
    CONSTRAINT FK_Employee_StatusEmployee_Ref_Person FOREIGN KEY (EmployeeID) REFERENCES Person.Person (PersonID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Employee_StatusEmployee_Ref_StatusEmployee FOREIGN KEY (StatusEmployeeID) REFERENCES Person.StatusEmployee (StatusEmployeeID) ON DELETE NO ACTION ON UPDATE NO ACTION
  );