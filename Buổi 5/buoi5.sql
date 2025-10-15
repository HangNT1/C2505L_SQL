CREATE DATABASE HousingManagement

CREATE TABLE Owners(
    OwnerID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Phone VARCHAR(10) UNIQUE CHECK (Phone NOT LIKE '%[^0-9]%'),
    Email NVARCHAR(120) UNIQUE,
    IsActive BIT DEFAULT 1
)

CREATE TABLE Hourses (
    HousesID INT PRIMARY KEY IDENTITY (1,1),
    Address NVARCHAR (200) NOT NULL,
    Area INT NOT NULL CHECK (Area>0),
    Price DECIMAL (18,2) NOT NULL CHECK (Price>0),
    OwnerID INT NULL FOREIGN KEY REFERENCES Owners(OwnerID) ON DELETE SET NULL, 
)
GO 
-- truncate - data => reset id
-- delete - data => k reset id 
-- drop - xoa cau truc cua bang 
CREATE TABLE Contracts(
    ContractID INT PRIMARY KEY IDENTITY(1,1),
    HouseID INT NULL FOREIGN KEY REFERENCES Hourses(HousesID) ON DELETE CASCADE,
    BuyerName NVARCHAR(100) NOT NULL,
    SignDate DATE NOT NULL,
    TotalValue DECIMAL(18,2) NOT NULL CHECK (TotalValue>0),
)
GO
INSERT INTO Owners( fullname, Phone, Email, IsActive)
VALUES
('Nguyen van A', '093218424','nguyenvana4@gmail.com',1),
('Tran van B', '093548425','nguyenvanb5@gmail.com',0),
('Nguyen van C', '093218426','nguyenvanc6@gmail.com',0);
INSERT INTO Hourses (Address,Area,Price,OwnerID)
  VALUES 
  ('123 Le Loi, Q1, HCM', 80.5, 4500000000, 4),
  ('45 Tran Hung Dao, Q5, HCM', 60.0, 3200000000, 5),
  ('789 Nguyen Trai, Q10, HCM', 100.0, 5200000000, 6),
  ('12 Bach Dang, Binh Thanh, HCM', 70.0, 3800000000, 6),
  ('88 Hoang Van Thu, Phu Nhuan, HCM', 90.0, 4700000000, 6);
go
  INSERT INTO Contracts (HouseID,BuyerName,SignDate,TotalValue)
  VALUES 
  (4, 'Nguyen Thi Mai', '2025-01-15', 4500000000),
  (4, 'Le Van Khoa', '2025-03-02', 3200000000),
  (5, 'Tran Hoang Anh', '2025-05-20', 5200000000),
  (6, 'Pham Minh Chau', '2025-07-10', 3800000000),
  (6, 'Do Quoc Dat', '2025-09-25', 4700000000);
go
SELECT * FROM Owners
SELECT * FROM Hourses
SELECT * FROM Contracts
-- Hiển thị danh sách chủ nhà sở hữu của các chủ nhà có tên chứa chữ a
SELECT * 
FROM Owners
WHERE FullName LIKE '%a%'
-- Hiển thị danh sách chủ nhà sở hữu có id trong khoảng từ 3-10 và ở trạng thái active 
SELECT *
FROM Owners
WHERE OwnerID BETWEEN 3 And 10 
-- Hiển thị những hợp đồng thuê được mua bởi những người tên bắt đầu bằng chữ “B” 
-- và có tổng giá trị hợp đồng lớn hơn 100 
SELECT *
FROM Contracts
WHERE TotalValue > 100
AND BuyerName LIKE 'a%'

-- Hiển thị tất cả thông tin các căn nhà có giá thuê nằm trong khoảng từ 
-- 5 triệu đến 10 triệu.
SELECT *
FROM Hourses
WHERE price BETWEEN 5 and 10 ;

