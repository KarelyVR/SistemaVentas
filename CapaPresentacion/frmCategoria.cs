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

namespace CapaPresentacion
{
    public partial class frmCategoria : Form
    {
        public frmCategoria()
        {
            InitializeComponent();
        }

        private void frmCategoria_Load(object sender, EventArgs e)
        {
            //valores por defecto del combobox estado
            cboestado.Items.Add(new OpcionCombo() { Valor = 1, Texto = "Activo" });
            cboestado.Items.Add(new OpcionCombo() { Valor = 2, Texto = "No activo" });

            //valores que despliega el combobox
            cboestado.DisplayMember = "Texto";
            cboestado.ValueMember = "Valor";
            cboestado.SelectedIndex = 0;

            //recorre los encabezados del datagrid para almacenarlos en el combobox busqueda
            foreach (DataGridViewColumn columna in dgvdata.Columns)
            {
                if (columna.Visible == true && columna.Name != "btnseleccionar")
                {
                    cbobusqueda.Items.Add(new OpcionCombo() { Valor = columna.Name, Texto = columna.HeaderText });
                }
            }
            //valores que despliega el combobox
            cbobusqueda.DisplayMember = "Texto";
            cbobusqueda.ValueMember = "Valor";
            cbobusqueda.SelectedIndex = 0;

            //Mostrar Lista de todos los usuarios
            List<Categoria> lista = new CN_Categoria().Listar();

            foreach (Categoria item in lista)
            {
                dgvdata.Rows.Add(new object[] {"",item.IdCategoria,
                    item.Descripcion,
                    item.Estado == true ? 1 : 0, 
                    item.Estado==true ? "Activo" : "No Activo"
                });
            }
        }

        private void label9_Click(object sender, EventArgs e)
        {

        }

        private void dgvdata_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvdata.Columns[e.ColumnIndex].Name == "btnseleccionar")
            {
                int indice = e.RowIndex;
                if (indice >= 0)
                {
                    txtindice.Text = indice.ToString();
                    //para cambiar en los textbox
                    txtid.Text = dgvdata.Rows[indice].Cells["Id"].Value.ToString();
                    txtdocumento.Text = dgvdata.Rows[indice].Cells["Descripcion"].Value.ToString();

                    //combobox estado
                    foreach (OpcionCombo oc in cboestado.Items)
                    {
                        if (Convert.ToInt32(oc.Valor) == Convert.ToInt32(dgvdata.Rows[indice].Cells["EstadoValor"].Value))
                        {
                            //obtener el indice del combobox
                            int indice_combo = cboestado.Items.IndexOf(oc);
                            cboestado.SelectedIndex = indice_combo;
                            break;
                        }
                    }
                }
            }
        }
        private void dgvdata_CellPainting(object sender, DataGridViewCellPaintingEventArgs e)
        {
            if (e.RowIndex < 0)
                return;
            if (e.ColumnIndex == 0)
            {
                e.Paint(e.CellBounds, DataGridViewPaintParts.All);
                //obtener el ancho
                var w = Properties.Resources.icheck.Width;
                //obtener alto

                var h = Properties.Resources.icheck.Height;
                //obtener posicion x
                var x = e.CellBounds.Left + (e.CellBounds.Width - w) / 2;
                //obtener posicion y
                var y = e.CellBounds.Top + (e.CellBounds.Height - h) / 2;

                //dibujar la imagen
                e.Graphics.DrawImage(Properties.Resources.icheck, new Rectangle(x, y, w, h));
                //dar permiso para dar permiso de clic
                e.Handled = true;
            }
        }

        private void label8_Click(object sender, EventArgs e)
        {

        }

        private void cboestado_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void btnguardar_Click(object sender, EventArgs e)
        {

        }

        private void btnlimpiarcampos_Click(object sender, EventArgs e)
        {
            txtbusqueda.Text = "";
            foreach (DataGridViewRow row in dgvdata.Rows)
            {
                row.Visible = true;
            }
        }

        private void btnbuscar_Click(object sender, EventArgs e)
        {
            string columnaFiltro = ((OpcionCombo)cbobusqueda.SelectedItem).Valor.ToString();

            if (dgvdata.Rows.Count > 0)
            {
                foreach (DataGridViewRow row in dgvdata.Rows)
                {
                    if (row.Cells[columnaFiltro].Value.ToString().Trim().ToUpper().Contains(txtbusqueda.Text.Trim().ToUpper()))
                        row.Visible = true;
                    else
                        row.Visible = false;
                }
            }
        }
    }
}
