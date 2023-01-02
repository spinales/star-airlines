package main

import (
	"encoding/csv"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"time"

	"github.com/brianvoe/gofakeit/v6"
	"github.com/shopspring/decimal"
	"gorm.io/driver/sqlserver"
	"gorm.io/gorm"
	"gorm.io/gorm/schema"
)

type City struct {
	ID          int    `json:"id"`
	Name        string `json:"name"`
	StateID     int    `json:"state_id"`
	StateCode   string `json:"state_code"`
	CountryID   int    `json:"country_id"`
	CountryCode string `json:"country_code"`
	Latitude    string `json:"latitude"`
	Longitude   string `json:"longitude"`
	WikiDataID  string `json:"wikiDataId"`
}

func main() {
	// GenerateIndexCode()

	dsn := "sqlserver://spinales:123456789@localhost:1433?database=StarAirlines2"
	db, err := gorm.Open(sqlserver.Open(dsn), &gorm.Config{
		NamingStrategy: schema.NamingStrategy{
			SingularTable: true, // use singular table name, table for `User` would be `user` with this option enabled
			NoLowerCase:   true, // skip the snake_casing of names
		},
	})
	if err != nil {
		panic(err.Error())
	}

	// ParseCities()
	CountryData(db)
	StatusEmployeeData(db)
	LuggageTypeData(db)
	StatusLuggageData(db)
	StatusPlaneData(db)
	FlightTypeData(db)
	FlightBenefitData(db)
	BloodTypeData(db)
	EmployeeRoleData(db)
	DocumentTypeData(db)
	AirportTypeData(db)
	BrandData(db)
	ModelData(db)
	TicketTypeData(db)
	PersonData(db)
	AirportData(db)
	FlightData(db)
	PlaneData(db)
	Employee_EmployeeRoleData(db)
	Employee_StatusEmployeeData(db)
	FlightBenefit_FlightTypeData(db)
	FlightScheduleData(db)
	LuggageData(db)
	TicketData(db)
}

func GenerateIndexCode() {
	arr := []Index{
		{Schema: "Airport", Table: "Airport", Column: "AirportTypeID"},
		{Schema: "Airport", Table: "Model", Column: "BrandID"},
		{Schema: "Airport", Table: "Plane", Column: "ModelID"},
		{Schema: "Airport", Table: "Plane", Column: "StatusPlaneID"},
		{Schema: "Airport", Table: "Plane", Column: "BelongingAirport"},
		{Schema: "Airport", Table: "Plane", Column: "AdmissionDate"},

		{Schema: "Flight", Table: "Destination", Column: "CountryID"},
		{Schema: "Flight", Table: "Flight", Column: "DestinationID"},
		{Schema: "Flight", Table: "Flight", Column: "DestinationAirportID"},
		{Schema: "Flight", Table: "FlightBenefit_FlightType", Column: "FlightBenefitID"},
		{Schema: "Flight", Table: "Flight", Column: "FlightTypeID"},
		{Schema: "Flight", Table: "FlightBenefit_FlightType", Column: "FlightTypeID"},
		{Schema: "Flight", Table: "FlightSchedule", Column: "PlaneID"},
		{Schema: "Flight", Table: "FlightSchedule", Column: "Pilot"},
		{Schema: "Flight", Table: "FlightSchedule", Column: "Copilot"},
		{Schema: "Flight", Table: "FlightSchedule", Column: "FlightID"},
		{Schema: "Flight", Table: "Luggage", Column: "PersonID"},
		{Schema: "Flight", Table: "Luggage", Column: "FlightScheduleID"},
		{Schema: "Flight", Table: "Luggage", Column: "LuggageTyoeID"},
		{Schema: "Flight", Table: "Luggage", Column: "LuggageStatusID"},
		{Schema: "Flight", Table: "Ticket", Column: "FlightID"},
		{Schema: "Flight", Table: "Ticket", Column: "PersonID"},
		{Schema: "Flight", Table: "Ticket", Column: "TicketTypeID"},
		{Schema: "Flight", Table: "Ticket", Column: "FlightScheduleID"},

		{Schema: "Person", Table: "Person", Column: "Nationality"},
		{Schema: "Person", Table: "Person", Column: "Document"},
		{Schema: "Person", Table: "Person", Column: "DocumentTypeID"},
		{Schema: "Person", Table: "Person", Column: "BloodTypeID"},
		{Schema: "Person", Table: "Employee_StatusEmployee", Column: "EmployeeID"},
		{Schema: "Person", Table: "Employee_StatusEmployee", Column: "StatusEmployeeID"},
		{Schema: "Person", Table: "Employee_EmployeeRole", Column: "EmployeeID"},
		{Schema: "Person", Table: "Employee_EmployeeRole", Column: "EmployeeRoleID"},
	}

	for _, v := range arr {
		fmt.Printf(`DROP INDEX IF EXISTS IDXNC_%s_%s ON %s.%s;
	GO
	CREATE NONCLUSTERED INDEX IDXNC_%s_%s ON %s.%s
		ON %s.%s(%s)
		WITH (PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			SORT_IN_TEMPDB = OFF,
			DROP_EXISTING = OFF,
			ONLINE = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF);
	GO`, v.Table, v.Column, v.Schema, v.Table, v.Table, v.Column, v.Schema, v.Table, v.Schema, v.Table, v.Column)
	}

}

