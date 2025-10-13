-- Tao tu/ kho chua do => database 
-- DDL : CREATE
-- Khi chay 1 phat se duoc thuc thi ngay lap tuc
CREATE DATABASE Bookstore1 
GO 
USE Bookstore1
GO 
-- Tao cac table/entity 
CREATE TABLE Customers (
	-- liet ke cac thuoc tinh 
	-- int a;
	-- tenbien kieu du lieu 
	CustomerID INT PRIMARY KEY IDENTITY(1,1), 
	FullName NVARCHAR(100) NOT NULL UNIQUE, 
	Phone VARCHAR(10) NOT NULL UNIQUE CHECK (Phone NOT LIKE '%[^0-9]%'),
	Email NVARCHAR(120) NULL,
	IsActive BIT NOT NULL DEFAULT 1
)
GO
-- Thieu truong => them 
ALTER TABLE Customers
ADD cccd1 VARCHAR(12) 
GO
-- Bo bot truong => drop 
ALTER TABLE Customers 
DROP COLUMN cccd1
GO 
CREATE TABLE Books (
	BookID INT PRIMARY KEY IDENTITY(1,1),
	Title NVARCHAR(150) NOT NULL UNIQUE,
	Author NVARCHAR(100) NOT NULL,
	Genre NVARCHAR(50) NOT NULL,
	Price DECIMAL(10,2) NOT NULL CHECK(Price > 0),
	Stock INT NOT NULL CHECK(Stock >=0)
)

GO
CREATE TABLE Orders(
	OrderID INT PRIMARY KEY IDENTITY(1,1),
	-- Khoa ngoai: Kieu du lieu phai trung nhau
	-- Trung trong bang noi 
	-- Ten k can trung nhau 
	-- C1: Viet khoa ngoai: Khai bao ngay truc tiep ben canh cot
	CID INT FOREIGN KEY REFERENCES Customers(CustomerID) ON DELETE NO ACTION,
	BID INT, 
	Quatity INT NOT NULL CHECK(Quatity >0),
	OrderDate DATE NOT NULL  DEFAULT GETDATE(),
	-- GETDATE(): Ham lay ra ngay hien tai 
	-- C2: Viet duoi dang 
	FOREIGN KEY(BID) REFERENCES Books(BookID) ON DELETE SET NULL
)

