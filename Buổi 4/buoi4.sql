CREATE DATABASE UniTeaching1
GO
USE UniTeaching1
GO
CREATE TABLE Departments (
    DeptCode VARCHAR(10) PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL UNIQUE,
)

CREATE TABLE Lecturers (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(120),
    Phone VARCHAR(10) UNIQUE, CHECK (Phone NOT LIKE '%[^0-9]%'),
    Email NVARCHAR(120) UNIQUE,
    AcademicRank NVARCHAR(30) NOT NULL CHECK (AcademicRank IN (N'Assistant', N'Associate',N'Professor',N'Lecturer')),
    DeptCode VARCHAR(10) NULL, 
    isActive BIT DEFAULT 1,
    FOREIGN KEY (DeptCode) REFERENCES Departments(DeptCode) ON DELETE SET NULL
)

CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    Code VARCHAR(20) NOT NULL UNIQUE,
    Title NVARCHAR(150) NOT NULL,
    Credits INT NOT NULL CHECK (Credits > 0),
    DeptCode VARCHAR(10) NOT NULL,
    FOREIGN KEY (DeptCode) REFERENCES Departments(DeptCode) ON DELETE NO ACTION
)

CREATE TABLE Classes(
    ClassID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT NOT NULL FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE,
    Semester VARCHAR(10) NOT NULL,
    SectionNo INT NOT NULL CHECK( SectionNo > 0),
    Room NVARCHAR(20) NULL,
    Capacity INT NOT NULL CHECK(Capacity > = 0)
)

CREATE TABLE TeachingAssignments(
    TeachingAssignmentID INT IDENTITY(1,1) PRIMARY KEY,
    ClassID INT NOT NULL FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    LecturerID INT NOT NULL FOREIGN KEY (LecturerID) REFERENCES Lecturers(ID),
    Hours INT NOT NULL CHECK(Hours > 0) 
)
INSERT INTO Departments (DeptCode, Name) VALUES
('FIT', N'Công nghệ thông tin'),
('FBA', N'Kinh doanh');
INSERT INTO Lecturers (FullName, Phone, Email, AcademicRank, DeptCode, IsActive) VALUES
(N'Nguyễn Văn A', '0912345670', 'a1@uni.edu', N'Lecturer', 'FIT', 0),
(N'Trần Thị B', '0909999999', 'b@uni.edu', N'Assistant', 'FIT', 1),
(N'Lê Minh C', NULL, 'c@uni.edu', N'Associate', 'FBA', 1);
INSERT INTO Courses (Code, Title, Credits, DeptCode) VALUES
('DBI221', N'Cơ sở dữ liệu1', 1, 'FIT'),
('PRJ301', N'Web Java', 3, 'FIT'),
('MKT101', N'Nguyên lý Marketing', 3, 'FBA');
INSERT INTO Classes (CourseID, Semester, SectionNo, Room, Capacity) VALUES
(1, '2025A', 1, N'A101', 40),
(2, '2025A', 1, N'A102', 35);
INSERT INTO TeachingAssignments (ClassID, LecturerID, Hours) VALUES
(1, 1, 45),
(2, 2, 45);