func CountryData(db *gorm.DB) {
	file, err := os.Open("countries.csv")
	if err != nil {
		log.Println("Cannot open CSV file:", err)
	}
	defer file.Close()
	reader := csv.NewReader(file)
	reader.Read()

	rows, err := reader.ReadAll()
	if err != nil {
		log.Println("Cannot read CSV file:", err)
	}

	var countries []Country
	var capitals []string
	for _, row := range rows {
		capitals = append(capitals, row[6])
		latitude, _ := decimal.NewFromString(row[15])
		longitude, _ := decimal.NewFromString(row[16])
		country := Country{
			ISO2:         row[3],
			ISO3:         row[2],
			CurrencyName: row[8],
			Latitude:     latitude,
			Longitude:    longitude,
			CountryName:  row[1],
		}

		db.Table("Flight.Country").Create(&country)
		countries = append(countries, country)

	}
	// db.Table("Flight.Country").Create(&countries)

	content, err := ioutil.ReadFile("./cities.json")
	if err != nil {
		log.Fatal("Error when opening file: ", err)
	}

	var data []City
	err = json.Unmarshal(content, &data)
	if err != nil {
		log.Fatal("Error during Unmarshal(): ", err)
	}
	log.Println(len(data))

	for ii := 0; ii < len(countries); ii++ {

		destiny := Destination{
			CountryID:       countries[ii].CountryID,
			DestinationName: capitals[ii],
		}
		for j := 0; j < len(data); j++ {
			if capitals[ii] == data[j].Name {
				destiny.Latitude = decimal.RequireFromString(data[j].Latitude)
				destiny.Longitude = decimal.RequireFromString(data[j].Longitude)
				if data[j].StateCode == "" {
					destiny.Acronym = capitals[ii][:3]
				} else {
					destiny.Acronym = data[j].StateCode
				}
			}
		}
		db.Table("Flight.Destination").Create(&destiny)
	}
}

func StatusEmployeeData(db *gorm.DB) {
	data := []StatusEmployee{
		{
			StatusEmployeeName: "Active",
			Description:        gofakeit.SentenceSimple(),
		},
		{
			StatusEmployeeName: "Medical License",
			Description:        gofakeit.SentenceSimple(),
		},
		{
			StatusEmployeeName: "Holidays",
			Description:        gofakeit.SentenceSimple(),
		},
		{
			StatusEmployeeName: "Retired",
			Description:        gofakeit.SentenceSimple(),
		},
	}

	db.Table("Person.StatusEmployee").Create(&data)
}

