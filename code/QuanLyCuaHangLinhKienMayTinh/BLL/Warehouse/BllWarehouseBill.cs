using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;

namespace BLL.Warehouse
{
    public class BllWarehouseBill
    {
        private DalWarehouseBill _dalWarehouse;

        public BllWarehouseBill()
        {
            _dalWarehouse = new DalWarehouseBill();
        }

        public DataTable GetWarehouseBillList()
        {
            return _dalWarehouse.GetWarehouseBillList();
        }
    }
}