SELECT * FROM Departments
SELECT * FROM Lecturers
SELECT * FROM Courses
SELECT * FROM Classes
SELECT * FROM TeachingAssignments
-- CREATE, DROP, ALTER, UPDATE - 1 lan 
-- INSERT, SELECT, DELETE... - nhieu lan 
-- DROP, DELETE, TRUNCATE 
-- TRUNCATE: Xoá dữ liệu => reset ID về trạng thái ban đầu 
-- DELETE: Xoá dữ liệu => id sẽ tiếp tục tự tăng từ vị trí cuối cùng 
-- DROP: Xoá cấu trúc của bảng 
-- Phần A – SELECT cơ bản
-- Truy vấn tất cả cột từ bảng Courses.
SELECT * FROM Courses
-- Truy vấn các cột Code, Title, Credits từ bảng Courses (đặt bí danh cột theo ý bạn).
SELECT c.Code,c.Title, c.Credits AS N'Chứng chỉ'
FROM Courses c
-- Truy vấn các cột FullName, Email, AcademicRank từ bảng Lecturers.
SELECT l.FullName,l.Email,l.AcademicRank
FROM Lecturers l
-- Truy vấn các cột DeptCode, Name từ bảng Departments.
SELECT d.DeptCode, d.Name
FROM Departments d 
-- Truy vấn các cột ID, CourseID, Semester, SectionNo, Room, Capacity từ bảng Classes.
SELECT c.ClassID, c.CourseID, c.Semester, c.SectionNo, c.Room, c.Capacity 
FROM Classes c
-- Phần B – SELECT có điều kiện (WHERE, LIKE, BETWEEN, IN/NOT IN, IS NULL, toán tử)
-- Truy vấn các dòng trong bảng Courses 
-- với điều kiện so sánh đơn giản trên Credits (ví dụ bằng/khác).
-- SELECT * FROM Courses
SELECT *
FROM Courses c
WHERE c.Credits <> 3
-- Toan tu trong SQL: 
-- bang: = 
-- khac: != hoac <> 
-- >,<, >=,<= 
-- Truy vấn các dòng trong bảng Lecturers với điều kiện trạng thái IsActive.
SELECT *
FROM Lecturers l
WHERE l.isActive = 1
-- Truy vấn các cột FullName, Email từ bảng Lecturers 
-- với điều kiện FullName chứa một từ khóa (dùng LIKE).
SELECT l.fullname, l.email
FROM Lecturers l
WHERE l.fullname LIKE  '%a%'
-- LIKE 
-- ten cot LIKE 'gia tri%': bat dau bang gia tri gi day 
--  ten cot LIKE '%gia tri': ket thuc bang gia tri gi day 
--  ten cot LIKE '%gia tri%': chua gia tri gi day  
-- Hien thi danh sach lectures cua giang vien co ten la 'Nam' => =: LIKE 'Nam'
-- Hien thi danh sach lectures cua giang vien co ten ket thuc 'Nam' => LIKE '%Nam'
-- Hien thi danh sach lectures cua giang vien co ten bat dau 'Nam' => LIKE 'Nam%'
-- Hien thi danh sach lectures cua giang vien co ten chua 'a' => LIKE '%a%'
-- Truy vấn bảng Courses với điều kiện Code bắt đầu bằng một tiền tố (dùng LIKE).
-- Truy vấn bảng Courses với điều kiện Credits nằm trong một khoảng (dùng BETWEEN).
-- liet ke credit : 2-5: 2 <= x <=5
SELECT * 
FROM Courses c
WHERE c.Credits >= 2 AND c.Credits <=5
-- C2
SELECT * 
FROM Courses c
WHERE c.Credits BETWEEN 2 AND 5
-- Truy vấn bảng Courses với điều kiện Code không khớp một mẫu cho trước (dùng NOT LIKE).
-- Hien thi danh sach courses vs nhung code k ket thuc bang 221
SELECT * 
FROM Courses c 
WHERE c.code NOT LIKE '%221'
-- Truy vấn bảng Courses với điều kiện DeptCode thuộc một tập giá trị (dùng IN).
-- - FBA, FSB,
SELECT * 
FROM Courses c  
WHERE c.DeptCode IN ('FBA','FSB')
-- Truy vấn bảng Lecturers với điều kiện DeptCode không thuộc một tập giá trị (dùng NOT IN; tự xử lý trường hợp NULL nếu có).
-- Truy vấn bảng Lecturers để lọc Phone là NULL hoặc Email không phải NULL (dùng IS NULL / IS NOT NULL).
-- Truy vấn bảng Classes với điều kiện Semester khớp mẫu một niên học/học kỳ cụ thể (dùng LIKE với ký tự đại diện).
-- Phần C – Subquery trong điều kiện (IN / NOT IN / EXISTS / NOT EXISTS)
-- Truy vấn các khoá học chưa từng mở lớp.
-- lay ra courses ma courseid k co trong classes 
SELECT * 
FROM Courses 
WHERE CourseID NOT IN (
    SELECT CourseID
    FROM Classes
)
SELECT * FROM Classes
-- Truy vấn các giảng viên trong bảng Lecturers đã có phân công giảng dạy: 
-- dùng EXISTS (subquery) kiểm tra bản ghi liên quan trong 
-- bảng TeachingAssignments theo LecturerID.

-- Truy vấn các giảng viên trong bảng Lecturers chưa có phân công: 
-- dùng NOT EXISTS (subquery) với bảng TeachingAssignments.

-- Phần D – TOP & ORDER BY (xếp cuối)
-- Truy vấn TOP (N) học phần từ bảng Courses và sắp xếp 
-- giảm dần theo một cột số phù hợp (ví dụ ID).
SELECT  *
FROM Courses 
ORDER BY CourseID DESC -- LUON LUON O VI TRI CUOI CUNG CUA CAU TRUY VAN 
-- Truy vấn TOP (PERCENT) các học phần từ bảng Courses với 
-- một điều kiện tự chọn, sau đó sắp xếp theo nhiều cột 
-- (ví dụ Credits giảm dần, rồi Title tăng dần).
SELECT * 
FROM COURSES 
WHERE FULLNAME LIKE '%A%'
AND CourseID IN (
    SELECT CourseID FROM Classes
)
ORDER BY CourseID DESC 