func LuggageTypeData(db *gorm.DB) {
	data := []LuggageType{
		{
			LuggageTypeName: "Checked baggage",
			Description:     gofakeit.SentenceSimple(),
		},
		{
			LuggageTypeName: "Hand luggage",
			Description:     gofakeit.SentenceSimple(),
		},
		{
			LuggageTypeName: "Personal accessory",
			Description:     gofakeit.SentenceSimple(),
		},
		{
			LuggageTypeName: "Pet",
			Description:     gofakeit.SentenceSimple(),
		},
		{
			LuggageTypeName: "Cash register",
			Description:     gofakeit.SentenceSimple(),
		},
	}

	db.Table("Flight.LuggageType").Create(&data)
}

func StatusLuggageData(db *gorm.DB) {
	data := []StatusLuggage{
		{
			StatusLuggageName: "Passed",
			Description:       gofakeit.SentenceSimple(),
		},
		{
			StatusLuggageName: "Confiscated",
			Description:       gofakeit.SentenceSimple(),
		},
		{
			StatusLuggageName: "Damaged",
			Description:       gofakeit.SentenceSimple(),
		},
		{
			StatusLuggageName: "Lost",
			Description:       gofakeit.SentenceSimple(),
		},
	}

	db.Table("Flight.StatusLuggage").Create(&data)
}

func StatusPlaneData(db *gorm.DB) {
	data := []StatusPlane{
		{
			StatusPlaneName: "Active",
			Description:     gofakeit.SentenceSimple(),
		},
		{
			StatusPlaneName: "Maintenance",
			Description:     gofakeit.SentenceSimple(),
		},
		{
			StatusPlaneName: "Retired",
			Description:     gofakeit.SentenceSimple(),
		},
	}
	db.Table("Airport.StatusPlane").Create(&data)
}

func FlightTypeData(db *gorm.DB) {
	data := []FlightType{
		{
			FlightTypeName: "Straight",
			Description:    gofakeit.SentenceSimple(),
		},
		{
			FlightTypeName: "Scale",
			Description:    gofakeit.SentenceSimple(),
		},
	}
	db.Table("Flight.FlightType").Create(&data)
}

func FlightBenefitData(db *gorm.DB) {
	opt := []string{"Food", "Wine", "Comfortable seats",
		"Additional Baggage",
		"Waiting room",
		"Headphones",
		"TV screens",
		"Simple Snack",
		"Luxury dinner",
		"Simple drinks",
		"Extra space",
		"Quick access",
		"Bar",
		"VIP room",
		"Restaurant"}
	data := []FlightBenefit{}

	for i := 0; i < len(opt); i++ {
		temp := FlightBenefit{
			FlightBenefitName: opt[i],
			Description:       gofakeit.SentenceSimple(),
			Cost:              uint(gofakeit.Number(50, 150)),
		}
		data = append(data, temp)
	}
	db.Table("Flight.FlightBenefit").Create(&data)
}

func BloodTypeData(db *gorm.DB) {
	opt := []string{"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"}
	data := []BloodType{}

	for i := 0; i < len(opt); i++ {
		temp := BloodType{
			BloodTypeName: opt[i],
			Description:   gofakeit.SentenceSimple(),
		}
		data = append(data, temp)
	}
	db.Table("Person.BloodType").Create(&data)
}

func EmployeeRoleData(db *gorm.DB) {
	opt := []string{"Aeronautical engineer",
		"Flight dispatcher",
		"Airport operations manager",
		"Airport security officer",
		"Airport engineer",
		"Pilot",
		"Aircraft maintenance technician",
		"Aircraft fueler",
		"Air traffic controller",
		"Flight attendant",
		"Avionics technician",
		"Airline reservation agent",
		"Airline baggage handler",
		"Passenger assistant",
		"Airline food service worker"}
	var data []EmployeeRole

	for i := 0; i < len(opt); i++ {
		temp := EmployeeRole{
			EmployeeRoleName: opt[i],
			Description:      gofakeit.SentenceSimple(),
		}
		data = append(data, temp)
	}
	db.Table("Person.EmployeeRole").Create(&data)
}

