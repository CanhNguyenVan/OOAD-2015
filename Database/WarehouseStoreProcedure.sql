use QLBH_CuaHangBanMayTinhVaLinhKien

go
create procedure GetListWarehouses
as
select [MaKho]
      ,[TenKho]
      ,[GhiChu]
  from [QLBH_CuaHangBanMayTinhVaLinhKien].[dbo].[KHO]
go

go 
create procedure AddWarehouse
@MaKho nvarchar(10),
@TenKho nvarchar(50), 
@GhiChu nvarchar(100)
as
	insert into KHO(MaKho, TenKho, Ghichu)
	values(@MaKho, @TenKho, @GhiChu)
go

	

go 
create procedure SearchWarehouse
@Query nvarchar(50)
as 
	select [MaKho]
      ,[TenKho]
      ,[GhiChu]
	  from [QLBH_CuaHangBanMayTinhVaLinhKien].[dbo].[KHO]
	  where 
	  MaKho like '%' + @Query + '%' or 
	  TenKho like '%' + @Query + '%' or 
	  GhiChu like '%' + @Query + '%' 
 go

 go 
create procedure EditWarehouse
@MaKho nvarchar(10),
@TenKho nvarchar(50), 
@GhiChu nvarchar(100)
as
	update KHO
	set TenKho = @TenKho,
	Ghichu = @GhiChu
	where Makho = @MaKho
go

go
create procedure GetListProducts
as
select *
	from SANPHAM
go

go 
create procedure AddProduct
@MaSanPham nvarchar(10),
@TenSanPham nvarchar(50), 
@ThoiGianBaohanh int,
@LoaiSanPham nvarchar(50),
@DonGiaNhap float,
@DonGiaBan float,
@SoLuong int, 
@DonViTinh nvarchar(50),
@GhiChu nvarchar(100)
as
	insert into SANPHAM(MaSanPham, TenSanPham, LoaiSanPham, ThoiGianBaoHanh, DonGiaNhap, DonGiaBan, SoLuong, DonViTinh, GhiChu)
	values(@MaSanPham, @TenSanPham, @LoaiSanPham, @ThoiGianBaohanh, @DonGiaNhap, @DonGiaBan, @SoLuong, @DonViTinh, @GhiChu)
go

go 
create procedure EditProduct
@MaSanPham nvarchar(10),
@TenSanPham nvarchar(50), 
@LoaiSanPham nvarchar(50),
@ThoiGianBaoHanh int,
@DonGiaNhap float,
@DonGiaBan float,
@SoLuong int, 
@DonViTinh nvarchar(50),
@GhiChu nvarchar(100)
as
	update SANPHAM
	set 
	TenSanPham = @TenSanPham,
	LoaiSanPham = @LoaiSanPham,
	ThoiGianBaoHanh = @ThoiGianBaoHanh,
	DonGiaNhap =  @DonGiaNhap,
	DonGiaBan = @DonGiaBan,
	SoLuong = @SoLuong,
	DonViTinh = @DonViTinh,
	GhiChu = @GhiChu
	where MaSanPham = @MaSanPham
go


go 

create procedure DeleteProduct 
@MaSanPham nvarchar(10)
as 
delete from SANPHAM 
where MaSanPham = @MaSanPham
go 


go
create procedure GetDistributorList
as 
select MaNhaPhanPhoi,
TenNhaPhanPhoi,
DiaChi, 
SoDienThoai, 
Email,
MaSoThue,
GhiChu 
from NHAPHANPHOI 
go


go
create procedure GetWarehouseBillList
as 
select *
from PHIEUNHAPKHO
go 

go
create procedure GetDeliveryBillList
as 
select *
from PHIEUXUATKHO
go 

go 
create procedure AddWarehouseBill
@MaPhieuNhapKho nvarchar(10),
@NgayLapPhieu smalldatetime,
@MaNguoiLapPhieu nvarchar(10),
@GhiChu nvarchar(100)
as 
insert into PHIEUNHAPKHO
values(@MaPhieuNhapKho, @NgayLapPhieu, @MaNguoiLapPhieu, @GhiChu)
go

go
create procedure AddDeliveryBill
@MaPhieuXuatKho nvarchar(10),
@NgayLapPhieu smalldatetime,
@MaNguoiNhan nvarchar(10),
@MaNguoiLapPhieu nvarchar(10),
@GhiChu nvarchar(100)
as 
insert into PHIEUXUATKHO
values(@MaPhieuXuatKho, @NgayLapPhieu, @MaNguoiNhan, @MaNguoiLapPhieu, @GhiChu) 
go


