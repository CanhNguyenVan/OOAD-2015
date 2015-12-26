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
namespace QuanLyCuaHangLinhKienMayTinh
{
    public partial class frmManageChangingReturning : Form
    {
        ChangingReturningBLL bll = new ChangingReturningBLL();
        DataTable productList;
        string proId="";
        string reProId="";
        //số thứ tự sản phẩm trong danh sách
        public frmManageChangingReturning()
        {
            InitializeComponent();
        }
        // form load
        private void frmManageChangingReturning_Load(object sender, EventArgs e)
        {
            panelReturn.Enabled = false;
            // load danh sách nhóm sp
            LoadProductCategory(cbProductType);
            //Tải danh sách sản phẩm hiện có
            dgvProduct.DataSource = bll.GetAllProduct();
            lbResult.Text = "";
            pnCreateBill.Enabled = false;
            lbResultChanging.Text = "";
            lbResultReturning.Text = "";
           

        }
        //Lấy danh sách loại sản phẩm
        public void LoadProductCategory(ComboBox cb)
        {
            cb.Items.Add("Tất cả");
            DataTable dt = bll.GetProductCategory();
            int count = dt.Rows.Count;
            for (int i = 0; i < count; i++)
            {
                cb.Items.Add(dt.Rows[i][0]);
            }
            cb.SelectedIndex = 0;
        }
        //Lấy danh sách tên sản phẩm của bill
        public void LoadProductListofBill(ComboBox cb)
        {
            cbProductName.Items.Clear();
            lbResult.Text = "";
            productList = bll.GetProductListofBill("HD"+txtBillId.Text);
            int count = productList.Rows.Count;
            for (int i = 0; i < count; i++)
            {
                cb.Items.Add(productList.Rows[i][1]);
            }
            if (count == 0)
            {
               
                lbResult.Text = "Không tồn tại hóa đơn này";
                lbResult.ForeColor = Color.Red;
                return;
            }
            cb.SelectedIndex = 0;
        }
        //Chon radio box, đổi hay trả
        private void rgReturnChanging_SelectedIndexChanged(object sender, EventArgs e)
        {
           if(rgReturnChanging.SelectedIndex==0)
           {
               panelReturn.Enabled = false;
               panelChange.Enabled = true;
               panelReturn.BackColor = SystemColors.Control;
               panelChange.BackColor = SystemColors.ControlLightLight;
           }
           else {
               panelChange.Enabled = false;
               panelReturn.Enabled =true;
               panelReturn.BackColor = SystemColors.ControlLightLight;
               panelChange.BackColor = SystemColors.Control;
               dgvProduct.BackgroundColor = SystemColors.Control;
           }
        }
        // sự kiện nhập tên sản phẩm vào ô tìm kiếm
        private void txtSearchProductName_TextChanged(object sender, EventArgs e)
        {

        }
        // Nhấn nút Xem phí
        private void btnXemPhi_Click(object sender, EventArgs e)
        {
            
            lbResult.Text = "";
            int numRow=cbProductName.SelectedIndex;
            //Mã sản phẩm đổi/trả
            proId = productList.Rows[numRow][0].ToString();
            string proType = productList.Rows[numRow][2].ToString();
            string proPrice = productList.Rows[numRow][3].ToString();
            //set time
            if (txtBillId.Text != "") 
                txtTimeReturn.Text = bll.GetDayReturn("HD"+txtBillId.Text).ToString();
            // % phí
            float percentFee=bll.GetFeeChangeReturning(proType, "HD"+txtBillId.Text, int.Parse(txtTimeReturn.Text), cbErrorStatus.Text);
            if (percentFee==-1f)
            {
                lbResult.Text = "Phụ kiện đã mua quá 30 ngày, không thể đổi/trả";
                lbResult.ForeColor = Color.Red;
            }
            else
            {
                txtChangeReturnFee.Text = percentFee.ToString();
                // Giá sản phẩm cần đổi/trả
                string priceStr = productList.Rows[cbProductName.SelectedIndex][3].ToString();
                int price = int.Parse(priceStr.Substring(0, priceStr.IndexOf(".")));
                txtToCash.Text = ((int)((100-percentFee)/100 * price)).ToString();
            }
            btnLapPhieu.Enabled = true;
        }
        // Nhất nút xong sau khi nhập xong mã hóa đơn
        private void btnXong_Click(object sender, EventArgs e)
        {
            LoadProductListofBill(cbProductName);
          
        }
        // Nhất nút Lập phiếu
        private void btnLapPhieu_Click(object sender, EventArgs e)
        {
            pnCreateBill.Enabled = true;
            txtBillIdChange.Text = "HD" + txtBillId.Text;
            txtCusNameChange.Text = bll.GetCustomerName(txtBillIdChange.Text);
            txtProNameChange.Text = cbProductName.Text;
            //---------------------------------
            // Hiện dữ liệu phiếu trả
            //----------------------------------
            txtBillIdReturn.Text = txtBillIdChange.Text;
            txtCusNameReturn.Text = txtCusNameChange.Text;
            txtProductNameReturn.Text = txtProNameChange.Text;
            txtFeetoCusReturn.Text = txtToCash.Text;
        }

