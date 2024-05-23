using CapaEntidad;
using CapaNegocio;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaPresentacion.Modales
{
    public partial class mdCompra : Form
    {
        public Compra _Compra {  get; set; }
        public mdCompra()
        {
            InitializeComponent();
        }

        private void mdCompra_Load(object sender, EventArgs e)
        {

            List<Compra> lista = new CN_Compra().Listar();

            foreach (Compra item in lista)
            {
                dgvdata.Rows.Add(new object[]
                {
                    item.IdCompra,
                    item.NumeroDocumento,
                    item.TipoDocumento,
                    item.oProveedor.IdProveedor,
                    item.oProveedor.RazonSocial,
                    item.oUsuario.IdUsuario,
                    item.oUsuario.NombreCompleto,
                    item.MontoTotal,
                    item.FechaRegistro,
                });
            }
        }

        private void dgvdata_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            int iRow = e.RowIndex;
            int iColum = e.ColumnIndex;
            if (iRow >= 0 && iColum > 0)
            {
                _Compra = new Compra()
                {
                    NumeroDocumento = dgvdata.Rows[iRow].Cells["NumeroDocumento"].Value.ToString()
                };
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
        }
    }
}