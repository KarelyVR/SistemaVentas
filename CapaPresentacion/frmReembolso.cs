using CapaEntidad;
using CapaNegocio;
using CapaPresentacion.Modales;
using DocumentFormat.OpenXml.Vml;
using DocumentFormat.OpenXml.Wordprocessing;
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
    public partial class frmReembolso : Form
    {
        public frmReembolso()
        {
            InitializeComponent();
            NumericUpDownColumn numCol = new NumericUpDownColumn();
            numCol.HeaderText = "Rembolso";
            numCol.Name = "numericColumn";
            dgvdata.Columns.Insert(2, numCol);
        }

        List<Detalle_Venta> cantidades = new List<Detalle_Venta>();

        private void btnbuscar_Click(object sender, EventArgs e)
        {
            using (var modal = new mdVenta())
            {
                var result = modal.ShowDialog();
                if (result == DialogResult.OK)
                {
                    txtnumerodocumento.Text = modal._Venta.NumeroDocumento.ToString();
                }
            }

            Venta oVenta = new CN_Venta().ObtenerVenta(txtnumerodocumento.Text);
            cantidades = oVenta.oDetalle_Venta;

            if (oVenta.IdVenta != 0)
            {
                txtnumerodocumento.Text = oVenta.NumeroDocumento;
                txtfecha.Text = oVenta.FechaRegistro;
                txttipodocumento.Text = oVenta.TipoDocumento;
                txtusuario.Text = oVenta.oUsuario.NombreCompleto;

                dgvdata.Rows.Clear();
                foreach (Detalle_Venta dv in oVenta.oDetalle_Venta)
                {
                    dgvdata.Rows.Add(new object[] { dv.oProducto.Nombre, dv.Cantidad, 0, dv.PrecioVenta, 0 , dv.oProducto.Codigo});
                }
            }
        }

        private void dgvdata_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            DataGridView dgv = sender as DataGridView;

            if (dgv.Columns[e.ColumnIndex].Name == "numericColumn")
            {
                string rembolsados = dgv.Rows[e.RowIndex].Cells[e.ColumnIndex].Value.ToString();
                if (int.Parse(rembolsados) > cantidades[dgv.Rows[e.RowIndex].Index].Cantidad)
                    dgv.Rows[e.RowIndex].Cells[e.ColumnIndex].Value = (decimal)cantidades[dgv.Rows[e.RowIndex].Index].Cantidad;
                var precio = (decimal)dgv.Rows[e.RowIndex].Cells[3].Value;
                dgv.Rows[e.RowIndex].Cells[dgv.Columns.Count - 1].Value = (decimal)dgv.Rows[e.RowIndex].Cells[e.ColumnIndex].Value * precio;
                var modif = dgv.Rows[e.RowIndex].Cells[e.ColumnIndex].Value.ToString();
                int modifInt = int.Parse(modif);
                // Actualizar la cantidad disponible
                dgv.Rows[e.RowIndex].Cells[1].Value = (object)(cantidades[dgv.Rows[e.RowIndex].Index].Cantidad - modifInt);
            }
            decimal total = 0;

            foreach (DataGridViewRow row in dgv.Rows)
            {
                if (row.Cells[4].Value != null)
                {
                    decimal value;
                    if (decimal.TryParse(row.Cells[4].Value.ToString(), out value))
                    {
                        total += value;
                    }
                }
            }

            txtmontototal.Text = total.ToString();
        }

        private void dgvdata_CurrentCellDirtyStateChanged(object sender, EventArgs e)
        {
            DataGridView dgv = sender as DataGridView;

            if (dgv.IsCurrentCellDirty)
            {
                dgv.CommitEdit(DataGridViewDataErrorContexts.Commit);
            }
        }

        private void dgvdata_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
        {
            if (e.Control is NumericUpDown)
            {
                NumericUpDown numericUpDown = e.Control as NumericUpDown;
                numericUpDown.ValueChanged -= NumericUpDown_ValueChanged; 
                numericUpDown.ValueChanged += NumericUpDown_ValueChanged; 

                // Obtener el índice de la fila y la columna actual
                int rowIndex = dgvdata.CurrentCell.RowIndex;
                int colIndex = dgvdata.CurrentCell.ColumnIndex;

                // Establecer el valor máximo del NumericUpDown basado en la cantidad disponible
                int cantidadDisponible = (int)dgvdata.Rows[rowIndex].Cells[1].Value;
                numericUpDown.Maximum = cantidadDisponible;
            }
        }

        // Actualizar el DataGridView cuando el valor del NumericUpDown cambia
        private void NumericUpDown_ValueChanged(object sender, EventArgs e)
        {
            NumericUpDown numericUpDown = sender as NumericUpDown;
            DataGridView dgv = this.Controls.OfType<DataGridView>().FirstOrDefault();

            if (dgv != null)
            {
                int rowIndex = dgv.CurrentCell.RowIndex;
                int colIndex = dgv.CurrentCell.ColumnIndex;

                // Asegurarse de que el evento CellValueChanged se dispare
                dgv.NotifyCurrentCellDirty(true);

                // Actualizar la última columna con el nuevo valor
                var precio = (decimal)dgv.Rows[rowIndex].Cells[3].Value;
                dgv.Rows[rowIndex].Cells[dgv.Columns.Count - 1].Value = numericUpDown.Value * precio;

                // Actualizar la cantidad disponible
                int cantidadInicial = (int)dgv.Rows[rowIndex].Cells[1].Value + (int)dgv.Rows[rowIndex].Cells[colIndex].Value;
                dgv.Rows[rowIndex].Cells[1].Value = cantidadInicial - (int)numericUpDown.Value;
            }
        }


        private void dgvdata_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
        }

        private void txtmontototal_TextChanged(object sender, EventArgs e)
        {

        }

        private void btnguardar_Click(object sender, EventArgs e)
        {
            int j = 0;
            for (int i = 0; i < dgvdata.Rows.Count; i++)
            {
                
                // Suponiendo que los valores que necesitas están en la segunda y cuarta columna
                string IdProducto = dgvdata.Rows[i].Cells[0].Value.ToString(); // Segunda columna
                //int cantidad = (int)dgvdata.Rows[i].Cells[2].Value; // Cuarta columna
                
                // Verificar si la celda no es null y convertir de manera segura
                object cellValue = dgvdata.Rows[i].Cells[2].Value;
                int cantidad;

                if (cellValue != null && int.TryParse(cellValue.ToString(), out cantidad))
                {
                    // Crear un nuevo objeto Valores y añadirlo a la lista
                    CN_Reembolso reembolso = new CN_Reembolso();
                    j += reembolso.RealizarReembolso(IdProducto, cantidad);
                }
                else
                {
                    // Manejar el caso donde la conversión no es posible (opcional)
                    MessageBox.Show($"Error al convertir la cantidad en la fila {i + 1}");
                    return; // Salir del método si hay un error de conversión
                }

                //// Crear un nuevo objeto Valores y añadirlo a la lista
                //CN_Reembolso reembolso = new CN_Reembolso();
                //j += reembolso.RealizarReembolso(IdProducto, (int)cantidad);
            }
            if(j>0)
                MessageBox.Show("Reembolso exitoso");
                txtfecha.Text = "";
                txtnumerodocumento.Text = "";
                txttipodocumento.Text = "";
                txtusuario.Text = "";
                txtmontototal.Text = "";
                dgvdata.Rows.Clear();   
        }
    }





    public class NumericUpDownColumn : DataGridViewColumn
    {
        public NumericUpDownColumn() : base(new NumericUpDownCell())
        {
        }
    }

    public class NumericUpDownCell : DataGridViewTextBoxCell
    {
        public NumericUpDownCell() : base()
        {
            this.Style.Format = "N0"; // Establece el formato de la celda
        }

        public override void InitializeEditingControl(int rowIndex, object initialFormattedValue, DataGridViewCellStyle dataGridViewCellStyle)
        {
            base.InitializeEditingControl(rowIndex, initialFormattedValue, dataGridViewCellStyle);
            NumericUpDownEditingControl ctl = DataGridView.EditingControl as NumericUpDownEditingControl;
            if (this.Value == null || this.Value == DBNull.Value)
            {
                ctl.Value = ctl.Minimum;
            }
            else
            {
                ctl.Value = Convert.ToDecimal(this.Value);
            }
        }

        public override Type EditType
        {
            get { return typeof(NumericUpDownEditingControl); }
        }

        public override Type ValueType
        {
            get { return typeof(decimal); }
        }

        public override object DefaultNewRowValue
        {
            get { return 0m; }
        }
    }

    public class NumericUpDownEditingControl : NumericUpDown, IDataGridViewEditingControl
    {
        private DataGridView dataGridView;
        private bool valueChanged = false;
        private int rowIndex;

        public object EditingControlFormattedValue
        {
            get { return this.Value.ToString("N0"); }
            set { this.Value = int.Parse((string)value); }
        }

        public object GetEditingControlFormattedValue(DataGridViewDataErrorContexts context)
        {
            return EditingControlFormattedValue;
        }

        public void ApplyCellStyleToEditingControl(DataGridViewCellStyle dataGridViewCellStyle)
        {
            this.Font = dataGridViewCellStyle.Font;
            this.ForeColor = dataGridViewCellStyle.ForeColor;
            this.BackColor = dataGridViewCellStyle.BackColor;
        }

        public int EditingControlRowIndex
        {
            get { return rowIndex; }
            set { rowIndex = value; }
        }

        public bool EditingControlWantsInputKey(Keys keyData, bool dataGridViewWantsInputKey)
        {
            return (keyData & Keys.KeyCode) == Keys.Left ||
                   (keyData & Keys.KeyCode) == Keys.Up ||
                   (keyData & Keys.KeyCode) == Keys.Down ||
                   (keyData & Keys.KeyCode) == Keys.Right;
        }

        public void PrepareEditingControlForEdit(bool selectAll)
        {
        }

        public bool RepositionEditingControlOnValueChange
        {
            get { return false; }
        }

        public DataGridView EditingControlDataGridView
        {
            get { return dataGridView; }
            set { dataGridView = value; }
        }

        public bool EditingControlValueChanged
        {
            get { return valueChanged; }
            set { valueChanged = value; }
        }

        public Cursor EditingPanelCursor
        {
            get { return base.Cursor; }
        }

        protected override void OnValueChanged(EventArgs e)
        {
            valueChanged = true;
            this.EditingControlDataGridView.NotifyCurrentCellDirty(true);
            base.OnValueChanged(e);
        }
    }

}
