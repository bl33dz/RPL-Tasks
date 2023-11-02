--
-- Database: `Traveloka`
--

START TRANSACTION;

-- Users

CREATE TABLE `Users` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Fullname` varchar(100) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `PhoneNumber` varchar(15) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `CreatedAt` date DEFAULT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `Users` (`UserID`, `Fullname`, `Username`, `Email`, `PhoneNumber`, `Password`, `CreatedAt`) VALUES
(1, 'John Doe', 'johndoe', 'johndoe@email.com', '123-456-7890', 'password1', '2023-11-01'),
(2, 'Jane Smith', 'janesmith', 'janesmith@email.com', '987-654-3210', 'password2', '2023-11-02'),
(3, 'Bob Johnson', 'bobjohnson', 'bobjohnson@email.com', '555-555-5555', 'password3', '2023-11-03');

-- AirlineTypes

CREATE TABLE `AirlineTypes` (
  `AirlineTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(100) NOT NULL,
  PRIMARY KEY (`AirlineTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `AirlineTypes` (`AirlineTypeID`, `TypeName`) VALUES
(1, 'Type 1'),
(2, 'Type 2'),
(3, 'Type 3');

-- HotelTypes

CREATE TABLE `HotelTypes` (
  `HotelTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(100) NOT NULL,
  PRIMARY KEY (`HotelTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `HotelTypes` (`HotelTypeID`, `TypeName`) VALUES
(1, 'Type X'),
(2, 'Type Y'),
(3, 'Type Z');

-- Cities

CREATE TABLE `Cities` (
  `CityID` int(11) NOT NULL AUTO_INCREMENT,
  `CityName` varchar(100) NOT NULL,
  PRIMARY KEY (`CityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `Cities` (`CityID`, `CityName`) VALUES
(1, 'Jakarta'),
(2, 'Surabaya'),
(3, 'Bali');

-- Flights

CREATE TABLE `Flights` (
  `FlightID` int(11) NOT NULL AUTO_INCREMENT,
  `AirlineTypeID` int(11) DEFAULT NULL,
  `DepartureCityID` int(11) DEFAULT NULL,
  `ArrivalCityID` int(11) DEFAULT NULL,
  `DepartureTime` datetime DEFAULT NULL,
  `ArrivalTime` datetime DEFAULT NULL,
  PRIMARY KEY (`FlightID`),
  FOREIGN KEY (`AirlineTypeID`) REFERENCES `AirlineTypes` (`AirlineTypeID`),
  FOREIGN KEY (`DepartureCityID`) REFERENCES `Cities` (`CityID`),
  FOREIGN KEY (`ArrivalCityID`) REFERENCES `Cities` (`CityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `Flights` (`FlightID`, `AirlineTypeID`, `DepartureCityID`, `ArrivalCityID`, `DepartureTime`, `ArrivalTime`) VALUES
(1, 1, 1, 2, '2023-11-01 08:00:00', '2023-11-01 10:00:00'),
(2, 2, 2, 3, '2023-11-02 09:00:00', '2023-11-02 11:00:00'),
(3, 3, 3, 1, '2023-11-03 10:00:00', '2023-11-03 12:00:00');

-- FlightBookings

CREATE TABLE `FlightBookings` (
  `BookingID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) DEFAULT NULL,
  `FlightID` int(11) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL,
  `BookingDate` date DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`),
  FOREIGN KEY (`FlightID`) REFERENCES `Flights` (`FlightID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `FlightBookings` (`BookingID`, `UserID`, `FlightID`, `Price`, `BookingDate`) VALUES
(1, 1, 1, 500, '2023-11-01'),
(2, 2, 2, 600, '2023-11-02'),
(3, 3, 3, 700, '2023-11-03');

-- Hotels

CREATE TABLE `Hotels` (
  `HotelID` int(11) NOT NULL AUTO_INCREMENT,
  `HotelName` varchar(100) NOT NULL,
  `HotelAddress` varchar(200) NOT NULL,
  `CityID` int(11) DEFAULT NULL,
  `HotelTypeID` int(11) DEFAULT NULL,
  PRIMARY KEY (`HotelID`),
  FOREIGN KEY (`CityID`) REFERENCES `Cities` (`CityID`),
  FOREIGN KEY (`HotelTypeID`) REFERENCES `HotelTypes` (`HotelTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `Hotels` (`HotelID`, `HotelName`, `HotelAddress`, `CityID`, `HotelTypeID`) VALUES
(1, 'Hotel A', '123 Main St, Jakarta', 1, 1),
(2, 'Hotel B', '456 Elm St, Surabaya', 2, 2),
(3, 'Hotel C', '789 Oak St, Bali', 3, 3);

-- HotelBookings

CREATE TABLE `HotelBookings` (
  `BookingID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) DEFAULT NULL,
  `HotelID` int(11) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL,
  `BookingDate` date DEFAULT NULL,
  `CheckInDate` date DEFAULT NULL,
  `CheckOutDate` date DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`),
  FOREIGN KEY (`HotelID`) REFERENCES `Hotels` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `HotelBookings` (`BookingID`, `UserID`, `HotelID`, `Price`, `BookingDate`, `CheckInDate`, `CheckOutDate`) VALUES
(1, 1, 1, 300, '2023-11-01', '2023-11-05', '2023-11-10'),
(2, 2, 2, 400, '2023-11-02', '2023-11-06', '2023-11-11'),
(3, 3, 3, 500, '2023-11-03', '2023-11-07', '2023-11-12');

COMMIT;
