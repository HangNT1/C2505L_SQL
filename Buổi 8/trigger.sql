-- RAISERROR(message,muc do loi, state)
-- -- 0 -> 10: warning 
-- -- 11->16: user: validate: du lieu dau vao k hop le, FK k co 
-- -- 17-> 19: loi cua he thong 
-- -- 20->25: sap server
-- -- state: trang thai do nguoi dung quy dinh 
-- Trigger: 1 loai procedure dac biet trong SQL 
-- Thuong se tu dong thuc thi 1 su kien gi do (insert, update,delete) dien ra 
-- trong 1 bang hoac 1 view. 
-- trigger: thuc thi ngay lap tuc: viet xong cau lenh trigger 
-- procedure: goi moi thuc thi: exc..  
-- Cu phap: 
-- INSTEAD of & AFTER/FOR  
-- CREATE OR ALTER TRIGGER trigger_name 
-- ON table_name/view_name 
-- AFTER/FOR(giong nhau)/INSTEAD OF | (SK): INSERT/DELETE/UPDATE 
-- AS 
-- BEGIN 
-- CODE
-- END
-- Phan biet AFTER/FOR(giong nhau)/INSTEAD OF:
-- AFTER/FOR: Sau khi hanh dong sự kiện(DML): insert, update, delete 
        -- Kiem tra du lieu sau hanh dong them,sua,xoa 
-- INSTEAD OF: Chay thay cho hanh dong sự kiện gốc
-- Xoa những bản ghi không có khoá ngoại 
-- kiểm tra 
-- insead of delete 
-- BEGIN 
--     - Thay vi viec xoa, toi kiem tra truoc -- trươc 
-- END
-- SỰ kiện(thêm/sửa/xoá)
    -- AFTER: SAu khi sự kiện đã diễn ra 
    -- INSTEAD OF: Kiểm tra trước khi sự kiện diễn ra
-- inserted & deleted 
-- INSERT:  inserted => ban ghi moi them trong trigger
-- UPDATE: trươc khi update(inserted) & sau khi update thành công (deleted)
-- DELETE:  deleted => ban ghi vua xoa trong trigger 
-- inserted: bản ghi trước khi được update hoặc bản ghi sau khi được thêm 
-- deleted: bản ghi sau khi được update hoặc bản ghi sau khi bị xoá 
-- Tạo trigger kiểm tra khi thêm nhà mới thì giá (Price) phải lớn hơn 0.
INSERT INTO Hourses(Address,Area,Price,OwnerID)
VALUES ('a',10,2,4)
SELECT * FROM Hourses
GO
CREATE OR ALTER TRIGGER trig_check_price ON Hourses 
AFTER INSERT 
AS 
IF(SELECT price FROM inserted) < 10 
BEGIN 
    RAISERROR('Giá phải là số lớn hơn 10',16,1)
    ROLLBACK TRAN -- quay ve trang thai chua insert 
END
-- Tạo trigger kiểm tra khi thêm bản ghi vào bảng Owners 
-- thì số điện thoại không được chứa ký tự chữ. [^0-9]

go
CREATE OR ALTER TRIGGER trig_check_Sdt ON  Owners
AFTER INSERT 
AS 
IF(SELECT Phone FROM inserted ) LIKE '[^0-9]'
BEGIN 
    RAISERROR('Khong duoc nhap chu',16,1)
    ROLLBACK TRAN -- quay ve trang thai chua insert 
END
-- Tạo trigger ngăn không cho xóa một chủ nhà (Owner) 
-- nếu vẫn còn căn nhà thuộc sở hữu của họ.
go
CREATE OR ALTER TRIGGER trig_check_DELETE ON  Owners
INSTEAD OF DELETE 
AS 
IF EXISTS(SELECT * FROM Hourses h JOIN 
    deleted d ON h.OWNERID = d.OWNERID 
)
BEGIN 
   -- KHONG DUOC XOA 
    RAISERROR('Khong duoc XOA',16,1)
    ROLLBACK TRAN -- quay ve trang thai chua insert 
END
ELSE 
 -- XOA 
    DELETE FROM Owners WHERE OwnerID IN (SELECT OwnerID FROM deleted)

-- Tạo trigger kiểm tra khi thêm hợp đồng (Contract) thì HouseID phải 
-- tồn tại trong bảng Houses.

-- Tạo trigger kiểm tra khi thêm hợp đồng thì TotalValue không nhỏ hơn giá trị Price của căn nhà.

-- Tạo trigger tự động chuyển trạng thái House thành 'Sold' khi có hợp đồng được thêm.

-- Tạo trigger kiểm tra khi cập nhật giá nhà (Price) thì không được giảm quá 50% 
-- so với giá cũ.

-- Tạo trigger ngăn không cho thêm hợp đồng nếu ngày ký (SignDate) trước năm 2020.

-- Tạo trigger kiểm tra nếu người mua (BuyerName) trong hợp đồng có độ dài dưới 
-- 5 ký tự thì không cho thêm.

