CREATE DATABASE CL2505 
GO 
USE CL2505
GO
CREATE TABLE GiangVien(
  MaGiangVien INT PRIMARY KEY IDENTITY(1,1),
  TenGiangVien NVARCHAR(50) NOT NULL,
  TenTaiKhoan VARCHAR(50) NOT NULL,
  SoDienThoai CHAR(12),
)
GO
CREATE TABLE MonHoc(
  MaMonHoc INT PRIMARY KEY IDENTITY(1,1),
  TenMonHoc NVARCHAR(20) NOT NULL,
  SoTinChi CHAR(20) NOT NULL,
  SoHocPhan CHAR(20) NOT NULL
)
GO 
CREATE TABLE PhanCongGiangVien(
  MaGiangVien INT NULL FOREIGN KEY REFERENCES GiangVien(MaGiangVien) ON DELETE CASCADE,
  MaMonHoc INT NULL FOREIGN KEY REFERENCES MonHoc(MaMonHoc) ON DELETE CASCADE,
  SoLanDay CHAR(20) NOT NULL,
  TiLeDo CHAR(20)
)
INSERT INTO GiangVien(TenGiangVien,TenTaiKhoan,SoDienThoai)
VALUES ('Nguyen Thuy Hang','hang123','0987354354'),
       ('Hoang Van Thu','thu456','0978354344'),
       ('Ngo Van Phuc','phucngo','0987324544')

INSERT INTO MonHoc(TenMonHoc,SoTinChi,SoHocPhan)
VALUES ('HTML','3','15'),
       ('CSS','4','18'),
       ('JavaScript','5','20')

INSERT INTO PhanCongGiangVien(MaGiangVien,MaMonHoc,SoLanDay,TiLeDo)
VALUES ('1','11','20','100%'),
       ('2','9','7','78%'),
       ('3','10','6','90%')
-- Tạo và sử dụng Khung nhìn có tên: V_GiangVien
-- Hiển thị thông tin gồm: Tên giảng viên, Tên Tài khoản, Email (= Tên tài khoản + “@fe.edu.vn”)
GO
CREATE OR ALTER VIEW V_GiangVien
AS 
-- SELECT gv.TenGiangVien, gv.TenTaiKhoan, gv.TenTaiKhoan+'@fe.edu.vn' as 'Email'
SELECT gv.TenGiangVien, gv.TenTaiKhoan, CONCAT(gv.TenTaiKhoan,'@fe.edu.vn') as 'Email'
FROM GiangVien gv
GO
SELECT * FROM V_GiangVien
-- Tạo và sử dụng Khung nhìn có tên: V_TopMonHoc
-- Hiển thị TOP 2 môn học có lượt dạy nhiều nhất.
SELECT * FROM GiangVien
SELECT * FROM MonHoc
SELECT * FROM PhanCongGiangVien
-- HTML : 12 
-- CSS: 21 
-- JS: 20
GO
CREATE OR ALTER VIEW V_TopMonHoc
AS 
    SELECT TOP (2) mh.MaMonHoc, mh.TenMonHoc, SUM(CAST(pc.SoLanDay AS INT)) as 'So lan day'
    FROM MonHoc mh INNER JOIN PhanCongGiangVien pc 
    ON mh.MaMonHoc = pc.MaMonHoc
    GROUP BY mh.MaMonHoc, mh.TenMonHoc
    ORDER BY SUM(CAST(pc.SoLanDay AS INT)) DESC
GO
SELECT * FROM V_TopMonHoc

