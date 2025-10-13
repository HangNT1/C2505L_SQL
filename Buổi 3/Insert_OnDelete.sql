USE Bookstore1

INSERT INTO Customers(Phone,email,Fullname,isActive)
VALUES
-- Thu tu duoi phan value se phu thuoc vao thu tu minh khai bao thuoc tinh trong bang 
    -- (N'Nguyễn Văn A', '0124444444','a@gmail.com',1)
    ('0124444444','a@gmail.com',N'Nguyễn Văn A1',1)

INSERT INTO Books(Title,Author,Genre,Price,Stock) 
VALUES
    ('AAA','NGUYEN VAN A','SSA',10,9),
    ('AAB','NGUYEN VAN B','SSD',1,19),
    ('AAV','NGUYEN VAN C','SSF',11,39),
    ('AAF','NGUYEN VAN D','SSU',16,29);

-- KIEM TRA DU LIEU
SELECT * FROM Customers
SELECT * FROM Books
SELECT * FROM Orders
INSERT INTO Orders(CID, BID,Quatity,OrderDate)
VALUES
    (14,10,5,'2020-10-10'),
    (1,9,11,'2022-10-20'),
    (2,4,10,'2014-10-10'),
    (3,8,9,'2029-10-10'),
    (12,3,8,'2017-10-20');

TRUNCATE TABLE Orders
DELETE FROM Orders
WHERE OrderID = 1
-- TRUNCATE => Xoa du lieu => reset  id ve ban dau
-- DELETE => Xoa du lieu => id se tiep tu tang tu vi tri cuoi cung 
-- Them/Tao(insert/create) - tu bang k co khoa ngoai 
-- Xoa - Xoa tu bang co ngoai 
-- DROP - Xoa tu bang co ngoai 

-- Cac loai on delete 
-- ON DELETE cascade: Xoa cha => cha bien mat 
-- ON DELETE set null: Neu xoa cha => con set ve null
-- ON DELETE set default: Neu xoa cha => xet ve gia tri mac dinh 
-- On DELETE NoAction : mac dinh
-- CHa: Book & Customer
-- Con: Order  
