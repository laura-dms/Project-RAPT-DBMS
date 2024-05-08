use project_ratp_db;

ALTER TABLE Train
ADD CONSTRAINT ck_ID_TRAIN CHECK (ID_TRAIN BETWEEN 0000 and 9999),
ADD CONSTRAINT ck_Time_Passage CHECK (Time_Passage BETWEEN "00:00:00" and "23:59:59"),
ADD CONSTRAINT ck_Nb_Wagons CHECK (Nb_Wagons BETWEEN 5 and 20);

ALTER TABLE Conductor
ADD CONSTRAINT ck_ID_Conductor CHECK (ID_Conductor BETWEEN 00000 and 99999),
ADD CONSTRAINT ck_Age_Experience CHECK (Age_Experience BETWEEN 0 and Age_Conductor - 21),
ADD CONSTRAINT ck_ID_Planning CHECK (ID_Planning BETWEEN 00 AND 10);

ALTER TABLE Subscription
ADD CONSTRAINT ck_ID_Subscription CHECK (ID_Subscription BETWEEN 00000 and 99999),
ADD CONSTRAINT ck_Type_Subscription CHECK (Type_Subscription BETWEEN 00 and 10),
ADD CONSTRAINT ck_Start_Date_Subscription CHECK (Start_Date_Subscription BETWEEN "2000-01-01" and  End_Date_Subscription);

ALTER TABLE Client
ADD CONSTRAINT ck_ID_CLIENT CHECK (ID_CLIENT BETWEEN 000000 and 999999);

ALTER TABLE Station
ADD CONSTRAINT ck_ID_Station CHECK (ID_Station BETWEEN 000 and 038),
ADD CONSTRAINT ck_Nb_connexions_station CHECK (Nb_connexions_station BETWEEN 0 and 7);

ALTER TABLE Planning_Conductor
ADD CONSTRAINT ck_Starting_Time_conductor CHECK (Starting_Time_conductor BETWEEN "07:00:00" and "18:00:00"),
ADD CONSTRAINT ck_Ending_Time_conductor CHECK (End_Time_conductor BETWEEN "00:15:00" and "22:00:00"),
ADD CONSTRAINT ck_Nb_days_per_week_conductor CHECK (Nb_days_per_week_conductor BETWEEN 3 and 6);