-- Liệt kê danh sách chủ nhà có tên chứa chữ “an” (không phân biệt hoa thường).
SELECT *
FROM Owners
--WHERE fullname LIKE '%an%' or fullname LIKE '%An%' or fullname LIKE '%aN%' or fullname LIKE '%AN%';
--WHERE LOWER (fullname) LIKE '%an%';
--Nguyen Thuy Hang - > nguyen thuy hang 
WHERE UPPER (fullname) LIKE '%AN%';
-- Hiển thị các hợp đồng thuê nhà được ký sau năm 2022.
SELECT*
FROM Contracts c
-- WHERE c.signdate >='2023-01-01'
WHERE YEAR(c.signdate) > 2022
-- 'yyyy-mm-dd' 
-- YEAR('20201-10-12') - 2021
-- MONTH('20201-10-12')- 10
-- DAY('20201-10-12') - 12
SELECT * 
FROM Houses h
WHERE h.Address LIKE N'%Quận 1%'
SELECT *
FROM Owners
WHERE OwnerID IN (1, 3, 5, 7)
SELECT *
FROM Contracts
WHERE TotalValue > 100000000 
ORDER BY TotalValue DESC

SELECT COUNT(*) AS N'Số lượng bản ghi trong Contracts'
FROM Contracts
-- Dem so luong hop dong theo tung nha 
SELECT * FROM Contracts
-- Hourse ID Count
-- 4  - 2 
-- 5 - 1 
-- 6 - 2
SELECT c.houseid, COUNT(*) AS N'Số lượng theo nhà'
FROM Contracts c
GROUP BY c.houseid
-- Thống kê số lượng căn nhà mà mỗi chủ nhà đang sở hữu (dùng bảng Nha).
-- Tính tổng giá trị các hợp đồng thuê của từng người thuê (dùng bảng HopDongThue).
SELECT BuyerName, SUM(TotalValue) 
FROM Contracts c
GROUP BY BuyerName
-- Tìm người thuê có số hợp đồng thuê lớn hơn hoặc bằng 2 (dùng bảng HopDongThue).
-- HAVING/WHERE: dieu kien 
-- WHERE: cot co san trong table
-- Having: cot tao them tu cac ham: min, max, avg, sum, count....
SELECT BuyerName, COUNT(*) 
FROM Contracts c
GROUP BY BuyerName
HAVING COUNT(*) >=2
-- Thống kê số lượng hợp đồng thuê theo từng năm 
-- (dựa trên NgayBatDau trong bảng HopDongThue).
SELECT YEAR(c.signdate) AS N'Năm', COUNT(*)AS 'SoHD'
FROM Contracts c 
GROUP BY YEAR(c.signdate)
ORDER BY YEAR(c.signdate) DESC
-- Year : bn nguoi thue 
-- 2022 - 1 
-- 2023 - 1 
-- 2024 - 2 
-- 2025 - 2
-- Tìm người thuê có tổng tiền thuê thấp nhất (bảng HopDongThue).
SELECT *
FROM Contracts c 
-- Buyer Name  | Tong min 
-- B1: Liet ke ra cau 2
SELECT TOP (2) BuyerName, SUM(TotalValue) 
FROM Contracts c
GROUP BY BuyerName
ORDER BY SUM(TotalValue) 
-- JOIN 
-- Hiển thị danh sách tên chủ nhà và địa chỉ từng căn nhà mà họ sở hữu.
SELECT *
FROM Contracts c 
SELECT *
FROM Owners c 
SELECT *
FROM Hourses c 
-- DS chu nha: Ower 
-- Dia chi - hourse 
-- OwerID, Full Name, Phong, Email, Address 
-- 4 Nguyen Van A 093218421	nguyenvana1@gmail.com 123 Le Loi, Q1, HCM
SELECT h.HOUsesID, h.Address, o.fullname, o.phone
FROM Owners o, Hourses h
WHERE o.OWNERID = h.OWNERID
-- Tên phim nào đã được khách hàng tên “Linh Pham” đặt?
-- Liet ke ten khac hang xem bo phim 'Inception'