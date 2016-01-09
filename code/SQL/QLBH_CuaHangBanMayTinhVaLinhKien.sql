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
	DiaChi nvarchar(4000)  NULL,
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
	MaTS int not null primary key identity(0,1),
	TenTS nvarchar(100) not null,
	GiaTri int not null,
)
--Data for NHANVIEN
INSERT [dbo].[NHANVIEN] ([MaNV], [Ten], [Tuoi], [CMND], [SDT], [NoiSinh], [NoiTamTru], [TinhTrangHonNhan], [TrinhTrangCongViec], [NgayVaoLam]) VALUES (N'NV1', N'Tr?n Th? Th?m', 29, N'123456789', N'0989765890', N'Hải Phòng', N'Tp HCM', N'Độc Thân', N'Đang làm', CAST(N'2015-09-11 00:00:00' AS SmallDateTime))
--Data for SANPHAM
insert into SANPHAM values('SP000001', 'USB Tosiba',N'Phụ kiện', 60, 100000, 150000, 20, N'cái', 'Hàng Trung Quốc');
insert into SANPHAM values('SP000002', 'USB Kington 8G',N'Phụ Kiện', 60, 600000, 85000, 20, N'cái', 'Hàng dổm 100%');
insert into SANPHAM values('SP000003', 'USB Dell 16G US',N'Phụ kiện', 80, 100000, 150000, 20, N'cái', 'Không có gì để ghi chú');
insert into SANPHAM values('SP000004', 'Chuot', N'Phụ kiện', 60,  10000, 60000, 20, N'cái', '');
insert into SANPHAM values('SP000005', 'RAM', N'Phụ kiện', 399000, 60, 500000, 20, N'cái', '');
insert into SANPHAM values('SP000006', 'Man hinh LCD',N'Phụ kiện', 120, 977000, 1500000, 20, N'cái', 'Màng hình lậu');
insert into SANPHAM values('SP000007', 'Máy tính Lenovo', N'Laptop', 11399000, 120, 11500000, 90, N'cái', '');
insert into SANPHAM values('SP000008', 'Lap top Dell 5600',N'laptop', 120, 11000000, 15000000, 10, N'cái', '');
insert into SANPHAM values('SP000009', 'Ipad Air 2', N'Máy tính bảng', 10000000, 60, 19500000, 20, N'cái', '');
insert into SANPHAM values('SP000010', 'Iphone 7s',N'Điện thoại', 100, 12000000, 18000000, 9, N'cái', 'Máy dổm');
insert into SANPHAM values('SP000011', 'SamSum Galaxy',N'Điện thoại', 100, 9000000, 16600000, 12, N'cái', 'Máy vip');
--Data for KHACH HANG
INSERT INTO KHACHHANG VALUES('KH000001',N'Nguyễn Nghĩa',N'168,Cộng Hòa, TPHCM','01676857350','273145671', null)
INSERT INTO KHACHHANG VALUES('KH000002',N'Võ Thị Bì',N'Quận9, TPHCM','01676857350','273145672', null)
INSERT INTO KHACHHANG VALUES('KH000003',N'Nguyễn Quang Sáng',N'Quận Thủ Đức, TPHCM','1234567890','273145673', null)
INSERT INTO KHACHHANG VALUES('KH000004',N'Nguyễn văn Tèo',N'Quận Bình Chánh, TPHCM','1234522890','273145673', null)
INSERT INTO KHACHHANG VALUES('KH000005',N'Lê Phương Vy',N'Kim Long,Châu Đức,Bà Rịa-Vũng Tàu ','0167906350','273145675', null)
INSERT INTO KHACHHANG VALUES('KH000006',N'Ưng Hoàng Phúc',N'87 Nguyễn Du, Quận 1, TpHCM','089068573','27314567', null)
INSERT INTO KHACHHANG VALUES('KH000007',N'Hoàng Hải',N'90 Lý CN, Quận 1, tpHCM','01623457350','273145677', null)
INSERT INTO KHACHHANG VALUES('KH000008',N'Trịnh Công',N'Mỏ Cày, Cà Mau','01676857350','273145678', null)
INSERT INTO KHACHHANG VALUES('KH000009',N'Văn thị Vẽ',N'168,Cộng Hòa, TPHCM','0996857350','273145679', null)
INSERT INTO KHACHHANG VALUES('KH000010',N'Hứa Văn Lèo',N'Ngãi Giao, BR-VT','01676857350','273145610', null)
INSERT INTO KHACHHANG VALUES('KH000012',N'Hồ Huyền Trang',N'234 Xa Lộ HN, TPHCM','009857380','273145611', null)
INSERT INTO KHACHHANG VALUES('KH000013',N'Barack Obama',N'Hoàn Kiếm, Thu đô Hà Nội','01670007350','100078392', null)
INSERT INTO KHACHHANG VALUES('KH000014',N'Tô Minh Đức',N'Thanh Khuê, thành phố Đà Nẵng','0976845150','397456922', null)
INSERT INTO KHACHHANG VALUES('KH000015',N'Nguyễn Du',N'100 Xa Lộ Hà Nội, TPHCM','01676857350','258932344',null)
--Data for QUYDINH table
insert into THAMSO values('0', N'Thuế suất', 10);
set dateformat dmy;
--data for CHITETHOADON
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000001', N'SP000001', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000001', N'SP000003', 2)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000002', N'SP000009', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000003', N'SP000010', 2)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000004', N'SP000004', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000004', N'SP000006', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000004', N'SP000011', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000005', N'SP000001', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000005', N'SP000011', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000006', N'SP000005', 2)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000006', N'SP000006', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000006', N'SP000009', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000007', N'SP000004', 2)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000007', N'SP000011', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000008', N'SP000003', 2)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000008', N'SP000005', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000009', N'SP000009', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000009', N'SP000011', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000010', N'SP000004', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000011', N'SP000006', 1)
INSERT [dbo].[CHITIETHOADON] ([MaHD], [MaSanPham], [SoLuong]) VALUES (N'HD000011', N'SP000008', 1)
-- Data for HOADON
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD000001', CAST(N'2015-12-28 00:00:00' AS SmallDateTime), N'KH000001', N'NV1', 300000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD000002', CAST(N'2015-12-28 00:00:00' AS SmallDateTime), N'KH000003', N'NV1', 19500000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD000003', CAST(N'2015-12-28 00:00:00' AS SmallDateTime), N'KH000013', N'NV1', 37500000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD000004', CAST(N'2015-12-28 00:00:00' AS SmallDateTime), N'KH000009', N'NV1', 55660000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD000005', CAST(N'2015-12-28 00:00:00' AS SmallDateTime), N'KH000015', N'NV1', 72410000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD000006', CAST(N'2015-12-29 00:00:00' AS SmallDateTime), N'KH000005', N'NV1', 21500000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD000007', CAST(N'2015-12-29 00:00:00' AS SmallDateTime), N'KH000008', N'NV1', 38160000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD000008', CAST(N'2015-12-29 00:00:00' AS SmallDateTime), N'KH000012', N'NV1', 38810000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD000009', CAST(N'2015-12-29 00:00:00' AS SmallDateTime), N'KH000004', N'NV1', 74910000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD000010', CAST(N'2016-01-02 00:00:00' AS SmallDateTime), N'KH000005', N'NV1', 60000.0000)
INSERT [dbo].[HOADON] ([MaHD], [NgayHD], [MaKH], [MaNV], [ThanhTien]) VALUES (N'HD000011', CAST(N'2016-01-02 00:00:00' AS SmallDateTime), N'KH000008', N'NV1', 16500000.0000)


