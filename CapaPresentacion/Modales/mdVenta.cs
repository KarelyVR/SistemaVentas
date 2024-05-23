using CapaEntidad;
using CapaNegocio;
using CapaPresentacion.Utilidades;
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
    public partial class mdVenta : Form
    {
        public Venta _Venta { get; set; }
        public mdVenta()
        {
            InitializeComponent();
        }

        private void mdVenta_Load(object sender, EventArgs e)
        {

            List<Venta> lista = new CN_Venta().Listar();

            foreach (Venta item in lista)
            {
                dgvdata.Rows.Add(new object[]
                {
                    item.IdVenta,
                    item.NumeroDocumento,
                    item.TipoDocumento,
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
                _Venta = new Venta()
                {
                    NumeroDocumento = dgvdata.Rows[iRow].Cells["NumeroDocumento"].Value.ToString()
                };
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
        }
    }
}