func DocumentTypeData(db *gorm.DB) {
	opt := []string{"Cedula", "Passport", "SSN"}
	var data []DocumentType

	for i := 0; i < len(opt); i++ {
		temp := DocumentType{
			DocumentTypeName: opt[i],
			Description:      gofakeit.SentenceSimple(),
		}
		data = append(data, temp)
	}
	db.Table("Person.DocumentType").Create(&data)
}

func AirportTypeData(db *gorm.DB) {
	opt := []string{"Transoceanic airport",
		"Transcontinental airport",
		"International Airport",
		"National airport",
		"Local Airport",
		"Small airport"}

	data := []AirportType{}
	for i := 0; i < len(opt); i++ {
		temp := AirportType{
			AirportTypeName: opt[i],
			Description:     gofakeit.SentenceSimple(),
		}
		data = append(data, temp)
	}
	db.Table("Airport.AirportType").Create(&data)
}

func BrandData(db *gorm.DB) {
	opt := []string{"Airbus", "Boeing"}

	data := []Brand{}
	for i := 0; i < len(opt); i++ {
		temp := Brand{
			BrandName:   opt[i],
			Description: gofakeit.SentenceSimple(),
			Email:       gofakeit.Email(),
		}
		data = append(data, temp)
	}
	db.Table("Airport.Brand").Create(&data)
}

func ModelData(db *gorm.DB) {
	boeing := []string{"787", "777X", "777", "767", "747-8", "737 MAX", "Next-Generation 737"}
	airbus := []string{"A380 Airspace", "A350-900", "A350-1000",
		"A330-900", "A330-800", "A330-200", "A330-300",
		"A220-100", "A220-300",
		"A321XLR", "A321neo", "A319ceo", "A320ceo", "A320neo", "A321ceo", "A319neo"}

	data := []Model{}
	for i := 0; i < len(boeing); i++ {
		temp := Model{
			BrandID:     1,
			ModelName:   boeing[i],
			Description: gofakeit.SentenceSimple(),
		}
		data = append(data, temp)
	}

	for i := 0; i < len(airbus); i++ {
		temp := Model{
			BrandID:     2,
			ModelName:   airbus[i],
			Description: gofakeit.SentenceSimple(),
		}
		data = append(data, temp)
	}
	db.Table("Airport.Model").Create(&data)
}

func TicketTypeData(db *gorm.DB) {
	opt := []string{"Economic", "Executive", "First Class"}

	data := []TicketType{}
	for i := 0; i < len(opt); i++ {
		temp := TicketType{
			TicketTypeName: opt[i],
			Description:    gofakeit.SentenceSimple(),
			FreeWeight:     gofakeit.Number(10, 25),
			Cost:           gofakeit.Number(10, 50) * (i + 1),
			Acronym:        opt[i][:3],
		}
		data = append(data, temp)
	}
	db.Table("Flight.TicketType").Create(&data)
}

func PersonData(db *gorm.DB) {
	for i := 0; i < 1000; i++ {
		temp := Person{
			FirstName:      gofakeit.FirstName(),
			LastName:       gofakeit.LastName(),
			AdmissionDate:  time.Now().AddDate(-gofakeit.Number(0, 5), -gofakeit.Number(0, 12), -gofakeit.Number(0, 28)),
			Nationality:    gofakeit.Number(1, 244),
			Gender:         gofakeit.RandomString([]string{"M", "F"}),
			Document:       gofakeit.SSN(),
			DocumentTypeID: gofakeit.Number(1, 3),
			PhoneNumber:    gofakeit.Phone(),
			DOB:            time.Now().AddDate(-gofakeit.Number(18, 70), -gofakeit.Number(0, 11), -gofakeit.Number(0, 28)),
			BloodType:      gofakeit.Number(1, 8),
			Direction:      gofakeit.Address().Address,
			Email:          gofakeit.Email(),
		}
		db.Table("Person.Person").Create(&temp)
	}
}

