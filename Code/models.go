package main

import (
	"time"

	"github.com/shopspring/decimal"
)

type Country struct {
	CountryID    int `gorm:"primarykey"`
	ISO2         string
	ISO3         string
	CurrencyName string
	Latitude     decimal.Decimal
	Longitude    decimal.Decimal
	CountryName  string
}

type StatusEmployee struct {
	StatusEmployeeID   int `gorm:"primarykey"`
	StatusEmployeeName string
	Description        string
}

type LuggageType struct {
	LuggageTypeID   int `gorm:"primarykey"`
	LuggageTypeName string
	Description     string
}

type StatusLuggage struct {
	StatusLuggageID   int `gorm:"primarykey"`
	StatusLuggageName string
	Description       string
}

type StatusPlane struct {
	StatusPlaneID   int `gorm:"primarykey"`
	StatusPlaneName string
	Description     string
}

type FlightType struct {
	FlightTypeID   int `gorm:"primarykey"`
	FlightTypeName string
	Description    string
}

type FlightBenefit struct {
	FlightBenefitID   int `gorm:"primarykey"`
	FlightBenefitName string
	Description       string
	Cost              uint
}

type BloodType struct {
	BloodTypeID   int `gorm:"primarykey"`
	BloodTypeName string
	Description   string
}

type EmployeeRole struct {
	EmployeeRoleID   int `gorm:"primarykey"`
	EmployeeRoleName string
	Description      string
}

type DocumentType struct {
	DocumentTypeID   int `gorm:"primarykey"`
	DocumentTypeName string
	Description      string
}

type Destination struct {
	DestinationID   int `gorm:"primarykey"`
	CountryID       int
	DestinationName string
	Acronym         string
	Latitude        decimal.Decimal
	Longitude       decimal.Decimal
}

type AirportType struct {
	AirportTypeID   int `gorm:"primarykey"`
	AirportTypeName string
	Description     string
}

type Brand struct {
	BrandID     int `gorm:"primarykey"`
	BrandName   string
	Description string
	Email       string
}

type Model struct {
	ModelID     int `gorm:"primarykey"`
	ModelName   string
	Description string
	BrandID     int
}

type TicketType struct {
	TicketTypeID   int `gorm:"primarykey"`
	TicketTypeName string
	Description    string
	Cost           int
	FreeWeight     int
	Acronym        string
}

type Person struct {
	PersonID       int `gorm:"primarykey"`
	FirstName      string
	LastName       string
	AdmissionDate  time.Time
	Nationality    int
	Gender         string
	Document       string
	DocumentTypeID int
	PhoneNumber    string
	DOB            time.Time
	BloodType      int
	Direction      string
	Email          string
}

type Airport struct {
	AirportID     int `gorm:"primarykey"`
	AirportName   string
	DestinationID int
	Direction     string
	AirportTypeID int
}

type Flight struct {
	FlightID             int `gorm:"primarykey"`
	DestinationID        int
	DestinationAirportID int
	TravelDistance       int
	FlightCost           int
	TravelDuration       time.Time
	FlightTypeID         int
}

type Plane struct {
	PlaneID               int `gorm:"primarykey"`
	ModelID               int
	SeatingCapacity       int
	StatusPlaneID         int
	AdmissionDate         time.Time
	RetirementDate        time.Time
	SeatingCapacityHigh   int
	SeatingCapacityMedium int
	SeatingCapacityLow    int
	BelongingAirport      int
}

type FlightSchedule struct {
	FlightScheduleID int `gorm:"primarykey"`
	DepartureDate    time.Time
	ArrivalDate      time.Time
	PlaneID          int
	Pilot            int
	CoPilot          int
	FlightID         int
}

type Luggage struct {
	LuggageID        int `gorm:"primarykey"`
	PersonID         int
	FlightScheduleID int
	Weight           int
	Cost             int
	LuggageTypeID    int
	LuggageStatusID  int
}

type Ticket struct {
	TicketID         int `gorm:"primarykey"`
	FlightID         int
	PersonID         int
	TicketTypeID     int
	Cost             int
	FlightScheduleID int
	SeatPlane        string
}

type FlightBenefit_FlightType struct {
	FlightBenefitID int
	FlightTypeID    int
}

type Employee_EmployeeRole struct {
	EmployeeID     int
	EmployeeRoleID int
	StartDate      time.Time
	EndDate        time.Time
	Description    string
}

type Employee_StatusEmployee struct {
	EmployeeID       int
	StatusEmployeeID int
	StartDate        time.Time
	EndDate          time.Time
	Description      string
}

type Index struct {
	Schema string
	Table  string
	Column string
}
