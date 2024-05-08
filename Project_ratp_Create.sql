use project_ratp_db;

CREATE TABLE Station(
   ID_Station INT NOT NULL,
   Name_station VARCHAR(50) NOT NULL,
   Nb_connexions_station INT,
   City VARCHAR(50),
   PRIMARY KEY(ID_Station)
);

CREATE TABLE Subscription(
   ID_Subscription INT,
   Type_Subscription VARCHAR(50),
   Start_Date_Subscription DATE,
   End_Date_Subscription DATE,
   Duration_subscription INT,
   Price_Subscription DECIMAL(15,2),
   PRIMARY KEY(ID_Subscription)
);

CREATE TABLE Type_station(
   ID_Type_station INT,
   /*ID_Station INT,*/
   Departure_arrival_type INT,
   PRIMARY KEY(ID_Type_station)
);

CREATE TABLE Planning_conductor(
   ID_Planning INT,
   Starting_Time_conductor TIME,
   End_Time_conductor TIME,
   Nb_days_per_week_conductor INT,
   PRIMARY KEY(ID_Planning)
);

CREATE TABLE Train(
   ID_TRAIN INT,
   Nb_Wagons INT,
   Name_Conductor VARCHAR(50),
   Time_passage TIME,
   ID_Station INT NOT NULL,
   PRIMARY KEY(ID_TRAIN),
   FOREIGN KEY(ID_Station) REFERENCES Station(ID_Station)
);

CREATE TABLE Client(
   ID_CLIENT INT,
   Name_client VARCHAR(50),
   Surname_client VARCHAR(50),
   Age INT,
   City VARCHAR(50),
   Location_Departure_Client VARCHAR(50),
   Location_Arrival_Client VARCHAR(50),
   ID_Station INT,
   ID_Subscription INT NOT NULL,
   PRIMARY KEY(ID_CLIENT),
   FOREIGN KEY(ID_Station) REFERENCES Station(ID_Station),
   FOREIGN KEY(ID_Subscription) REFERENCES Subscription(ID_Subscription)
);

CREATE TABLE Conductor(
   ID_Conductor INT,
   Name_conductor VARCHAR(50) NOT NULL,
   Surname_conductor VARCHAR(50) NOT NULL,
   Age_conductor INT,
   Age_Experience INT,
   ID_Planning INT NOT NULL,
   ID_TRAIN INT NOT NULL,
   PRIMARY KEY(ID_Conductor),
   FOREIGN KEY(ID_Planning) REFERENCES Planning_conductor(ID_Planning),
   FOREIGN KEY(ID_TRAIN) REFERENCES Train(ID_TRAIN)
);

CREATE TABLE IS_OF_TYPE(
   ID_Station INT,
   ID_Type_station INT,
   PRIMARY KEY(ID_Station, ID_Type_station),
   FOREIGN KEY(ID_Station) REFERENCES Station(ID_Station),
   FOREIGN KEY(ID_Type_station) REFERENCES Type_station(ID_Type_station)
);

/*f*/
