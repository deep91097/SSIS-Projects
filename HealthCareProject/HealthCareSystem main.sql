-- A. Creating Database “HealthCareSystem” in SSMS - 
USE master;
GO
-- Create a database HeathCareSystem
CREATE DATABASE [HealthCareSystem]
-- Set the Containment Status of The Database none so no boundaries are defined or visible for a Database.
 CONTAINMENT = NONE
-- ON PRIMARY specifies the disk file used to store the data section of the database, data files are explicitly defined.
 ON PRIMARY 
(NAME = N'HealthCareSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\[HealthCareSystem].mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
-- LOG ON Specifies that the disk files used to store the database log, log files, are explicitly defined.

 LOG ON 
(NAME = N'HealthCareSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\[HealthCareSystem].ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
--NAME is logical name used in SQL Server when referencing a file.
--FILENAME refers to the path where the FILESTREAM data will be stored.
--SIZE defines the initial size of the file.
--MAXSIZE defines the maximum size a file can grow.
--FILEGROWTH specifies growth increment, the amount of space added to the file every time that new space is required.
GO

use [HealthCareSystem];
--nB. Creating Target Tables for Data Loading –
-- i.	Creating Target Group Table –

-- Creating Group table
--When ANSI_NULLS is ON, all comparisons (“=, <>”) against a null value evaluate to UNKNOWN.
SET ANSI_NULLS ON
GO

--When QUOTED_IDENTIFIER is ON then quotes are treated like brackets ([...]) and can be used to quote SQL object names like table names, column names, etc.
SET QUOTED_IDENTIFIER ON
GO
-- The ANSI_PADDING setting controls how trailing spaces are handled in columns with CHAR and VARCHAR data types, and trailing zeroes in columns with BINARY and VARBINARY data types. In other words, it specifies how the column stores the values shorter than the column defined size for that data types.
--When ANSI_PADDING is ON 
SET ANSI_PADDING ON
GO

CREATE TABLE Group_2121507(
	GRP_SK numeric(10) IDENTITY(1,1) NOT NULL,   -- Surrogate Key
	GROUP_ID VARCHAR(8), 
	GROUP_NAME VARCHAR(30) NOT NULL, 
	EFF_DT DATE NOT NULL, 
	TERM_DT DATE NOT NULL, 
	STREET VARCHAR(35), 
	CITY VARCHAR(15), 
	STATE VARCHAR(20), 
	ZIP numeric(5) NOT NULL, 
	CONSTRAINT [PK_Group_2122417] PRIMARY KEY CLUSTERED  --Primary Key Constraint
	([GROUP_ID] ASC) 
	WITH (  PAD_INDEX = OFF, 
		STATISTICS_NORECOMPUTE = OFF, 
		IGNORE_DUP_KEY = OFF, 
		ALLOW_ROW_LOCKS = ON, 
		ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY]
GO

--SET ANSI_PADDING OFF means the intermediate level pages are filled to near capacity leaving enough space for at least one row of the maximum size the index can have, considering the set of keys on the intermediate pages.
--When STATISTICS_NORECOMPUTE is OFF automatic statistics updating are enabled.
--GNORE_DUP_KEY OFF specifies the error response when an insert operation attempts to insert duplicate key values into a unique index.
-- ALLOW_ROW_LOCKS = ON, row locks are allowed when you access the index.
-- ALLOW_PAGE_LOCK = ON, page locks are allowed when you access the index.
GO

-- Creating Subgroup table
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

CREATE TABLE SUBGRP_2122417(
	SUBGRP_SK NUMERIC(10) IDENTITY(1,1) NOT NULL, 
	SUBGRP_ID VARCHAR(4),
	SUBGRP_NAME VARCHAR(30) NOT NULL, 
	EFF_DT DATE NOT NULL, 
	TERM_DT DATE NOT NULL, 
	GROUP_ID VARCHAR(8) FOREIGN KEY REFERENCES Group_2122417(GROUP_ID),
	CONSTRAINT [PK_SUBGRP_2122417] PRIMARY KEY CLUSTERED 
	([SUBGRP_ID] ASC) 
	WITH (  PAD_INDEX = OFF, 
		STATISTICS_NORECOMPUTE = OFF, 
		IGNORE_DUP_KEY = OFF, 
		ALLOW_ROW_LOCKS = ON, 
		ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

-- Creating Subscriber table
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

CREATE TABLE SUBSCRIBER_2122417(
	
	SUB_SK NUMERIC(10) IDENTITY(1,1) NOT NULL, 
	SUB_ID VARCHAR(9) , 
	LAST_NAME VARCHAR(30), 
	FIRST_NAME VARCHAR(30) NOT NULL ,
	GENDER VARCHAR(1) NOT NULL ,
	BIRTH_DT DATE NOT NULL ,

	SUBGRP_ID VARCHAR(4) FOREIGN KEY REFERENCES SUBGRP_2122417(SUBGRP_ID) , 
	GRP_ID VARCHAR(8) FOREIGN KEY REFERENCES Group_2122417(GROUP_ID),

	EFF_DT DATE NOT NULL ,
	TERM_DT DATE NOT NULL ,
	ELIG_IND VARCHAR(1) NOT NULL,
	CONSTRAINT [PK_SUBSCRIBER_2122417] PRIMARY KEY CLUSTERED 
	([SUB_ID] ASC) 
	WITH (  PAD_INDEX = OFF, 
		STATISTICS_NORECOMPUTE = OFF, 
		IGNORE_DUP_KEY = OFF, 
		ALLOW_ROW_LOCKS = ON, 
		ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO