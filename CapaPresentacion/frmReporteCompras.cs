using CapaEntidad;
using CapaNegocio;
using CapaPresentacion.Utilidades;
using ClosedXML.Excel;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using iTextSharp.text;


namespace CapaPresentacion
{
    public partial class frmReporteCompras : Form
    {
        public frmReporteCompras()
        {
            InitializeComponent();
        }

        private void frmReporteCompras_Load(object sender, EventArgs e)
        {
            List<Proveedor> lista = new CN_Proveedor().Listar();

            cboproveedor.Items.Add(new OpcionCombo() { Valor = 0, Texto = "TODOS" });
            foreach (Proveedor item in lista)
            {
                cboproveedor.Items.Add(new OpcionCombo() { Valor = item.IdProveedor, Texto = item.RazonSocial });
            }
            cboproveedor.DisplayMember = "Texto";
            cboproveedor.ValueMember = "Valor";
            cboproveedor.SelectedIndex = 0;

            foreach (DataGridViewColumn columna in dgvdata.Columns)
            {
                cbobusqueda.Items.Add(new OpcionCombo() { Valor = columna.Name, Texto = columna.HeaderText });
            }
            cbobusqueda.DisplayMember = "Texto";
            cbobusqueda.ValueMember = "Valor";
            cbobusqueda.SelectedIndex = 0;


        }

        private void btnbuscarproveedor_Click(object sender, EventArgs e)
        {
            int idproveedor = Convert.ToInt32(((OpcionCombo)cboproveedor.SelectedItem).Valor.ToString());

            List<ReporteCompra> lista = new List<ReporteCompra>();

            lista = new CN_Reporte().Compra(
                txtfechainicio.Value.ToString(),
                txtfechafin.Value.ToString(),
                idproveedor
                );

            dgvdata.Rows.Clear();

            foreach (ReporteCompra rc in lista)
            {
                dgvdata.Rows.Add(new object[]{
                    rc.FechaRegistro,
                    rc.TipoDocumento,
                    rc.NumeroDocumento,
                    rc.MontoTotal,
                    rc.UsuarioRegistro,
                    rc.DocumentoProveedor,
                    rc.RazonSocial,
                    rc.CodigoProducto,
                    rc.NombreProducto,
                    rc.Categoria,
                    rc.PrecioCompra,
                    rc.PrecioVenta,
                    rc.Cantidad,
                    rc.SubTotal
                });
            }
        }

        private void btndescargarexcel_Click(object sender, EventArgs e)
        {
            if (dgvdata.Rows.Count < 1)
            {
                MessageBox.Show("No se encontraron resultados", "Mensaje", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }
            string Texto_Html = "<!DOCTYPE html>\r\n<html>\r\n<head>\r\n    <title>Web Page Design</title>\r\n    <style>\r\n        table.border {\r\n            border-collapse: collapse;\r\n        }\r\n\r\n            table.border th {\r\n                text-align: center;\r\n                padding: 5px;\r\n                border: 1px solid black;\r\n            }\r\n\r\n            table.border td {\r\n                text-align: center;\r\n                padding: 5px;\r\n                border: 1px solid black;\r\n            }\r\n    </style>\r\n</head>\r\n<body>\r\n    <table border=\"0\" style=\"width:100%\">\r\n        <tr>\r\n\r\n            <td style=\"width:15%\" valign=\"top\"></td>\r\n            <td style=\"width:60%\" valign=\"top\" align=\"center\">\r\n\r\n                <label style=\"font-size:20px;font-weight:bold;margin-bottom:10px\">Abarrotes</label><br />\r\n                <div style=\"height:12px !important\"></div>\r\n                <label style=\"font-size:11px;\">Dirección: Calle San Rafael #219 Col. Arcángeles, Allende, Nuevo León.</label><br />\r\n            </td>\r\n            <td style=\"width:25%;\" align=\"right\" valign=\"top\">\r\n\r\n            </td>\r\n        </tr>\r\n    </table>\r\n    <div style=\"height:15px !important\"></div>\r\n    <hr />\r\n\r\n    <table border=\"0\" style=\"width:100%\">\r\n        <tr><td><h3>Reporte de Compras</h3></td></tr>\r\n\t\t<tr>\r\n\t\t\t<td style=\"width:20%\"><label style=\"font-size:12px;font-weight:bold\">Fecha@inicio:</label></td>\r\n            <td style=\"width:20%\"><label style=\"font-size:12px;\">@fechainicio</label></td>\r\n        </tr>\r\n        <tr>\r\n            @fechafin\r\n        </tr>\r\n\r\n\r\n    </table>\r\n    <div style=\"height:15px !important\"></div>\r\n  <p>Proveedor: @proveedor</p>  <table style=\"width:100%;font-size:12px;\" class=\"border\">\r\n        <thead>\r\n            <tr style=\"background-color:#CACACA\"> <th>Fecha regisro</th><th>Tipo Documento</th><th>Numero documento</th><th>Monto total</th><th>Usuario registro</th><th>Documento Proveedor</th><th>Razon social</th><th>Codigo producto</th><th>Nombre producto</th><th>Categoria</th><th>Precio Compra</th><th>Precio Venta</th><th>Cantidad</th><th>Subtotal</th>  </tr>\r\n        </thead>\r\n        <tbody>\r\n            @filas\r\n        </tbody>\r\n    </table>\r\n\r\n    <div style=\"height:15px !important\"></div>\r\n    <table style=\"width:35%;font-size:12px;\" class=\"border\">\r\n        <thead>\r\n            <tr style=\"background-color:#CACACA\">\r\n                <th>Monto Total</th>\r\n            </tr>\r\n        </thead>\r\n        <tbody>\r\n            <tr>\r\n                <td>@montototal</td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n</body>\r\n</html>";

            if (txtfechainicio.Text != txtfechafin.Text)
            {
                Texto_Html = Texto_Html.Replace("@inicio", " inicio");
                Texto_Html = Texto_Html.Replace("@fechainicio", txtfechainicio.Text);
                string fecha = txtfechafin.Text;
                string fechafin = "<td style = \"width:20%\"><label style=\"font-size:12px;font-weight:bold\">Fecha Fin:</label></td>\r\n" +
                    $"<td style=\"width:20%\"><label style =\"font-size:12px;\">{fecha}</label></ td >";
                Texto_Html = Texto_Html.Replace("@fechafin", fechafin);

            }
            else
            {
                Texto_Html = Texto_Html.Replace("@inicio", "");
                Texto_Html = Texto_Html.Replace("@fechainicio", txtfechainicio.Text);
                Texto_Html = Texto_Html.Replace("@fechafin", "");
            }
            Texto_Html = Texto_Html.Replace("@proveedor", cboproveedor.Text);
            double montoTotal = 0;
            string filas = string.Empty;
            foreach (DataGridViewRow row in dgvdata.Rows)
            {
                if (row.Visible == true)
                {
                    filas += "<tr>";
                    filas += "<td>" + row.Cells[0].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[1].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[2].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[3].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[4].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[5].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[6].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[7].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[8].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[9].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[10].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[11].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[12].Value.ToString() + "</td>";
                    filas += "<td>" + row.Cells[13].Value.ToString() + "</td>";
                    filas += "</tr>";
                }
                montoTotal += double.Parse(row.Cells[13].Value.ToString());
            }
            Texto_Html = Texto_Html.Replace("@filas", filas);
            Texto_Html = Texto_Html.Replace("@montototal", montoTotal.ToString());

            SaveFileDialog savefile = new SaveFileDialog();
            savefile.FileName = string.Format("ReporteVenta.pdf");
            savefile.Filter = "Pdf Files|*.pdf";

            if (savefile.ShowDialog() == DialogResult.OK)
            {
                using (FileStream stream = new FileStream(savefile.FileName, FileMode.Create))
                {

                    Document pdfDoc = new Document(PageSize.A4, 25, 25, 25, 25);

                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, stream);
                    pdfDoc.Open();

                    using (StringReader sr = new StringReader(Texto_Html))
                    {
                        XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
                    }

                    pdfDoc.Close();
                    stream.Close();
                    MessageBox.Show("Documento Generado", "Mensaje", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
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

        private void btnlimpiar_Click(object sender, EventArgs e)
        {
            txtbusqueda.Text = "";
            foreach (DataGridViewRow row in dgvdata.Rows)
            {
                row.Visible = true;
            }
        }
    }
}
