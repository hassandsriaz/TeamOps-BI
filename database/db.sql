DROP Table  burden_data;
DROP Table  dev_proj_rating;
DROP Table  developer_efficiency;
DROP Table  proj_rating;
DROP Table  weighted_data;

use  team_management_v2;

-- Create Developer table
CREATE TABLE Developer (
    DevID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Age INT CHECK (Age > 0)
);

-- Create Project table
CREATE TABLE Project (
    PID INT PRIMARY KEY,
    Type FLOAT CHECK (Type BETWEEN 0 AND 1), -- Assuming Type is a value between 0 and 1
    Rating INT CHECK (Rating BETWEEN 1 AND 10) -- Assuming Rating is a value between 1 and 10
);

-- Create Project_Summary table
CREATE TABLE Project_Summary (
    DevID INT,
    numProj INT CHECK (numProj >= 0),
    numHighend INT CHECK (numHighend >= 0),
    numLowend INT CHECK (numLowend >= 0),
    AvgDevRating FLOAT CHECK (AvgDevRating BETWEEN 0 AND 10), -- Assuming AvgDevRating is a value between 0 and 10
    Burden FLOAT CHECK (Burden >= 0),
    Efficiency FLOAT CHECK (Efficiency >= 0 AND Efficiency <= 1), -- Assuming Efficiency is a value between 0 and 1
    FOREIGN KEY (DevID) REFERENCES Developer(DevID)
);

-- Create Progress table
CREATE TABLE Progress (
    DevID INT,
    PID INT,
    Progress FLOAT CHECK (Progress >= 0 AND Progress <= 100), -- Assuming Progress is a percentage between 0 and 100
    Burden FLOAT CHECK (Burden >= 0),
    Efficiency FLOAT CHECK (Efficiency >= 0 AND Efficiency <= 1), -- Assuming Efficiency is a value between 0 and 1
    FOREIGN KEY (DevID) REFERENCES Developer(DevID),
    FOREIGN KEY (PID) REFERENCES Project(PID)
);
