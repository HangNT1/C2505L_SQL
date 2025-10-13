# RDBMS (Relational Database Management System)

## Có 2 loại SQL

- **SQL có quan hệ – RDBMS**: SQL Server, MySQL, Oracle, Postgres...
- **SQL không có quan hệ**: Không có nối gì cả – NoSQL (MongoDB)

---

## Buổi 1

- Phân biệt SQL (RDBMS & NoSQL)
- Luồng làm việc khi nhận yêu cầu từ phía người dùng
- Các khái niệm: Database, (DBMS & RDBMS), SQL
- Khái niệm:
  - Data
  - Database
  - Data model
  - ERM, ERD, Normalization...
  - Primary key...

---

## Buổi 2

### Các khái niệm trong entity

#### PK – Primary Key (Khóa chính)

- Định danh đối tượng
- Duy nhất (**unique**)
- Không được phép null (**NOT NULL**)
- Unique && Not Null
- Ví dụ: ID (tự tăng, tự gen), MSSV

#### Unique

- Duy nhất, có thể null
- Ví dụ:  
  `SinhVien(MSSV, Tên, Tuổi, Địa Chỉ, SDT, Email, Giới tính, CCCD)`  
  Một bảng có thể có nhiều Unique khác nhau

#### FK – Foreign Key (Khóa ngoại)

- **1-1**: FK ở bảng nào cũng được  
  Ví dụ:  
  `Vo(id, ma, ten, tuoi, diaChi, noiLamViec, gioiTinh, chong_id)`  
  `Chong(id, ma, ten, tuoi, diaChi, noiLamViec, gioiTinh)`

- **1-N**: FK đặt ở bảng nhiều  
  Ví dụ:  
  `GiaDinh(id, ma, ten, diaChi)`  
  `ThanhVien(id, ma, ten, tuoi, diaChi, noiLamViec, gioiTinh, gia_dinh_id)`

- **N-N**: Tách bảng trung gian giữa 2 thực thể (chứa cả khóa chính của 2 thực thể)  
  Ví dụ:  
  `SinhVien(id, ma, ten, tuoi, diaChi)`  
  `MonHoc(id, ma, ten, soTinChi)`  
  `DangKy(sinh_vien_id, mon_hoc_id)`
  - `PK(sinh_vien_id, mon_hoc_id)`
  - `FK1: sinh_vien_id` → bảng SinhVien
  - `FK2: mon_hoc_id` → bảng MonHoc

---

## Relationship – Mối quan hệ giữa 2 thực thể

- **1-1**: Vợ ↔ Chồng

  - 1 Vợ có 1 Chồng
  - 1 Chồng thuộc 1 Vợ

- **1-N**: Gia Đình ↔ Thành Viên

  - 1 Gia đình → N Thành viên
  - 1 Thành viên → 1 Gia đình

- **N-N**: Sinh Viên ↔ Môn học
  - 1 Sinh viên → N Môn học
  - 1 Môn học → N Sinh viên

---

## Các cách chuẩn hóa: 1NF, 2NF, 3NF

### 1NF

- Phải có PK
- Một cột chỉ có duy nhất 1 giá trị
- Không có dữ liệu trùng lặp

**Ví dụ vi phạm**:

| Student ID | Name | Phone              |
| ---------- | ---- | ------------------ |
| 1          | Hằng | 0123456,0956888888 |
| 2          | Hoa  | 0432423,0543534214 |

**Chuẩn hóa 1NF**:

| Student ID | Name | Phone      |
| ---------- | ---- | ---------- |
| 1          | Hằng | 0123456    |
| 1          | Hằng | 0956888888 |
| 2          | Hoa  | 0432423    |
| 2          | Hoa  | 0543534214 |

---

### 2NF

- Phải là 1NF
- Các thuộc tính không phải là khóa chính phải phụ thuộc vào toàn bộ khóa chính

**Ví dụ vi phạm**:

| Sinh viên ID | Môn học ID | Tên SV       | Tuổi | Tên môn học |
| ------------ | ---------- | ------------ | ---- | ----------- |
| SV01         | MH01       | Nguyễn Văn A | 10   | SQL         |
| SV01         | MH02       | Nguyễn Văn A | 10   | React       |
| SV02         | MH01       | Nguyễn Văn B | 11   | SQL         |
| SV03         | MH01       | Nguyễn Văn C | 13   | SQL         |

**Tách bảng**:

- `SinhVien (SVID, Tên, Tuổi)`
- `MonHoc (MHID, Tên môn)`
- `DangKy (SVID, MHID)`

---

### 3NF

- Phải là 2NF
- Mọi thuộc tính không phải khóa chính phải phụ thuộc trực tiếp vào khóa chính
- Không được phụ thuộc vào thuộc tính trung gian

**Ví dụ vi phạm**:

| KhoaHocID | Tên khóa học | Tên GV       |
| --------- | ------------ | ------------ |
| KH01      | SQL          | Nguyễn Văn A |
| KH02      | React JS     | Nguyễn Văn B |
| KH03      | PHP          | Nguyễn Văn C |

**Chuẩn hóa 3NF**:

- `KhoaHoc (KhoaHocID, Tên khóa học)`
- `GiangVien (Tên khóa học, Tên GV)`
