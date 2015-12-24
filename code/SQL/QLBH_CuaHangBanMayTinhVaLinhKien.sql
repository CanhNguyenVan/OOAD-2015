Use master
Go
--Drop Database QLBH_CuaHangBanMayTinhVaLinhKien
Go
Create Database QLBH_CuaHangBanMayTinhVaLinhKien
Go
Use QLBH_CuaHangBanMayTinhVaLinhKien
Go

Set DateFormat DMY

CREATE TABLE KHACHHANG
(
	MaKH nvarchar(10) primary key NOT NULL,
	TenKH nvarchar(100) NOT NULL,
	DiaChi nvarchar(1000)  NULL,
	SoDT nvarchar(20) NOT NULL,
	CMND nvarchar(20) NOT NULL,
	Email nvarchar(50) NULL,
)

GO

CREATE TABLE NHANVIEN(
	MaNV nvarchar(10) NOT NULL primary key,
	Ten nvarchar(50) NOT NULL,
	Tuoi int NOT NULL,
	CMND nvarchar(12) NOT NULL,
	SDT nvarchar(15) NOT NULL,
	NoiSinh nvarchar(50) NOT NULL,
	NoiTamTru nvarchar(50) NOT NULL,
	TinhTrangHonNhan nvarchar(50) NOT NULL,
	TrinhTrangCongViec nvarchar(50) NOT NULL,
	NgayVaoLam smalldatetime NOT NULL
)

GO

CREATE TABLE LICHSUDANGNHAP
(
	MaLSDN nvarchar(10) NOT NULL primary key,
	MaNV nvarchar(10) NOT NULL foreign key references NHANVIEN(MaNV),
	TuNgay smalldatetime NOT NULL,
	ToiNgay smalldatetime NOT NULL
)

GO

CREATE TABLE LICHSULAMVIEC
(
	MaLSCV nvarchar(10) NOT NULL primary key,
	MaNV nvarchar(10) NOT NULL foreign key references NHANVIEN(MaNV),
	TuNgay smalldatetime NOT NULL,
	ToiNgay smalldatetime NOT NULL,
	ChucVu nvarchar(50) NOT NULL,
	Luong nvarchar(50) NOT NULL
)

GO

CREATE TABLE TAIKHOAN
(
	MaTK nvarchar(10) primary key NOT NULL,
	MaNV nvarchar(10) NOT NULL foreign key references NHANVIEN(MaNV),
	TenDangNhap nvarchar(50) NOT NULL,
	MatKhau nvarchar(50) NOT NULL,
	Email nvarchar(100) NOT NULL
)

GO

CREATE TABLE HOADON
(
	MaHD nvarchar(10) NOT NULL primary key,
	NgayHD smalldatetime NOT NULL,
	MaKH nvarchar(10) foreign key references KHACHHANG(MaKH) NOT NULL,
	MaNV nvarchar(10) NOT NULL foreign key references NHANVIEN(MaNV),
	ThanhTien money NOT NULL,
)

GO

CREATE TABLE SANPHAM
(
	MaSanPham nvarchar(10) not null, 
	TenSanPham nvarchar(50) not null, 
	LoaiSanPham nvarchar(50) not null, 
	ThoiGianBaoHanh int not null, 
	DonGiaNhap money not null,  
	DonGiaBan money not null, 
	SoLuong int not null,
	DonViTinh nvarchar(10) not null, 
	GhiChu nvarchar(100),
	primary key(MaSanPham),
	check(ThoiGianBaoHanh >= 0 and SoLuong >= 0 and DonGiaNhap > 0 and DonGiaBan >= DonGiaNhap) 
)

GO

CREATE TABLE CHITIETHOADON
(
	MaHD nvarchar(10) NOT NULL foreign key references HOADON(MaHD),
	MaSanPham nvarchar(10) NOT NULL foreign key references SANPHAM(MaSanPham),
	SoLuong int NOT NULL,
	primary key(MaHD, MaSanPham)
)

GO  

