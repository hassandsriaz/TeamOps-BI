CREATE DATABASE Team_Management;

USE Team_Management;

SHOW TABLES;

DROP TABLE IF EXISTS developer;
DROP TABLE IF EXISTS developer;
DROP TABLE IF EXISTS Burden;
DROP TABLE IF EXISTS developer_projects;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS project_detail;
DROP TABLE IF EXISTS progress;


select * from developer

-- Create Developer Table
CREATE TABLE developer (
    DevID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Age INT
);

-- Create Burden Table
CREATE TABLE Burden (
    DevID INT,
    Burden FLOAT,
    FOREIGN KEY (DevID) REFERENCES Developer(DevID)
);

-- Create Project_Detail Table
CREATE TABLE Developer_projects (
    DevID INT,
    numProj INT,
    numHighend INT,
    numLowend INT,
    AvgDevRating FLOAT,
    FOREIGN KEY (DevID) REFERENCES Developer(DevID)
);

-- Create PID Table
CREATE TABLE Project (
    PID INT PRIMARY KEY,
    Type FLOAT,
    Rating INT
);


-- Create Progress Table
CREATE TABLE Progress (
    DevID INT,
    PID INT,
    Progress FLOAT,
    FOREIGN KEY (DevID) REFERENCES Developer(DevID),
    FOREIGN KEY (PID) REFERENCES Project(PID)
);

SHOW TABLES;



