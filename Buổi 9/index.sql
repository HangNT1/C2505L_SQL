-- index: là cấu trúc dữ liệu đặc biệt (chỉ mục)
-- truy vấn nhanh hơn tốc độ tìm kiếm nhanh và ổn định hơn 
-- tang hieu qua khi truy van vs join, orderby, group by... => SELECT 
-- Truong hop: INSERT, UPDATE, DELETE => lam cham thao tac 
-- Cu phap index:
-- CREATE loai_index(UNIQUE/Clustered/NONCLUSTERED) INDEX ten_index
-- ON table_name  (ten cot ASC/DESC, ten cot 2 ASC/DESC)
-- WHERE dieu kien 
-- Cac loai index:
-- Clustered: danh cho id - primary key : chi muc cum 
-- non - Clustered: 1 bang co bn loai nay cung duoc : chi muc khong cum 
-- unique: duy nhat khong trung cai nao: 1 bang n cot duoc danh chi so unique
-- composite index: chi muc da cot 
-- filter index : danh index theo dieu kien 
-- Tao index NONCLUSTERED danh chi so cho cot ho ten trong bang sinh vien 
-- Bat thoi gian thong ke 
SET STATISTICS TIME ON -- thoi gian thuc thi cau truy van 
SET STATISTICS IO ON -- hien thi so lan doc du lieu 
-- BEFORE: 
-- logical reads 4426
-- elapsed time = 54 ms
-- AFTER: 
-- logical reads 3 
-- elapsed time = 3 ms
SELECT * FROM SinhVien WHERE HoTen LIKE 'nh%' 
-- INDEX 
CREATE NONCLUSTERED INDEX IX_SV_HoTen 
ON SinhVien(HoTen)
-- Cu phap xoa index
-- DROP INDEX ten_index ON ten_bang 
-- Tạo chỉ mục để tối ưu truy vấn lọc theo ngày sinh (tìm sinh viên trong khoảng tuổi nhất định).
CREATE NONCLUSTERED INDEX IX_SV_TUOI
ON SinhVien(Tuoi)
-- Tạo chỉ mục kết hợp để lọc theo lớp và sắp xếp theo điểm trung bình giảm dần.
CREATE NONCLUSTERED INDEX IX_SV_DiemTB
ON SinhVien(DiemTB DESC, Lop)
-- Tạo chỉ mục duy nhất để đảm bảo email không trùng và tra cứu nhanh theo Email.
CREATE UNIQUE INDEX IX_SV_Email
ON SinhVien(Email)
-- Tạo filtered index để tối ưu truy vấn lấy danh sách sinh viên giỏi (DiemTB >= 8.0).
CREATE NONCLUSTERED INDEX IX_SV_DiemTB_Filter 
ON SinhVien(DiemTB)
WHERE DiemTB >=8.0
SELECT * FROM SinhVien WHERE  DiemTB >=8.0
-- SET TIME (2)
-- SELECT 
-- CMT: logic... est...
-- AFTER: .... 
-- Viet cau lenh index