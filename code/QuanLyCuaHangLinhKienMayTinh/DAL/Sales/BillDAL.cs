using CommonLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO.Sales;
using DTO;
using Microsoft.ApplicationBlocks.Data;
namespace DAL.Sales
{
    
    public class BillDAL
    {
        //proList: Danh sách mã sản phẩm và số lượng tương ứng của một hóa đơn id= billId
        public void AddBill(string billId, string date, string cusId, string staffId, int sum, Dictionary<int,int> proList)
        {
                SqlParameter[] para1 =
                {
                    new SqlParameter("@MaHD",billId),
                    new SqlParameter("@NgayHD",date),
                    new SqlParameter("@MaKH",cusId),
                    new SqlParameter("@MaNV",staffId),
                    new SqlParameter("@ThanhTien",sum),
                    
                };
                SqlQuery.readProcedure("SearchProduct", para1);
 
        }
        public DataTable GetAllBill()
        {
            return SqlQuery.readSQL("select * from HOADON");
        }
        // Lấy danh sách hóa đơn được thanh toán trong ngày
        public DataTable GetBillToday()
        {
            string today = String.Format("{dd/MM/yyyy HH:mm:ss}",DateTime.Now.ToString());
            return SqlQuery.readSQL("Select* from HOADON where NgayHD=" + today);
        }
        //Lấy danh sách sản phẩm theo tên và loại
        public DataTable GetProduct(string productName, int categoryId)
        {
            SqlParameter[] para ={
                                            new SqlParameter("@TenSanPham",productName),
                                            new SqlParameter("@MaLoai",categoryId)
                                        };
            return SqlQuery.readProcedure("SearchProduct", para);

        }
        // lấy danh sách khách hàng theo tên khách hàng và loại khách hàng 
        public DataTable GetCustomer(string cusName, int cusTypeId)
        {
           
                SqlParameter[] para ={
                                            new SqlParameter("@TenKH",cusName),
                                            new SqlParameter("@LoaiKH",cusTypeId)
                                        };
                return SqlQuery.readProcedure("SearchCutomer", para);
        }

        // Lấy tất cả khách hàng
        public DataTable GetAllCustomer()
        {
            return SqlQuery.readSQL("select MaKH, TenKH from KHACHHANG");
        }
        // Lấy tất cả sản phẩm
        public DataTable GetAllProduct()
        {
            return SqlQuery.readSQL("select MaSP, TenSP from SANPHAN");
        }
      
  

    }
}
