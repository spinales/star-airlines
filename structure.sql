CREATE DATABASE StarAirlines;
go
use StarAirlines;

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
END -- Pais
create table
  Flight.Country(
    CountryID int identity(1, 1) not null,
    Name varchar(100) not null,
    Location geography,
    constraint PK_Country_CountryID primary key clustered (CountryID)
  );

-- Estado Empleado
create table
  Person.StatusEmployee(
    StatusEmployeeID int identity(1, 1) not null,
    Name varchar(100) not null,
    Description varchar(200) not null,
    constraint PK_StatusEmployee_StatusEmployeeID primary key clustered (StatusEmployeeID)
  );

-- Tipo Equipaje
create table
  Flight.LuggageType(
    LuggageTypeID int identity(1, 1) not null,
    Name varchar(100) not null,
    Description varchar(200) not null,
    constraint PK_LuggageType_LuggageTypeID primary key clustered (LuggageTypeID)
  );

-- Estado Equipaje
create table
  Flight.StatusLuggage(
    StatusLuggageID int identity(1, 1) not null,
    Name varchar(100) not null,
    Description varchar(200) not null,
    constraint PK_StatusLuggage_StatusLuggageID primary key clustered (StatusLuggageID)
  );

-- Estado Avion
create table
  Airport.StatusPlane(
    StatusPlaneID int identity(1, 1) not null,
    Name varchar(100) not null,
    Description varchar(200) not null,
    constraint PK_StatusPlane_StatusPlaneID primary key clustered (StatusPlaneID)
  );

-- Tipo Vuelo
create table
  Flight.FlightType(
    FlightTypeID int identity(1, 1) not null,
    Name varchar(100) not null,
    Description varchar(200) not null,
    constraint PK_FlightType_FlightTypeID primary key clustered (FlightTypeID)
  );

-- Beneficios Vuelo
create table
  Flight.FlightBenefit(
    FlightBenefitID int identity(1, 1) not null,
    Name varchar(100) not null,
    Description varchar(200) not null,
    Cost money not null,
    constraint PK_FlightBenefit_FlightBenefitID primary key clustered (FlightBenefitID)
  );

-- Tipo Sangre
create table
  Person.BloodType(
    BloodTypeID int identity(1, 1) not null,
    Name varchar(100) not null,
    Description varchar(200) not null,
    constraint PK_BloodType_BloodTypeID primary key clustered (BloodTypeID)
  );

-- Rol Empleado
create table
  Person.EmployeeRole(
    EmployeeRoleID int identity(1, 1) not null,
    Name varchar(100) not null,
    Description varchar(200) not null,
    constraint PK_EmployeeRole_EmployeeRoleID primary key clustered (EmployeeRoleID)
  );

-- Tipo Documento
create table
  Person.DocumentType(
    DocumentTypeID int identity(1, 1) not null,
    Name varchar(100) not null,
    Description varchar(200) not null,
    constraint PK_DocumentType_DocumentTypeID primary key clustered (DocumentTypeID)
  );

-- Ciudades / Destinos
create table
  Flight.Destination(
    DestinationID int identity(1, 1) not null,
    CountryID int not null,
    Name varchar(100) not null,
    Acronym varchar(4) not null,
    Location geography,
    constraint PK_Destination_DestinationID primary key clustered (DestinationID),
    CONSTRAINT FK_Destination_Ref_Country FOREIGN KEY (CountryID) REFERENCES Flight.Country (CountryID) ON DELETE CASCADE ON UPDATE CASCADE
  );

-- Tipo de aeropuerto
create table
  Airport.AirportType(
    AirportTypeID int identity(1, 1) not null,
    Name varchar(100) not null,
    Description varchar(200) not null,
    constraint PK_AirportType_AirportTypeID primary key clustered (AirportTypeID)
  );

-- Marca
create table
  Airport.Brand(
    BrandID int identity(1, 1) not null,
    Name varchar(100) unique not null,
    Description varchar(200) not null,
    Email varchar(100) not null,
    constraint PK_Brand_BrandID primary key clustered (BrandID)
  );

-- Tipo Ticket
create table
  Flight.TicketType(
    TicketTypeID int identity(1, 1) not null,
    Name varchar(100) unique not null,
    Description varchar(200) not null,
    Cost money not null,
    FreeWeight int not null,
    constraint PK_TicketType_TicketTypeID primary key clustered (TicketTypeID)
  );

