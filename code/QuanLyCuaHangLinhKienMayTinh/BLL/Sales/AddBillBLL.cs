using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO.Warehouse;
using DTO.Sales;
using DAL.Sales;
using System.Data;
//chức năng add bill làm từ chủ nhật ngày 14/12
namespace BLL.Sales
{
    public class AddBillBLL
    {
        
        BillDAL dal= new BillDAL();
        public DataTable GetAllCustomer()
        {
            return dal.GetAllCustomer();
        }
        public DataTable GetAllProduct()
        {
            return dal.GetAllCustomer();
        }
        public DataTable SearchProduct(string productName, int typeId)
        {
            return dal.GetProduct(productName, typeId);
        }
        public DataTable SearchCustomer(string customerName, int typeId)
        {
            return dal.GetCustomer(customerName, typeId);

        }
        public void SaveBill(string billId, string date, string cusId, string staffId, int sum, Dictionary<int,int> proList)
        {
            dal.AddBill(this.NextId(billId), date, cusId, staffId, sum, proList);
        }
        public string NextId(string id)
        {
            if(id==""){
                return "KH000001";
            }
            int nextNum=int.Parse(id.Substring(1))+1;
            string num=nextNum.ToString();
            while(num.Length<6){
                num="0"+num;
            }
            return "KH"+num;
        }

       
    }
}
