using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Warehouse;

namespace BLL.Warehouse
{
    public class BllDistributor
    {
        private DalDistributor _dalDistributor;

        public BllDistributor()
        {
            _dalDistributor = new DalDistributor();
        }
        public DataTable GetDistributorList()
        {
            return _dalDistributor.GetDistributorList();
        }
    }
}