CREATE TABLE HOADONDOI
(
	MaHDD nvarchar(10) primary key NOT NULL,
	NgayDoi smalldatetime NOT NULL,
	MaKH nvarchar (10) foreign key references KHACHHANG(MaKH) NOT NULL,
	MaNV nvarchar(10) foreign key references NHANVIEN(MaNV) NOT NULL,
	MaHD nvarchar(10) foreign key references HOADON(MaHD) NOT NULL,
	MaSanPham nvarchar(10) foreign key references SANPHAM(MaSanPham) NOT NULL,
	MaSanPhamThayThe nvarchar(10) NULL,
	PhiDoi money NOT NULL,
	PhiHoan money NOT NULL
)

GO

CREATE TABLE HOADONTRA 
(
	MaHDT nvarchar(10) primary key NOT NULL,
	NgayTra smalldatetime NOT NULL,
	MaKH nvarchar(10) foreign key references KHACHHANG(MaKH) NOT NULL,
	MaNV nvarchar(10) foreign key references NHANVIEN(MaNV) NOT NULL,
	MaHD nvarchar(10) foreign key references HOADON(MaHD) NOT NULL,
	MaSanPham nvarchar(10) foreign key references SANPHAM(MaSanPham) NOT NULL,
	PhiHoan money NOT NULL
)

GO

CREATE TABLE PHIEUXUATKHO
(
	MaPhieuXuatKho nvarchar(10) not null,
	NgayLapPhieu smalldatetime not null,	 
	MaNguoiNhan nvarchar(10) foreign key references NHANVIEN(MaNV) not null, 
	MaNguoiLapPhieu nvarchar(10) foreign key references NHANVIEN(MaNV)  not null, 
	GhiChu nvarchar(100),
	primary key(MaPhieuXuatKho)
	-- MaNguoiYeuCau, MaNguoiNhan, MaNguoiLapPhieu la khoa ngoai
)

GO

CREATE TABLE PHIEUNHAPKHO
(
	MaPhieuNhapKho nvarchar(10) not null, 
	NgayLapPhieu smalldatetime not null, 
	MaNguoiLapPhieu nvarchar(10) foreign key references NHANVIEN(MaNV) not null, 
	GhiChu nvarchar(100),
	primary key(MaPhieuNhapKho)
	-- MaNguoiNhan, MaNguoiLapPhieu la khoa ngoai
)

GO

CREATE TABLE PHIEUTRAHANG
(
	MaPhieuTraHang nvarchar(10) not null, 
	NgayLap smalldatetime not null,
	MaNguoiLapPhieu nvarchar(10) foreign key references NHANVIEN(MaNV)  not null,
	primary key(MaPhieuTraHang)
	-- MaNhaPhanPhoi, MaNguoiLaPhieu la khoa ngoai
)

GO

CREATE TABLE CHITIETPHIEUXUATKHO
(
	MaChiTietPhieuXuatKho nvarchar(10) not null, 
	MaPhieuXuatKho nvarchar(10) not null, 
	MaSanPham nvarchar(10) not null,
	SoLuong int not null, 
	GhiChu nvarchar(100),
	primary key(MaChiTietPhieuXuatKho),
	foreign key(MaPhieuXuatKho) references PHIEUXUATKHO(MaPhieuXuatKho),
	foreign key(MaSanPham) references SANPHAM(MaSanPham),
	check(SoLuong > 0)

)

GO

CREATE TABLE CHITIETPHIEUTRAHANG
(
	MaChiTietPhieuTraHang nvarchar(10) not null, 
	MaPhieuTraHang nvarchar(10) not null,
	MaSanPham nvarchar(10) not null, 
	SoLuong int not null, 
	GhiChu nvarchar(100),
	primary key(MaChiTietPhieuTraHang),
	foreign key(MaPhieuTraHang) references PHIEUTRAHANG(MaPhieuTraHang),
	foreign key(MaSanPham) references SANPHAM(MaSanPham),
	check(SoLuong > 0)
)

GO 

CREATE TABLE CHITIETPHIEUNHAPKHO
(
	MaChiTietPhieuNhapKho nvarchar(10) not null, 
	MaPhieuNhapKho nvarchar(10) not null, 
	MaSanPham nvarchar(10) not null, 
	SoLuong int not null, 
	GhiChu nvarchar(100),
	primary key(MaChiTietPhieuNhapKho),
	check(SoLuong > 0),
	foreign key(MaPhieuNhapKho) references PHIEUNHAPKHO(MaPhieuNhapKho),
	foreign key(MaSanPham) references SANPHAM(MaSanPham)
)