-- Persona
create table
  Person.Person(
    PersonID int identity(1, 1) not null,
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    AdmissionDate date not null,
    Nationality int not null,
    Gender char(1) not null,
    Document varchar(20) not null,
    DocumentTypeID int not null,
    PhoneNumber varchar(15) not null,
    DOB date,
    BloodType int not null,
    Direction varchar(250),
    Email varchar(100) not null,
    constraint PK_Person_PersonID primary key clustered (PersonID),
    CONSTRAINT FK_Person_Ref_Country FOREIGN KEY (Nationality) REFERENCES Flight.Country (CountryID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Person_Ref_DocumentType FOREIGN KEY (DocumentTypeID) REFERENCES Person.DocumentType (DocumentTypeID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Person_Ref_BloodType FOREIGN KEY (BloodType) REFERENCES Person.BloodType (BloodTypeID) ON DELETE NO ACTION ON UPDATE NO ACTION
  );

-- Aeropuerto
create table
  Airport.Airport(
    AirportID int identity(1, 1) not null,
    Name varchar(200) not null,
    DestinationID int not null,
    Direction varchar(250),
    AirportTypeID int not null,
    constraint PK_Airport_AirportID primary key clustered (AirportID),
    CONSTRAINT FK_Airport_Ref_Destination FOREIGN KEY (DestinationID) REFERENCES Flight.Destination (DestinationID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Airport_Ref_AirportType FOREIGN KEY (AirportTypeID) REFERENCES Airport.AirportType (AirportTypeID) ON DELETE NO ACTION ON UPDATE CASCADE
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
    constraint PK_Flight_Ref_FlightID primary key clustered (FlightID),
    CONSTRAINT FK_Flight_Ref_Destination FOREIGN KEY (DestinationID) REFERENCES Flight.Destination (DestinationID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Flight_Ref_Airport FOREIGN KEY (DestinationAirportID) REFERENCES Airport.Airport (AirportID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Flight_Ref_FlightType FOREIGN KEY (FlightTypeID) REFERENCES Flight.FlightType (FlightTypeID) ON DELETE NO ACTION ON UPDATE NO ACTION
  );

-- Avion
create table
  Airport.Plane(
    PlaneID int identity(1, 1) not null,
    BrandID int not null,
    Model varchar(50) not null,
    SeatingCapacity int not null,
    StatusPlaneID int not null,
    AdmissionDate date not null,
    RetirementDate date,
    SeatingCapacityHigh int not null,
    SeatingCapacityMedium int not null,
    SeatingCapacityLow int not null,
    BelongingAirport int not null,
    -- AirportID
    constraint PK_Plane_PlaneID primary key clustered (PlaneID),
    CONSTRAINT FK_Plane_Ref_Brand FOREIGN KEY (BrandID) REFERENCES Airport.Brand (BrandID) ON DELETE NO ACTION ON UPDATE CASCADE,
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
    MediumSeatsAvailable int not null,
    LowSeatsAvailable int not null,
    HighSeatsAvailable int not null,
    constraint PK_FlightSchedule_FlightScheduleID primary key clustered (FlightScheduleID),
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
    constraint PK_Luggage_LuggageID primary key clustered (LuggageID),
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
    constraint PK_Ticket_TicketID primary key clustered (TicketID),
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
    Cost money not null,
    CONSTRAINT PK_FlightBenefit_FlightType PRIMARY KEY (FlightBenefitID, FlightTypeID),
    CONSTRAINT FK_FlightBenefit_FlightType_Ref_FlightBenefit FOREIGN KEY (FlightBenefitID) REFERENCES Flight.FlightBenefit (FlightBenefitID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_FlightBenefit_FlightType_Ref_FlightType FOREIGN KEY (FlightTypeID) REFERENCES Flight.FlightType (FlightTypeID) ON DELETE CASCADE ON UPDATE CASCADE
  );

create table
  Person.Employee_EmployeeRole (
    EmployeeID int not null,
    EmployeeRoleID int not null,
    StartDate date not null,
    EndDate date,
    Description varchar,
    constraint FK_Employee_EmployeeRole_Ref_Person foreign key (EmployeeID) references Person.Person (PersonID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    constraint FK_Employee_EmployeeRole_Ref_EmployeeRole foreign key (EmployeeRoleID) references Person.EmployeeRole (EmployeeRoleID) ON DELETE NO ACTION ON UPDATE NO ACTION
  );

create table
  Person.Employee_StatusEmployee (
    EmployeeID int not null,
    StatusEmployeeID int not null,
    StartDate date not null,
    EndDate date,
    Description varchar,
    constraint FK_Employee_StatusEmployee_Ref_Person foreign key (EmployeeID) references Person.Person (PersonID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    constraint FK_Employee_StatusEmployee_Ref_StatusEmployee foreign key (StatusEmployeeID) references Person.StatusEmployee (StatusEmployeeID) ON DELETE NO ACTION ON UPDATE NO ACTION
  );