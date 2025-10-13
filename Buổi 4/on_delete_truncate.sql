SELECT * FROM Customers
SELECT * FROM Books
SELECT * FROM Orders
INSERT INTO Orders(CID, BID,Quatity,OrderDate)
VALUES
    (1,8,5,'2020-10-10'),
    (1,9,11,'2022-10-20')
-- TRUNCATE: Xoá dữ liệu => reset ID về trạng thái ban đầu 
TRUNCATE TABLE Orders -- toan bo bang k the co dieu kien
-- DELETE: Xoá dữ liệu => id sẽ tiếp tục tự tăng từ vị trí cuối cùng 
DELETE FROM Orders
-- WHERE OrderID = 1
-- DROP: Xoá cấu trúc của bảng 
DROP TABLE Orders

-- Cac loai on delete: Cha & Con: Cha la bang k co khoa ngoai 
-- ON DELETE CASCADE: xoa cha => cha bien mat
-- Courses & Departments: cha: Departments, con Courses
-- Khi xoa ban ghi Courses co deptCode => Departments co deptCode bien mat 
-- ON DELETE SET NULL: Neu xoa cha => con se ve null 
-- Courses & Departments: cha: Departments, con Courses
-- Neu xoa Departments co deptCode = 1 => con Courses: deptCode = 1 => deptCode = null
-- ON DELETE SET DEFAULT: Neu xoa ch => con ve gia tri mac dinh 
-- ON DELETE NOAction: xoa duoc duoc khi cha ton tai trong con 
-- Courses & Departments: cha: Departments, con Courses
-- Courses co deptCode = 1 FK: Xoa cha Departments  deptCode = 1: k xoa dc 