func AirportData(db *gorm.DB) {
	var destiny Destination
	db.Table("Flight.Destination").Where(&Destination{DestinationName: "Santo Domingo"}).First(&destiny)

	db.Table("Airport.Airport").Create(&Airport{
		AirportName:   "Home Airport",
		DestinationID: destiny.DestinationID,
		Direction:     gofakeit.Address().Address,
		AirportTypeID: gofakeit.Number(1, 6),
	})
	for i := 0; i < 100; i++ {
		temp := Airport{
			AirportName:   gofakeit.Company() + " Airport",
			DestinationID: gofakeit.Number(1, 244),
			Direction:     gofakeit.Address().Address,
			AirportTypeID: gofakeit.Number(1, 6),
		}
		db.Table("Airport.Airport").Create(&temp)
	}
}

func FlightData(db *gorm.DB) {
	var airports []Airport
	db.Table("Airport.Airport").Find(&airports)

	for i := 0; i < len(airports); i++ {
		temp := Flight{
			DestinationID:        airports[i].DestinationID,
			DestinationAirportID: airports[i].AirportID,
			TravelDistance:       gofakeit.Number(2000, 10000),
			FlightTypeID:         gofakeit.Number(1, 2),
		}
		temp.FlightCost = ((temp.TravelDistance / 903) * 5) / 2
		temp.TravelDuration = time.Date(0, 0, 0, gofakeit.Number(2, 19), gofakeit.Number(0, 60), 0, 0, time.UTC)
		db.Table("Flight.Flight").Create(&temp)
	}
}

func PlaneData(db *gorm.DB) {
	var airports []Airport
	db.Table("Airport.Airport").Find(&airports)
	for i := 0; i < 25; i++ {
		temp := Plane{
			ModelID:         gofakeit.Number(1, 23),
			SeatingCapacity: gofakeit.Number(200, 850),
			StatusPlaneID:   1,
			AdmissionDate:   time.Now().AddDate(-gofakeit.Number(0, 5), -gofakeit.Number(0, 12), -gofakeit.Number(0, 28)),
			// RetirementDate:        time.Time,
			BelongingAirport: 1,
		}
		temp.SeatingCapacityHigh = temp.SeatingCapacity / 10
		temp.SeatingCapacityLow = (temp.SeatingCapacity * 6) / 10
		temp.SeatingCapacityMedium = (temp.SeatingCapacity * 3) / 10
		db.Table("Airport.Plane").Create(&temp)
	}
}

func Employee_EmployeeRoleData(db *gorm.DB) {
	for i := 0; i < 100; i++ {
		temp := Employee_EmployeeRole{
			EmployeeID:     gofakeit.Number(1, 1000),
			EmployeeRoleID: gofakeit.Number(1, 15),
			StartDate:      time.Now().AddDate(-gofakeit.Number(0, 5), -gofakeit.Number(0, 12), -gofakeit.Number(0, 28)),
		}
		db.Table("Person.Employee_EmployeeRole").Create(&temp)
	}
}

func Employee_StatusEmployeeData(db *gorm.DB) {

	var employees []Employee_EmployeeRole
	db.Table("Person.Employee_EmployeeRole").Find(&employees)
	for i := 0; i < len(employees); i++ {
		temp := Employee_StatusEmployee{
			EmployeeID:       employees[i].EmployeeID,
			StatusEmployeeID: 1,
			StartDate:        employees[i].StartDate,
		}
		db.Table("Person.Employee_StatusEmployee").Create(&temp)
	}
}

