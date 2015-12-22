using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using BLL.Warehouse;

namespace QuanLyCuaHangLinhKienMayTinh.Warehouse
{
    public partial class frmWarehouseBill : Form
    {
        private BllWarehouseBill _bllWarehouseBill;
        private BllWarehouseBillDetail _bllWarehouseBillDetail;

        public frmWarehouseBill()
        {
            InitializeComponent();
            Load += FrmWarehouseBill_Load;
        }

        private void FrmWarehouseBill_Load(object sender, EventArgs e)
        {
            _bllWarehouseBill = new BllWarehouseBill();
            _bllWarehouseBillDetail = new BllWarehouseBillDetail();
            LoadDgvWarehouseBillList();
        }


        #region Initialize

        private void LoadDgvWarehouseBillList()
        {
            dgvWarehouseBill.DataSource = _bllWarehouseBill.GetWarehouseBillList();
        }
        #endregion

        #region Feature Function

        private string CreateNewWarehouseBillID()
        {
            return DateTime.Now.ToString("yyyy-mm-dd HH:mm:ss").
                Replace(" ", "").
                Replace("-", "").
                Replace(":", "");
        }
        #endregion

        private void dgvWarehouseBill_SelectionChanged(object sender, EventArgs e)
        {
            string id = dgvWarehouseBill.CurrentRow.Cells[0].Value.ToString();
            dgvDetailWarehouseBill.DataSource = _bllWarehouseBillDetail.GetWarehouseBillDetailWithWarehouseBillID(id);
            txtTotal.Text = _bllWarehouseBillDetail.SumTotal(id).ToString();
        }

        private void panel6_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}