GO

CREATE TABLE PHIEUTIEPNHANBAOHANH
(
	MaPTNBH nvarchar(10) NOT NULL primary key,
	MaNV nvarchar(10) NOT NULL foreign key references NHANVIEN(MaNV),
	NgayLap datetime NOT NULL
)

GO

CREATE TABLE CHITIETPHIEUTIEPNHANBAOHANH
(
	MaCTPTNBH nvarchar(10) NOT NULL primary key,
	MaHoaDon nvarchar(10) NOT NULL foreign key references HOADON(MaHD),
	MoTaLoi nvarchar(100) NOT NULL,
	SoLuong int NOT NULL,
	MaPTNBH nvarchar(10) NOT NULL foreign key references PHIEUTIEPNHANBAOHANH(MaPTNBH)
)

GO

CREATE TABLE PHIEUTRAHANGBAOHANH
(
	MaPTHBH nvarchar(10) NOT NULL primary key,
	TenNhanVien nvarchar(50) NOT NULL,
	NgayLapPhieu smalldatetime NOT NULL,
	TongCong money NOT NULL
)

GO
 
CREATE TABLE CHITIETPHIEUTRAHANGBAOHANH
(
	MaCTPTHBH nvarchar(10) NOT NULL primary key,
	MaPTHBH nvarchar(10) NOT NULL foreign key references PHIEUTRAHANGBAOHANH(MaPTHBH),
	MaPTNBH nvarchar(10) NOT NULL foreign key references PHIEUTIEPNHANBAOHANH(MaPTNBH),
	DonGia money NOT NULL,
	ThanhTien money NOT NULL
)

GO

CREATE TABLE PHIEUXUATLINHKIENBAOHANH
(
	MaPXLKBH nvarchar(10) NOT NULL primary key,
	MaNVKT nvarchar(10) NOT NULL foreign key references NHANVIEN(MaNV),
	MaNVKho nvarchar(10) NOT NULL foreign key references NHANVIEN(MaNV),
	NgayLap smalldatetime NOT NULL
)

GO

CREATE TABLE CHITIETPHIEUXUATLINHKIENBAOHANH
(
	MaCTPXLK nvarchar(10) NOT NULL primary key,
	MaPXLKBH nvarchar(10) NOT NULL foreign key references PHIEUXUATLINHKIENBAOHANH(MaPXLKBH),
	MaPTNBH nvarchar(10) NOT NULL foreign key references PHIEUTIEPNHANBAOHANH(MaPTNBH),
	DonGia money NOT NULL
)
CREATE TABLE THAMSO
(
	MaQD int not null primary key,
	TenQD nvarchar(100) not null,
	GiaTri int not null,
)
insert into SANPHAM values('SP1', 'USB Tosiba',N'Phụ kiện', 60, 100000, 150000, 20, N'cái', 'Hàng Trung Quốc');
insert into SANPHAM values('SP2', 'USB Kington 8G',N'Phụ Kiện', 60, 600000, 85000, 20, N'cái', 'Hàng dổm 100%');
insert into SANPHAM values('SP3', 'USB Dell 16G US',N'Phụ kiện', 80, 100000, 150000, 20, N'cái', 'Không có gì để ghi chú');
insert into SANPHAM values('SP4', 'Chuot', N'Phụ kiện', 60,  10000, 60000, 20, N'cái', '');
insert into SANPHAM values('SP5', 'RAM', N'Phụ kiện', 399000, 60, 500000, 20, N'cái', '');
insert into SANPHAM values('SP6', 'Man hinh LCD',N'Phụ kiện', 120, 977000, 1500000, 20, N'cái', 'Màng hình lậu');
insert into SANPHAM values('SP7', 'Máy tính Lenovo', N'Laptop', 11399000, 120, 11500000, 90, N'cái', '');
insert into SANPHAM values('SP8', 'Lap top Dell 5600',N'laptop', 120, 11000000, 15000000, 10, N'cái', '');
insert into SANPHAM values('SP9', 'Ipad Air 2', N'Máy tính bảng', 10000000, 60, 19500000, 20, N'cái', '');
insert into SANPHAM values('SP10', 'Iphone 7s',N'Điện thoại', 100, 12000000, 18000000, 9, N'cái', 'Máy dổm');
insert into SANPHAM values('SP11', 'SamSum Galaxy',N'Điện thoại', 100, 9000000, 16600000, 12, N'cái', 'Máy vip');


