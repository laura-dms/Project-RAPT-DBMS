use project_ratp_db;
/* Infos générales */

/*SELECT COUNT(*) AS "Number of stations on the line" FROM Station;
SELECT COUNT(*) AS "Total number of clients" FROM Client;
SELECT COUNT(*) AS "Total number of conductors" FROM Conductor;

/* Train infos */

/*SELECT ID_TRAIN FROM Train WHERE ID_Station = 006;

/* Infos Conducteurs */
SELECT Name_Conductor FROM Conductor where Name_Conductor like "Jean";
SELECT Name_Conductor, Surname_Conductor FROM Conductor, Planning_Conductor PC where PC.ID_Planning = 3;


/*Name_Conductor starting by letter B*/
SELECT Name_Conductor  as Name_B, Surname_Conductor from Conductor where Name_Conductor like 'B%';

/*Name_conductor, Surname_conductor where surname ordered by alphabetic order */
SELECT ID_Conductor, Name_Conductor, Surname_Conductor as Surname_ordered,Age_Conductor, Age_Experience from Conductor order by Surname_Conductor;

/*Name_Conductor, Surname_conductor group by Age_Conductor*/
SELECT Age_Experience, Name_Conductor, Surname_Conductor FROM Conductor C ORDER BY Age_Experience desc; /*10e*/
SELECT AVG(Age_Conductor) as "Average age of the trains conductor" FROM Conductor;
SELECT MAX(Age_Conductor) as "Oldest train conductor" FROM Conductor;
SELECT MIN(Age_Conductor) as "Youngest train conductor" FROM Conductor;
SELECT AVG(Age_Experience) as "Average age of experience of our conductors" FROM Conductor;

/*Infos conductors and Name Station conducting train ID_Train = 4789 and passing by station named 'Jussieu'*/
SELECT C.Name_Conductor, 
	C.Surname_Conductor, 
    S.Name_Station,
    C.ID_Train
FROM Conductor C
JOIN Train T on C.ID_Train=T.ID_Train
JOIN Station S on T.ID_Station=S.ID_Station
where T.ID_Train = 4789 and S.Name_Station='Jussieu';

/* Infos Clients */

SELECT COUNT(*) as "Number_od_Clients" FROM Client;
SELECT AVG(Age) as "Average age of clients" FROM Client;
SELECT COUNT(*) as "Number of clients living in Paris" FROM Client where City like "75___";
SELECT (SELECT COUNT(*) FROM CLient) - COUNT(*) as "Number of clients living outside Paris" FROM Client where City like "75___";
SELECT COUNT(*) FROM Client where Location_Departure_Client like "Quai de la Rappee";


/*Nb Clients */
SELECT COUNT(ID_Client) as "Number Client per station", Location_Departure_Client as Station FROM Client group by Location_Departure_Client;

/* Infos Planning_Conductor*/

/*Infos conductors working between 4 or 5 days per week with Working hours ordered in ascending order*/
SELECT C.Name_Conductor, 
	C.ID_Train, 
	PC.Nb_days_per_week_conductor,
    PC.ID_Planning,
    PC.Starting_Time_Conductor,
    PC.End_Time_Conductor
FROM Planning_Conductor PC
JOIN Conductor C on PC.ID_Planning = C.ID_Planning
ORDER BY PC.Starting_Time_Conductor;

/*Number hours worked by day per week for each conductor NOT WORKING*/
SELECT abs(TIMEDIFF(PC.End_Time_Conductor, PC.Starting_Time_Conductor))/10000 as Nb_hours_day, 
	abs((TIMEDIFF(PC.End_Time_Conductor, PC.Starting_Time_Conductor))/10000*PC.Nb_days_per_week_conductor) as Nb_hours_week, 
	C.Name_Conductor
FROM Planning_Conductor PC, Conductor C
WHERE PC.ID_Planning = C.ID_Planning;

/*Infos Subscription*/

/*Display names, surnames of clients grouped by type of Pass Navigo*/
SELECT Name_Client, 
	Surname_Client, 
    S.Type_Subscription,
	Age, 
	City
FROM Client C
JOIN Subscription S on C.ID_Subscription=S.ID_Subscription
ORDER BY Surname_Client asc;

/*Display Higher to Lowest price of subscription*/
SELECT DISTINCT Price_Subscription, Type_Subscription FROM Subscription ORDER BY Price_Subscription;

/*Clients who bought a subscription before 2000*/
SELECT C.Name_Client, 
    C.Surname_Client,
    S.Start_Date_Subscription
FROM Client C
JOIN Subscription S ON C.ID_Subscription = S.ID_Subscription
WHERE YEAR(S.Start_Date_Subscription) < 2010;

/*Infos Client who have the longest subscription*/
SELECT C.Name_Client, 
		C.Surname_Client,
        max(abs(DATEDIFF(S.End_Date_Subscription, S.Start_Date_Subscription))) as Longest_subscription
FROM Client C
JOIN Subscription S on C.ID_Subscription=S.ID_Subscription
GROUP BY S.ID_Subscription;

/*The last client to have buy a subscription*/
SELECT C.Name_Client, 
    C.Surname_Client,
	S.Start_Date_Subscription
FROM Client C
JOIN Subscription S ON C.ID_Subscription = S.ID_Subscription
ORDER BY S.Start_Date_Subscription desc
LIMIT 1;

/*The first client to have buy a subscription*/
SELECT C.Name_Client, 
    C.Surname_Client,
	S.Start_Date_Subscription
FROM Client C
JOIN Subscription S ON C.ID_Subscription = C.ID_Subscription
ORDER BY S.Start_Date_Subscription
LIMIT 1;

/* Clients with subscription ending in less that 1000 days */
SELECT Name_client, Surname_client, Start_Date_Subscription, End_Date_Subscription
FROM Client C
JOIN Subscription S ON C.ID_Subscription = S.ID_Subscription
WHERE End_Date_Subscription BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1000 DAY); /* we add a specific time interval */


/*Infos Stations*/

SELECT Name_Station, Nb_connexions_station FROM Station WHERE Nb_connexions_station >= 1;
SELECT Name_Station as "Number of stations in Paris" FROM Station WHERE City like "75___";

/* Trains passing by a given interval of time */

SELECT T.ID_TRAIN, T.Time_passage
FROM Train T
JOIN Conductor C ON T.ID_TRAIN = C.ID_TRAIN
WHERE T.Time_passage BETWEEN "16:10" AND "22:10"
ORDER BY Time_Passage;

/*Display Number of clients per stations*/
SELECT count(ID_Client) as Nb_clients_per_Station,
		S.Name_Station
FROM Client C, Station S
WHERE S.Name_Station = C.Location_Departure_Client
GROUP BY S.Name_Station;

/*Number of Stations per Type_Station ⬅️*/
SELECT count(distinct S.ID_Station) as Type_Station,
    case TS.Departure_arrival_Type
    when 0 then  'Normal'
    when 1 then 'Departure-Arrival'
    when 2 then 'Separation'
    end as Type_station
from Station S, Type_Station TS
group by TS.Departure_arrival_Type;