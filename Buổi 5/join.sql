-- Xóa và tạo mới CSDL (nếu đã tồn tại)
IF DB_ID('MovieRentalDB') IS NOT NULL
BEGIN
    ALTER DATABASE MovieRentalDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE MovieRentalDB;
END;
GO
CREATE DATABASE MovieRentalDB;
GO
USE MovieRentalDB;
GO

-- Bảng Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Phone VARCHAR(15) UNIQUE CHECK (Phone NOT LIKE '%[^0-9]%'),
    Email NVARCHAR(120) UNIQUE,
    City NVARCHAR(100)
);

-- Bảng Movies
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(150) NOT NULL,
    Genre NVARCHAR(50) NOT NULL,
    Stock INT NOT NULL CHECK (Stock >= 0),
    RentalPrice DECIMAL(10,2) NOT NULL CHECK (RentalPrice > 0)
);

-- Bảng Rentals
CREATE TABLE Rentals (
    RentalID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    MovieID INT NOT NULL,
    Qty INT NOT NULL CHECK (Qty > 0),
    RentalDate DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Rentals_Customers FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    CONSTRAINT FK_Rentals_Movies FOREIGN KEY (MovieID)
        REFERENCES Movies(MovieID) ON DELETE CASCADE
);
-- Customers
INSERT INTO Customers (FullName, Phone, Email, City)
VALUES
(N'Nguyễn Văn An', '0909123456', 'an.nguyen@gmail.com', N'Hà Nội'),
(N'Trần Thị Bình', '0912345678', 'binh.tran@yahoo.com', N'Hồ Chí Minh'),
(N'Lê Hoàng Nam',  '0939876543', 'nam.le@gmail.com', N'Đà Nẵng'),
(N'Phạm Minh Châu','0988777666', 'chau.pham@outlook.com', N'Huế'),
(N'Vũ Đức Tài',    '0977888999', 'tai.vu@gmail.com', N'Hải Phòng');

-- Movies
INSERT INTO Movies (Title, Genre, Stock, RentalPrice)
VALUES
(N'Avengers: Endgame', N'Action', 10, 35.00),
(N'Frozen II',          N'Animation', 15, 25.00),
(N'The Conjuring',      N'Horror', 8, 30.00),
(N'Parasite',           N'Drama', 12, 28.00),
(N'Fast & Furious 9',   N'Action', 5, 40.00);

-- Rentals
INSERT INTO Rentals (CustomerID, MovieID, Qty, RentalDate)
VALUES
(1, 1, 2, '2024-01-05'),
(2, 2, 1, '2024-02-10'),
(3, 3, 1, '2024-02-20'),
(1, 4, 3, '2024-03-15'),
(4, 5, 1, '2024-04-10'),
(5, 1, 2, '2024-05-05'),
(2, 3, 1, '2024-06-10');
-- Ai đã đặt phim có tên là “Inception”?
SELECT c.fullname
FROM Movies m,Rentals r, Customers c 
WHERE m.MovieID = r.MovieID 
AND c.CustomerID = r.CustomerID
AND m.title = 'Inception'
-- Tên phim nào đã được khách hàng tên “Linh Pham” đặt?
SELECT m.title
FROM Movies m 
JOIN Rentals r
ON m.MovieID = r.MovieID 
JOIN Customers c
ON c.CustomerID = r.CustomerID
WHERE c.fullname = 'Linh Pham'