-- Procedure: Thu tuc (proc)
-- quy trinh tu dong xu ly du lieu (them,sua,xoa)
-- Tai su dung logic trong sql ma k can phai viet lai nhieu lan
SELECT * FROM Hourses
SELECT * FROM Contracts 
SELECT * FROM Owners
-- Cu phap 
-- CREATE OR ALTER PROCEDURE/PROC ten_proc(truyen vao cac tham so dau vao neu co)
-- AS 
-- BEGIN 
--     -- CODE 
--     if(dieu kien)
--         BEGIN 
--             -- CODE 
--         END
-- END
-- khoi lenh :{} => lui vao 1 tab: BEGIN END
-- if(a >0){
-- } 
-- Cach khai bao bien trong SQL: T-SQL 
-- int, float, DECIMAL(18,2), bit, ...: kieu du lieu  
-- bien luon luon bat dau bang @ 
-- DECLARE 
-- VD: DECLARE @name NVARCHAR(100)
DECLARE @number INT; 
DECLARE @number1 INT; 
-- Thay doi gia tri cua bien @number = 10
SET @number = 10 
SET @number1 = 5 
SELECT @number + @number1 -- luon luon ra 1 bang => Results
PRINT @number -- message
-- Tạo procedure hiển thị toàn bộ thông tin từ bảng Owners
GO
CREATE OR ALTER PROC PRO_GetAll_Owners 
AS 
BEGIN 
    SELECT * FROM Owners
END
GO
-- Goi pro 
-- EXECUTE/EXEC ten procedure 
EXECUTE PRO_GetAll_Owners
-- Tạo procedure tìm nhà theo Address (tham số truyền vào là địa chỉ).
GO 
CREATE OR ALTER PROC PRO_Search_Address(@diaChi NVARCHAR(100))
AS 
BEGIN 
    SELECT * FROM Hourses o
    WHERE o.Address LIKE '%'+ @diaChi + '%'
END
GO
EXECUTE PRO_Search_Address @diaChi = 'o'
-- Tao procedure them vao du lieu vao bang owners
GO
CREATE OR ALTER PROC pro_them1 
    (@FullName NVARCHAR(100), @Phone NVARCHAR(10), @Email NVARCHAR(120), @IsActive BIT)
AS
BEGIN
    INSERT INTO Owners 
    VALUES (@FullName, @Phone, @Email, @IsActive)
END
GO 
EXEC pro_them1 
    @FullName = 'Tran Thu Trang' ,
    @Phone = '0918734073',
    @Email = 'hihih55i@gmail.com',
    @IsActive = 1
SELECT * FROM Owners
-- Tao procedure hien thi so luong nha khi biet owerID
GO 
CREATE OR ALTER PROC PROC_COUNT_OID1 (@id INT)
AS
BEGIN
   -- SET NOCOUNT ON; -- tat thong bao dong bi anh huong boi cau len insert, update, delete, seleect
    SELECT h.OWNERID, COUNT(*) as 'So luong nha'
    FROM Hourses h
    WHERE h.OWNERID = @id
    GROUP BY h.OWNERID
END
EXEC PROC_COUNT_OID1 @id = 4
-- OWNER ID, So luong 
    -- 4      2
    -- 5       2
    -- 6       6 
-- FUNCTION 
-- RETURN 1 table, 1 kieu du... 
-- K CHUA INSERT, UPDATE, DELETE => DML 
-- Tạo procedure thêm một hợp đồng mới vào bảng Contracts.
SELECT * FROM Contracts
GO 
CREATE OR ALTER PROC PRO_ADD_Contracts 
    (@hourseID INT, @buyerName NVARCHAR(100), 
    @SignDate DATE, @TotalValue DECIMAL(18,2))
AS
BEGIN
    -- Validate 
    -- kiem tra rong hoac null
    IF(@hourseID is NULL OR @buyerName IS NULL OR @SignDate IS NULL
        OR LEN(@buyerName) = 0 OR @TotalValue IS NULL 
    )
    BEGIN 
        -- Xu ly loi: RAISEERROR : Ngoai le trong SQL 
        -- RAISERROR(mess loi, muc do nguy hiem cua loi, trang thai cua loi )
        -- Muc do nguy hiem - Severity: https://viblo.asia/p/phan-biet-severity-va-priority-trong-testing-jvElaPB4Zkw
            -- 0 -> 10: thong bao - thuong k gay ra loi 
            -- 11 -> 16: loi cua nguoi dung: trong, du lieu k hop le , loi vi pham khoa ngoai 
            -- 17 -> 19: loi cua he thong 
            -- 20-> 25: loi rat nghiem trong 
        -- Sate: trang thai loi do nguoi dung quy dinh
        RAISERROR('Dữ liệu không hợp lệ',16,1)
        RETURN;
    END
    -- Kiem tra su hop le cua khoa ngoai 
    IF NOT EXISTS (SELECT 1 FROM Hourses WHERE HousesID = @hourseID)
    BEGIN
        RAISERROR('Hourses ID không tồn tại',16,1)
        RETURN;
    END
    -- KIEM TRA TotalValue > - 
    IF (@TotalValue <=0)
    BEGIN 
         RAISERROR('Total Value phải là số nguyên dương',16,1)
        RETURN;
    END 
    -- Sau khi thoả mãn validate => insert
    INSERT INTO Contracts (HouseID,BuyerName,SignDate,TotalValue)
    VALUES 
    (@hourseID,@buyerName,@SignDate,@TotalValue)
END
EXEC PRO_ADD_Contracts @hourseID = 200 , @buyerName ='11', 
    @SignDate = '2024-02-02', @TotalValue =18.2