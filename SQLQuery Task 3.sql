-- 1.Create the database
CREATE DATABASE EventsManagement;
-- Create the Events table
CREATE TABLE Events (
    Event_Id INT PRIMARY KEY,
    Event_Name VARCHAR(100),
    Event_Date DATE,
    Event_Location VARCHAR(100),
    Event_Description TEXT
);

-- Create the Events table
CREATE TABLE Events (
    Event_Id INT PRIMARY KEY,
    Event_Name VARCHAR(100),
    Event_Date DATE,
    Event_Location VARCHAR(100),
    Event_Description TEXT
);
-- Create the Attendees table
CREATE TABLE Attendees (
    Attendee_Id INT PRIMARY KEY,
    Attendee_Name VARCHAR(100),
    Attendee_Phone VARCHAR(20),
    Attendee_Email VARCHAR(100),
    Attendee_City VARCHAR(50)
	);
-- Create the Registrations table
CREATE TABLE Registrations (
    Registration_Id INT PRIMARY KEY,
    Event_Id INT,
    Attendee_Id INT,
    Registration_Date DATE,
    Registration_Amount DECIMAL(10,2),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);
--2. Data Creation
-- Insert Sample data for event
INSERT INTO Events (Event_Id, Event_name, Event_Date, Event_Location, Event_Description)
VALUES
    ('1','Parenting and More', '2023-11-22', 'Chennai', 'A conference on the Types of parenting'),
    ('2', 'Vegan and healthy eating', '2023-12-01', 'Bangalore', 'Learn about eating healthy'),
    ('3', 'Dogs and cats maintainance', '2024-01-15', 'Mumbai', 'How to take care of pets');

-- Insert Sample data for attendee
INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('101','Stephie', '69435764836', 'stephie@example.com', 'Chennai'),
('102','Edwin', '568735495', 'Edwin@example.com', 'Bangalore'),
('103', 'Mark', '89785837654', 'Mark@example.com', 'Mumbai'),
('104', 'Jeni', '8795408097', 'Jeni@example.com', 'Chennai');

-- Sample data for Registrations
INSERT INTO Registrations (Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES ('1',1, 102, '2024-11-29', 500.00);

INSERT INTO Registrations (Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES ('2',2, 103, '2023-12-01', 600.00), ('3',3, 104, '2024-01-15', 700.00),
('4',1, 101, '2023-11-22', 800.00);

--Table containing all events information
Select * FROM Events

-- Table containing Attendee information
Select * FROM Attendees

--Table containing Registration information
Select * FROM Registrations

--3. Manage Event Details
--a)Inserting a new event
INSERT INTO Events (Event_Id, Event_name, Event_Date, Event_Location, Event_Description)
VALUES
    ('4','Prompt Engineering', '2024-11-28', 'Pune', 'Learn the basics of Prompt Engineering');
Select * FROM Events


--b)Updating an event's information
UPDATE Events
SET Event_Name = 'Updated Event Name',
    Event_Date = '2023-12-10',
    Event_Location = 'New Location',
    Event_Description = 'Updated Description'
WHERE Event_Id = 1;

--c) Deleting an event
Delete FROM Registrations where Event_Id in (1);
Delete FROM Events WHERE Event_ID in (1);
Select * from Events

--4) Manage Track Attendees & Handle Events
--a)Inserting a new attendee
INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('105','Seta', '832749872389', 'seta@example.com', 'Kerala');
Select * from Attendees

--b)Registering an attendee for an event.
INSERT INTO Registrations (Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES ('5',2, 105, '2023-12-01', 600.00);

Select a.Attendee_Name,r.*, e.Event_Name
from Registrations r
join Attendees a on a.Attendee_Id = r.Attendee_Id
join Events e on e.Event_Id = r.Event_Id

--5.Develop queries to retrieve event information, generate attendee lists, and calculate event attendance statistics
--Calculate Event Attendance Statistics:
--Count attendees for an event:
select * from Registrations
 
select e.Event_Id,e.Event_name,COUNT(distinct r.Attendee_Id)Num_of_Registrations from Events e 
 left join Registrations r on r.Event_Id = e.Event_Id group by e.Event_Id,Event_Name
 

select * from events

--Calculate total registration amount for an event:

select e.Event_Id,e.Event_name,
COUNT(distinct r.Attendee_Id)Num_of_Registrations,
sum(r.registration_amount)Tot_Registration_Amount 
from Events e 
left join Registrations r on r.Event_Id = e.Event_Id group by e.Event_Id,Event_Name
 

--Get average registration amount:

select e.Event_Id,e.Event_name,
COUNT(distinct r.Attendee_Id)Num_of_Registrations,
cast(sum(r.registration_amount) as INT)Tot_Registration_Amount, 
cast(AVG (r.registration_amount)as INT) As AVG_Registration_Amount
from Events e 
left join Registrations r on r.Event_Id = e.Event_Id group by e.Event_Id,Event_Name

--Get events by location:
SELECT * FROM Events WHERE Event_Location = 'Chennai';


-- Attendees Statistics based on City and Event
select e.Event_Id,e.Event_name,
COUNT(distinct r.Attendee_Id)Num_of_Registrations,
count(case when e.event_location = 'Chennai' then 1 else null end) as Attendee_City_Chennai,
count(case when e.event_location = 'Bangalore' then 1 else null end) as Attendee_City_Bangalore,
count(case when e.event_location = 'Mumbai' then 1 else null end) as Attendee_City_Mumbai
from Events e 
left join Registrations r on r.Event_Id = e.Event_Id 
group by e.Event_Id,Event_Name