        private void dgvProduct_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            //----------------------------------
            // Hiện dữ liệu phiếu xuất
            //-----------------------------------
            // Tên sản phẩm thay thế
            txtProductReplace.Text = dgvProduct[1, e.RowIndex].Value.ToString();
            // Mã sản phẩm thay thế
            reProId = dgvProduct[0, e.RowIndex].Value.ToString();
            // Giá trị còn lại của sản phảm
            int priceLeft= int.Parse(txtToCash.Text);
            int priceReplace= bll.GetPriceProduct(dgvProduct[0, e.RowIndex].Value.ToString());
            txtFeetoCusChange.Text = (priceLeft > priceReplace ? priceLeft - priceReplace : 0).ToString();
            txtFeetoCompanyChange.Text = (priceLeft > priceReplace ? 0 : priceReplace - priceLeft).ToString();
            
        }
        // sự kiện nhấn xong combobox
        private void cbProductTypeChange_SelectedIndexChanged(object sender, EventArgs e)
        {
            //th1: không nhập tên sp, chọn loại là tất cả
            if (txtSearchProductName.Text == "" && cbProductType.Text == "Tất cả")
            {
                dgvProduct.DataSource = bll.GetAllProduct();
            }
            // TH2: không nhập tên sp, có chọn tên loại 
            else if (txtSearchProductName.Text == "")
            {
                dgvProduct.DataSource = bll.GetProductFollowCategory(cbProductType.Text);
            }
            // TH3: có nhập tên sản phẩm, chọn loại là tất cả
            else if (cbProductType.Text == "Tất cả")
            {
                dgvProduct.DataSource = bll.GetProductfromName(txtSearchProductName.Text);
            }
            // TH4: có nhập tên sản phẩm chọn loại sp xác định
            else
            {
                dgvProduct.DataSource = bll.GetProductListByCategoryProName(txtSearchProductName.Text, cbProductType.Text);
            }
        }
        private void btnSaveChange_Click(object sender, EventArgs e)
        {
            if (reProId == "")
            {
                lbResultChanging.Text = "Chưa chọn sản phẩm thay thế";
                lbResultChanging.ForeColor = Color.Red;
            }
            bll.AddChangingBill("HD"+txtBillId.Text, proId, reProId, int.Parse(txtFeetoCompanyChange.Text), int.Parse(txtFeetoCusChange.Text));
            lbResultChanging.Text = "Lưu thành công";
            lbResultChanging.ForeColor = Color.Green;

        }

        private void btnSaveReturn_Click(object sender, EventArgs e)
        {
            bll.AddReturningBill("HD"+txtBillId.Text, proId, int.Parse(txtFeetoCusReturn.Text));
            lbResultReturning.Text = "Lưu thành công";
            lbResultReturning.ForeColor = Color.Green;
        }
        






    }
}
