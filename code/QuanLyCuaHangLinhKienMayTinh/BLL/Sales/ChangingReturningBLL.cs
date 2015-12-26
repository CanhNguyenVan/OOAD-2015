using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Sales;
using System.Data;
namespace BLL.Sales
{
    public class ChangingReturningBLL
    {
        BillDAL billDal = new BillDAL();
        ChangingReturningDAL dal = new ChangingReturningDAL();
        //Lấy danh sách nhóm sản phẩm
        public DataTable GetAllProduct()
        {
            return billDal.GetAllProduct();
        }
        // lấy danh sách sản phẩm theo category
        public DataTable GetProductFollowCategory(string categoryName)
        {
            return billDal.GetProduct(categoryName);
        }
        // lấy danh sách sản phẩm theo tên
        public DataTable GetProductfromName(string proName)
        {
            return billDal.GetProductfromName(proName);
        }
        // lấy danh sánh sản phẩm theo tên sản phẩm và loại 
        public DataTable GetProductListByCategoryProName(string proName, string category)
        {
            return billDal.GetProduct(proName, category);
        }
        public DataTable GetProductCategory()
        {
            return billDal.GetCategoryList();
        }
        public int GetDayReturn(string billId)
        {
            string returnDateStr=dal.GetDateBill(billId).Rows[0][0].ToString();
            DateTime returnDate = DateTime.Parse(returnDateStr);
            return (int)(DateTime.Now - returnDate).TotalDays;
        }
        
        public DataTable GetProductListofBill(string billId)
        {
            return dal.GetProductListofBill(billId);
        }
        public float  GetFeeChangeReturning(string proType, string billId, int day, string error)
        {
            if (proType == "Phụ kiện")
            {
                if (day <= 30)
                    return 0;
                else
                    return -1;
            }
            else
            {

                if (day <= 14)
                {
                    if (error == "Lỗi do nhà sản xuất")
                    {
                        return 0;
                    }
                    else
                        return 10;
                }
                else if (day <= 28)
                {
                    return 20;
                }
                else if (day <= 42)
                {
                    return 30;
                }
                else
                {
                    return (day - 42) * 0.15f + 30;
                }
               
            }
        }
        public string GetCustomerName(string billId)
        {
            return dal.GetCustomerName(billId).Rows[0][1].ToString();
        }
        public string GetCustomerId(string billId)
        {
            return dal.GetCustomerName(billId).Rows[0][0].ToString();
        }
        // lấy giá sản phẩm theo mã
        public int GetPriceProduct(string productId)
        {
            string price=billDal.GetProductPrice(productId).Rows[0][0].ToString();
            return int.Parse(price.Substring(0,price.IndexOf(".")));
        }
        public void AddChangingBill(string billId, string proId, string reProId, int feeToCompany,int feeToCus )
        {
            string now= DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
            string lastChangingBillId=dal.GetLastChangingBillId().Rows.Count==0?"":dal.GetLastChangingBillId().Rows[0][0].ToString();
            dal.AddChangingBill(AddBillBLL.NextId("HDD", lastChangingBillId, 3), now, GetCustomerId(billId), "NV1", billId, proId, reProId, feeToCompany, feeToCus);
        }
        public void AddReturningBill(string billId, string proId, int feeToCus)
        {
            string now = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
            string lastChangingBillId = dal.GetLastReturningBillId().Rows.Count == 0 ? "" : dal.GetLastReturningBillId().Rows[0][0].ToString();
            dal.AddReturningBill(AddBillBLL.NextId("HDT", lastChangingBillId, 3), now, GetCustomerId(billId), "NV1", billId, proId, feeToCus);
        }
    }
}