func FlightBenefit_FlightTypeData(db *gorm.DB) {
	for i := 0; i < 30; i++ {
		temp := FlightBenefit_FlightType{
			FlightBenefitID: gofakeit.Number(1, 15),
			FlightTypeID:    gofakeit.Number(1, 2),
		}
		db.Table("Flight.FlightBenefit_FlightType").Create(&temp)
	}
}

func FlightScheduleData(db *gorm.DB) {
	var pilots []Employee_EmployeeRole
	db.Table("Person.Employee_EmployeeRole").Where(&Employee_EmployeeRole{EmployeeRoleID: 6}).Find(&pilots)
	var countFlights int64
	db.Table("Flight.Flight").Count(&countFlights)
	for i := 0; i < 100; i++ {
		flight := gofakeit.Number(1, int(countFlights-int64(1)))
		t := time.Now().AddDate(-gofakeit.Number(0, 5), -gofakeit.Number(0, 12), -gofakeit.Number(0, 30))
		num, min := gofakeit.Number(2, 19), gofakeit.Number(0, 60)

		temp := FlightSchedule{
			DepartureDate: t,
			PlaneID:       gofakeit.Number(1, 25),
			Pilot:         pilots[gofakeit.Number(0, len(pilots)-1)].EmployeeID,
			CoPilot:       pilots[gofakeit.Number(0, len(pilots)-1)].EmployeeID,
			FlightID:      flight,
		}
		for i := 0; i < num; i++ {
			t.Add(time.Hour)
		}
		for i := 0; i < min; i++ {
			t.Add(time.Minute)
		}
		temp.ArrivalDate = t
		db.Table("Flight.FlightSchedule").Create(&temp)
	}
}

func LuggageData(db *gorm.DB) {
	var flights []FlightSchedule
	db.Table("Flight.FlightSchedule").Find(&flights)

	var employees []Employee_EmployeeRole
	db.Table("Person.Employee_EmployeeRole").Find(&employees)
	var ids []int
	for _, v := range employees {
		ids = append(ids, v.EmployeeID)
	}

	// personas que no son empleados
	var persons []Person
	db.Table("Person.Person").Not(ids).Find(&persons)

	for i := 0; i < len(flights); i++ {
		for j := 0; j < 200; j++ {
			weight := gofakeit.Number(5, 25)
			lugga := Luggage{
				PersonID:         persons[gofakeit.Number(1, len(persons)-1)].PersonID,
				FlightScheduleID: flights[i].FlightID,
				Weight:           weight,
				Cost:             (weight * 5) / 2,
				LuggageTypeID:    gofakeit.Number(1, 2),
				LuggageStatusID:  gofakeit.Number(1, 4),
			}
			db.Table("Flight.Luggage").Create(&lugga)
		}
	}
}

func TicketData(db *gorm.DB) {
	var flights []FlightSchedule
	db.Table("Flight.FlightSchedule").Find(&flights)

	var employees []Employee_EmployeeRole
	db.Table("Person.Employee_EmployeeRole").Find(&employees)
	var ids []int
	for _, v := range employees {
		ids = append(ids, v.EmployeeID)
	}

	// personas que no son empleados
	var persons []Person
	db.Table("Person.Person").Not(ids).Find(&persons)

	opt := []string{"Economic", "Executive", "First Class"}
	for i := 0; i < len(flights); i++ {
		for j := 0; j < 150; j++ {
			rand := gofakeit.Number(1, 3)
			temp := Ticket{
				FlightID:         flights[i].FlightID,
				PersonID:         persons[gofakeit.Number(1, len(persons)-1)].PersonID,
				TicketTypeID:     rand,
				Cost:             (gofakeit.Number(10, 50) * 9) / 4,
				FlightScheduleID: flights[i].FlightScheduleID,
				SeatPlane:        fmt.Sprintf("%d%s%s", gofakeit.Number(1, 99), gofakeit.RandomString([]string{"A", "B", "C", "D", "E", "F"}), opt[rand-1][:3]),
			}

			db.Table("Flight.Ticket").Create(&temp)
		}
	}
}
