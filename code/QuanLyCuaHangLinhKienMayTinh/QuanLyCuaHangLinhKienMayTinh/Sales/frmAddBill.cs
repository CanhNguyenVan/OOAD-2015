using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using BLL.Sales;

namespace QuanLyCuaHangLinhKienMayTinh.Sales
{
    public partial class frmAddBill : Form
    {
        AddBillBLL bll= new AddBillBLL();
        public frmAddBill()
        {
            InitializeComponent();
        }
        public void frmAddBill_Load(object sender, EventArgs e)
        {
            dgvCustomer.DataSource = bll.GetAllCustomer();
           dgvProduct.DataSource = bll.GetAllProduct();
        }
    }
}