INSERT INTO KHACHHANG VALUES('KH001',N'Nguyễn Nghĩa','273145671',N'168,Cộng Hòa, TPHCM','01676857350', null)
INSERT INTO KHACHHANG VALUES('KH002',N'Võ Thị Bì','273145672',N'Quận9, TPHCM','01676857350', null)
INSERT INTO KHACHHANG VALUES('KH003',N'Nguyễn Quang Sáng','273145673',N'Quận Thủ Đức, TPHCM','1234567890', null)
INSERT INTO KHACHHANG VALUES('KH004',N'Nguyễn văn Tèo','273145673',N'Quận Bình Chánh, TP','1234522890', null)
INSERT INTO KHACHHANG VALUES('KH005',N'Lê Phương Vy','273145675',N'Kim Long,Châu Đức, ','0167906350', null)
INSERT INTO KHACHHANG VALUES('KH006',N'Ưng Hoàng Phúc','273145676',N'87 Nguyễn Trãi,Quận 1, TPHCH','08906857350', null)
INSERT INTO KHACHHANG VALUES('KH007',N'Hoàng Hải','273145677',N'90 Lí Thường Kiệt,Quận 1, TPHCM','01623457350', null)
INSERT INTO KHACHHANG VALUES('KH008',N'Trịnh Công','273145678',N'Mỏ Cày, Cà Mau','01676857350', null)
INSERT INTO KHACHHANG VALUES('KH009',N'Văn thị Vẽ','273145679',N'32, Lê Lợi,Quận 9, TPHCM','0996857350', null)
INSERT INTO KHACHHANG VALUES('KH010',N'Hứa Văn Lèo','273145610',N'Ngãi Giao, BR-VT','01676857350', null)
INSERT INTO KHACHHANG VALUES('KH012',N'Hồ Huyền Trang','273145611',N'234 Xa Lộ Hà Nội, TPHCM','009857380', null)
INSERT INTO KHACHHANG VALUES('KH013',N'Barack Obama','100078392',N'Hoàn Kiếm, Hà Nội','01670007350', null)
INSERT INTO KHACHHANG VALUES('KH014',N'Tô Minh Đức','397456922',N'Thanh Khuê, Đà Nẵng','0976845150', null)
INSERT INTO KHACHHANG VALUES('KH015',N'Nguyễn Du','258932344',N'100 Xa Lộ Hà Nội, TPHCM','01676857350',null)
--Data for QUYDINH table

insert into THAMSO values('0', N'Thuế suất', 10);
set dateformat dmy;
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD1', N'SP10', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD1', N'SP4', 4)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD1', N'SP5', 3)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD2', N'SP10', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD2', N'SP3', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD3', N'SP10', 3)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD3', N'SP11', 2)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD4', N'SP3', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD4', N'SP6', 2)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD5', N'SP10', 7)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD6', N'SP11', 3)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD6', N'SP5', 8)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD1', CAST(N'2015-12-22 00:00:00' AS SmallDateTime), N'KH005', N'NV1', 19560000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD2', CAST(N'2015-12-24 00:00:00' AS SmallDateTime), N'KH003', N'NV1', 18150000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD3', CAST(N'2015-12-24 00:00:00' AS SmallDateTime), N'KH002', N'NV1', 105350000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD4', CAST(N'2015-12-24 00:00:00' AS SmallDateTime), N'KH003', N'NV1', 108500000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD5', CAST(N'2015-12-24 00:00:00' AS SmallDateTime), N'KH013', N'NV1', 234500000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD6', CAST(N'2015-12-24 00:00:00' AS SmallDateTime), N'KH014', N'NV1', 288300000.0000)