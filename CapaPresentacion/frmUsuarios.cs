using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using CapaPresentacion.Utilidades;
using CapaEntidad;
using CapaNegocio;

namespace CapaPresentacion
{
    public partial class frmUsuarios : Form
    {
        public frmUsuarios()
        {
            InitializeComponent();
        }

        private void frmUsuarios_Load(object sender, EventArgs e)
        {
            //valores por defecto del combobox estado
            cboestado.Items.Add(new OpcionCombo() { Valor = 1, Texto = "Activo" });
            cboestado.Items.Add(new OpcionCombo() { Valor = 2, Texto = "No activo" });

            //valores que despliega el combobox
            cboestado.DisplayMember = "Texto";
            cboestado.ValueMember = "Valor";
            cboestado.SelectedIndex = 0;

            //lista que despligea los valores de la tabla rol 
            List<Rol> listaRol = new CN_Rol().Listar();

            //valores por defecto del combobox Rol
            foreach (Rol item in listaRol)
            {
                cborol.Items.Add(new OpcionCombo() { Valor = item.IdRol, Texto = item.Descripcion });
            }
            //valores que despliega el combobox
            cborol.DisplayMember = "Texto";
            cborol.ValueMember = "Valor";
            cborol.SelectedIndex = 0;

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
            List<Usuario> listaUsuario = new CN_Usuario().Listar(); 

            foreach (Usuario item in listaUsuario)
            {
                dgvdata.Rows.Add(new object[] {"",item.IdUsuario,item.Documento,item.NombreCompleto,item.Correo,item.Clave,
                    item.oRol.IdRol,item.oRol.Descripcion,item.Estado == true ?1 : 0, item.Estado==true ?"Activo" : "No Activo"
                });
            }

        }

        private void btnguardar_Click(object sender, EventArgs e)
        {
            //if (txtnombre.Text!="" && txtclave.Text != "" && txtdocumento.Text != "" && txtcorreo.Text != "" && txtconfirmarclave.Text != "") 
            //{ 
            //    dgvdata.Rows.Add(new object[] {"",txtid.Text,txtdocumento.Text,txtnombre.Text,txtcorreo.Text,txtclave.Text,
            //        ((OpcionCombo)cborol.SelectedItem).Valor.ToString(),
            //        ((OpcionCombo)cborol.SelectedItem).Texto.ToString(),
            //        ((OpcionCombo)cboestado.SelectedItem).Valor.ToString(),
            //        ((OpcionCombo)cboestado.SelectedItem).Texto.ToString()
            //    });
                
            //    Limpiar();
            //}
            //else
            //{
            //    MessageBox.Show("Falta de llenar algun dato", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            //}

        }

        //metodo para limpiar los controles
        private void Limpiar()
        {
            txtindice.Text = "-1";
            txtid.Text = "0";
            txtnombre.Text = "";
            txtdocumento.Text = "";
            txtcorreo.Text = "";
            txtclave.Text = "";
            txtconfirmarclave.Text = "";
            cborol.SelectedIndex = 0;
            cboestado.SelectedIndex = 0;
        }

        private void dgvdata_CellPainting(object sender, DataGridViewCellPaintingEventArgs e)
        {
            if (e.RowIndex < 0)
                return;
            if(e.ColumnIndex == 0)
            {
                e.Paint(e.CellBounds,DataGridViewPaintParts.All);
                //obtener el ancho
                var w = Properties.Resources.icheck.Width;
                //obtener alto

                var h = Properties.Resources.icheck.Height;
                //obtener posicion x
                var x = e.CellBounds.Left + (e.CellBounds.Width - w)/2;
                //obtener posicion y
                var y = e.CellBounds.Top + (e.CellBounds.Height - h) / 2;

                //dibujar la imagen
                e.Graphics.DrawImage(Properties.Resources.icheck, new Rectangle(x, y, w, h));
                //dar permiso para dar permiso de clic
                e.Handled = true;
            }
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
                    txtdocumento.Text = dgvdata.Rows[indice].Cells["Documento"].Value.ToString();
                    txtnombre.Text = dgvdata.Rows[indice].Cells["NombreCompleto"].Value.ToString();
                    txtcorreo.Text = dgvdata.Rows[indice].Cells["Correo"].Value.ToString();
                    txtclave.Text = dgvdata.Rows[indice].Cells["Clave"].Value.ToString();
                    txtconfirmarclave.Text = dgvdata.Rows[indice].Cells["Clave"].Value.ToString();

                    //para cambiar en los combobox
                    //combobox rol
                    foreach (OpcionCombo oc in cborol.Items)
                    {
                        if(Convert.ToInt32(oc.Valor) == Convert.ToInt32(dgvdata.Rows[indice].Cells["IdRol"].Value))
                        {
                            //obtener el indice del combobox
                            int indice_combo = cborol.Items.IndexOf(oc);
                            cborol.SelectedIndex = indice_combo;
                            break;
                        }
                    }

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
    }
}