go 
create procedure GetWarehouseBillDetailList 
as 
select MaChiTietPhieuNhapKHo, 
MaPHieuNhapKho,
CHITIETPHIEUNHAPKHO.MaSanPham,
SANPHAM.DonGiaNhap,
CHITIETPHIEUNHAPKHO.SoLuong,
CHITIETPHIEUNHAPKHO.GhiChu
from CHITIETPHIEUNHAPKHO 
inner join SANPHAM
on SANPHAM.MaSanPham = CHITIETPHIEUNHAPKHO.MaSanPham
go

go 
create procedure GetDeliveryBillDetailList 
as 
select MaChiTietPhieuXuatKho, 
MaPHieuXuatKho,
CHITIETPHIEUXUATKHO.MaSanPham,
SANPHAM.DonGiaNhap,
CHITIETPHIEUXUATKHO.SoLuong,
CHITIETPHIEUXUATKHO.GhiChu
from CHITIETPHIEUXUATKHO 
inner join SANPHAM
on SANPHAM.MaSanPham = CHITIETPHIEUXUATKHO.MaSanPham
go


go
create procedure GetWarehouseBillDetailListWithMaPhieuNhapKho
@MaPhieuNhapKho nvarchar(10)
as 
select MaChiTietPhieuNhapKHo, 
MaPHieuNhapKho,
CHITIETPHIEUNHAPKHO.MaSanPham,
SANPHAM.DonGiaNhap,
CHITIETPHIEUNHAPKHO.SoLuong,
CHITIETPHIEUNHAPKHO.GhiChu
from CHITIETPHIEUNHAPKHO 
inner join SANPHAM
on SANPHAM.MaSanPham = CHITIETPHIEUNHAPKHO.MaSanPham
where MaPhieuNhapKho = @MaPhieuNhapKho
go

go
create procedure GetDeliveryBillDetailListWithMaPhieuXuatKho
@MaPhieuXuatKho nvarchar(10)
as 
select MaChiTietPhieuXuatKho, 
MaPHieuXuatKho,
CHITIETPHIEUXUATKHO.MaSanPham,
SANPHAM.DonGiaNhap,
CHITIETPHIEUXUATKHO.SoLuong,
CHITIETPHIEUXUATKHO.GhiChu
from CHITIETPHIEUXUATKHO 
inner join SANPHAM
on SANPHAM.MaSanPham = CHITIETPHIEUXUATKHO.MaSanPham
where MaPhieuXuatKho = @MaPhieuXuatKho
go


go
create procedure SumTotal
@MaPhieuNhapKho nvarchar(10)
as 
select SUM(SANPHAM.DonGiaNhap)
from CHITIETPHIEUNHAPKHO 
inner join SANPHAM
on SANPHAM.MaSanPham = CHITIETPHIEUNHAPKHO.MaSanPham
where MaPhieuNhapKho = @MaPhieuNhapKho
go
go 
create procedure AddWarehouseBillDetail
@MaChiTietPhieuNhapKho nvarchar(10),
@MaPhieuNhapKho nvarchar(10),
@MaSanPham nvarchar(10),
@Soluong int,
@GhiChu nvarchar(100)
as 
insert into CHITIETPHIEUNHAPKHO
values(@MaChiTietPhieuNhapKho, @MaPhieuNhapKho, @MaSanPham, @Soluong, @GhiChu)
go


go 
create procedure AddDeliveryBillDetail
@MaChiTietPhieuXuatKho nvarchar(10),
@MaPhieuXuatKho nvarchar(10),
@MaSanPham nvarchar(10),
@Soluong int,
@GhiChu nvarchar(100)
as 
insert into CHITIETPHIEUXUATKHO
values(@MaChiTietPhieuXuatKho, @MaPhieuXuatKho, @MaSanPham, @Soluong, @GhiChu)
go



go 
create procedure GetCountProductByID
@MaSanPham nvarchar(10)
as 
select SoLuong
from SANPHAM
where MaSanPham = @MaSanPham
go

go 
create procedure UpdateCountProduct
@MaSanPham nvarchar(10),
@SoLuong int 
as 
update SANPHAM
set
SoLuong = SoLuong + @SoLuong
where MaSanPham = @MaSanPham
go

go
create procedure UpdateCountProductOut
@MaSanPham nvarchar(10),
@SoLuong int
as 
update SANPHAM
set 
SoLuong = SoLuong - @SoLuong
where MaSanPham = @MaSanPham
go

go 
create procedure GetEmployeeList
as
select * 
from NHANVIEN
go 