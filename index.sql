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



-- --Nombre de aeropuerto
-- CREATE NONCLUSTERED INDEX [IDXC_Name] ON [Airport].[Airport]
-- (
-- 	[Name] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- --Direccion del aeropuerto
-- CREATE NONCLUSTERED INDEX [IDXC_Direction] ON [Airport].[Airport]
-- (
-- 	[DestinationID] ASC,
-- 	[Direction] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- --Siglas de aeropuerto
-- CREATE NONCLUSTERED INDEX [IDXC_AirportID] ON [Airport].[Airport]
-- (
-- 	[AirportID] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
--
--
-- -- INDICES DEL VUELO: ----------------------------------------------------------------------------------------------------------------
--
-- --Nombre del vuelo
-- CREATE NONCLUSTERED INDEX [IDXC_FlightID] ON [Flight].[Flight]
-- (
-- 	[FlightID] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- -- Destino del vuelo
-- CREATE NONCLUSTERED INDEX [IDXC_Destino] ON [Flight].[Flight]
-- (
-- 	[DestinationID] ASC,
-- 	[DestinationAirportID] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- -- Costo del vuelo
-- CREATE NONCLUSTERED INDEX [IDXC_FlightCost] ON [Flight].[Flight]
-- (
-- 	[FlightCost] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- -- Tipo del vuelo
-- CREATE NONCLUSTERED INDEX [IDXC_FlightTypeID] ON [Flight].[Flight]
-- (
-- 	[FlightTypeID] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
--
-- --INDICES  DEL DESTINO: ----------------------------------------------------------------------------------------------------------------
--
-- --Nombre del destino
-- CREATE NONCLUSTERED INDEX [IDXC_Name] ON [Flight].[Destination]
-- (
-- 	[Name] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- -- Siglas del Destino
-- CREATE NONCLUSTERED INDEX [IDXC_DestinationID] ON [Flight].[Destination]
-- (
-- 	[DestinationID] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
--
-- --INDICES  DEL TICKET: ----------------------------------------------------------------------------------------------------------------
--
-- --Cliente del ticket
-- CREATE NONCLUSTERED INDEX [IDCX_PersonID] ON [Flight].[Ticket]
-- (
-- 	[PersonID] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- --Asiento del ticket
-- CREATE NONCLUSTERED INDEX [IDXC_SeatPlane] ON [Flight].[Ticket]
-- (
-- 	[SeatPlane] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- --Calendario del ticket
-- CREATE NONCLUSTERED INDEX [IDXC_FlightScheduleID] ON [Flight].[Ticket]
-- (
-- 	[FlightScheduleID] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
--
-- --INDICES  DEL PAIS: ----------------------------------------------------------------------------------------------------------------
--
-- --Nombre del pais
-- CREATE NONCLUSTERED INDEX [IDXC_Name] ON [Flight].[Country]
-- (
-- 	[Name] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
--
-- --INDICES  DEL AVION: ----------------------------------------------------------------------------------------------------------------
--
-- --Status del avion
-- CREATE NONCLUSTERED INDEX [IDXC_StatusPlaneID] ON [Airport].[Plane]
-- (
-- 	[StatusPlaneID] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- -- Modelo del avion
-- CREATE NONCLUSTERED INDEX [IDXC_Model] ON [Airport].[Plane]
-- (
-- 	[Model] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
--
-- --INDICES  DEL CALENDARIO: ----------------------------------------------------------------------------------------------------------------
--
-- -- Fecha de LLegada y Salida  en el calendario
-- CREATE NONCLUSTERED INDEX [IDXC_Date] ON [Flight].[FlightSchedule]
-- (
-- 	[DepartureDate] ASC,
-- 	[ArrivalDate] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- -- Destino en el calendario !!(El destino no esta en el calendario, se remplazara por el PlaneID)!!
-- CREATE NONCLUSTERED INDEX [IDXC_Destino(PlaneID)] ON [Flight].[FlightSchedule]
-- (
-- 	[PlaneID] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- -- ID del vuelo en el calendario
-- CREATE NONCLUSTERED INDEX [IDXC_FlightID] ON [Flight].[FlightSchedule]
-- (
-- 	[FlightID] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
--
--
-- --INDICES  DEL EMPLEADO: ----------------------------------------------------------------------------------------------------------------
--
-- --Nombre y Apellido del Empleado
-- CREATE NONCLUSTERED INDEX [IDXC_NameEmployee] ON [Person].[Person]
-- (
-- 	[FirstName] ASC,
-- 	[LastName] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- -- Documento del Empleado
-- CREATE NONCLUSTERED INDEX [IDXC_DocumentEmployee] ON [Person].[Person]
-- (
-- 	[Document] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- --Estado del Empleado  !!(Este fue creado en la tabla StatusEmployee porque el campo no esta en la tabla Person.Person)!!
-- CREATE NONCLUSTERED INDEX [IDXC_StatusEmployee] ON [Person].[StatusEmployee]
-- (
-- 	[StatusEmployeeID] ASC,
-- 	[Description] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
--
-- --INDICES  DEL CLIENTE: ----------------------------------------------------------------------------------------------------------------
--
-- --Nombre y Apellido del Cliente
-- CREATE NONCLUSTERED INDEX [IDXC_NameCliente] ON [Person].[Person]
-- (
-- 	[FirstName] ASC,
-- 	[LastName] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO
--
-- -- Documento del Cliente
-- CREATE NONCLUSTERED INDEX [IDXC_DocumentCliente] ON [Person].[Person]
-- (
-- 	[Document] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
-- GO