using CapaEntidad;
using CapaNegocio;
using CapaPresentacion.Utilidades;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using System;
using System.Collections.Generic;
using System.IO;
using System.Windows.Forms;
using iTextSharp.text;



namespace CapaPresentacion
{
    public partial class frmReporteVentas : Form
    {
        public frmReporteVentas()
        {
            InitializeComponent();
        }

        private void frmReporteVentas_Load(object sender, EventArgs e)
        {
            foreach (DataGridViewColumn columna in dgvdata.Columns)
            {
                cbobusqueda.Items.Add(new OpcionCombo() { Valor = columna.Name, Texto = columna.HeaderText });
            }
            cbobusqueda.DisplayMember = "Texto";
            cbobusqueda.ValueMember = "Valor";
            cbobusqueda.SelectedIndex = 0;
        }

        private void btnbuscarreporte_Click(object sender, EventArgs e)
        {
            List<ReporteVenta> lista = new List<ReporteVenta>();

            lista = new CN_Reporte().Venta(txtfechainicio.Value.ToString(),txtfechafin.Value.ToString());

            dgvdata.Rows.Clear();

            foreach(ReporteVenta rv in lista)
            {
                dgvdata.Rows.Add(new object[]{
                    rv.FechaRegistro,
                    rv.TipoDocumento,
                    rv.NumeroDocumento,
                    rv.MontoTotal,
                    rv.UsuarioRegistro,
                    rv.CodigoProducto,
                    rv.NombreProducto,
                    rv.Categoria,
                    rv.PrecioVenta,
                    rv.Cantidad,
                    rv.SubTotal
                });
            }
        }

        private void btnbuscar_Click(object sender, EventArgs e)
        {
            
        }

        private void txtbusqueda_TextChanged(object sender, EventArgs e)
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

        private void btndescargarexcel_Click(object sender, EventArgs e)
        {
            if (dgvdata.Rows.Count < 1)
            {
                MessageBox.Show("No se encontraron resultados", "Mensaje", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }
            string Texto_Html = "<!DOCTYPE html>\r\n<html>\r\n<head>\r\n    <title>Web Page Design</title>\r\n    <style>\r\n        table.border {\r\n            border-collapse: collapse;\r\n        }\r\n\r\n            table.border th {\r\n                text-align: center;\r\n                padding: 5px;\r\n                border: 1px solid black;\r\n            }\r\n\r\n            table.border td {\r\n                text-align: center;\r\n                padding: 5px;\r\n                border: 1px solid black;\r\n            }\r\n    </style>\r\n</head>\r\n<body>\r\n    <table border=\"0\" style=\"width:100%\">\r\n        <tr>\r\n\r\n            <td style=\"width:15%\" valign=\"top\"></td>\r\n            <td style=\"width:60%\" valign=\"top\" align=\"center\">\r\n\r\n                <label style=\"font-size:20px;font-weight:bold;margin-bottom:10px\">Abarrotes</label><br />\r\n                <div style=\"height:12px !important\"></div>\r\n                <label style=\"font-size:11px;\">Dirección: Calle San Rafael #219 Col. Arcángeles, Allende, Nuevo León.</label><br />\r\n            </td>\r\n            <td style=\"width:25%;\" align=\"right\" valign=\"top\">\r\n\r\n            </td>\r\n        </tr>\r\n    </table>\r\n    <div style=\"height:15px !important\"></div>\r\n    <hr />\r\n\r\n    <table border=\"0\" style=\"width:100%\">\r\n        <tr><td><h3>Reporte de Ventas</h3></td></tr>\r\n\t\t<tr>\r\n\t\t\t<td style=\"width:20%\"><label style=\"font-size:12px;font-weight:bold\">Fecha@inicio:</label></td>\r\n            <td style=\"width:20%\"><label style=\"font-size:12px;\">@fechainicio</label></td>\r\n        </tr>\r\n        <tr>\r\n            @fechafin\r\n        </tr>\r\n\r\n\r\n    </table>\r\n    <div style=\"height:15px !important\"></div>\r\n    <table style=\"width:100%;font-size:12px;\" class=\"border\">\r\n        <thead>\r\n            <tr style=\"background-color:#CACACA\">\r\n                <th>Fecha registro</th>\r\n\t\t\t\t<th>Tipo Documento</th>\r\n                <th>Numero documento</th>\r\n                <th>Monto total</th>\r\n                <th>Usuario registro</th>\r\n                <th>Codigo producto</th>\r\n                <th>Nombre producto</th>\r\n                <th>Categoria</th>\r\n                <th>Precio Venta</th>\r\n                <th>Cantidad</th>\r\n                <th>Subtotal</th>\r\n            </tr>\r\n        </thead>\r\n        <tbody>\r\n            @filas\r\n        </tbody>\r\n    </table>\r\n\r\n    <div style=\"height:15px !important\"></div>\r\n    <table style=\"width:35%;font-size:12px;\" class=\"border\">\r\n        <thead>\r\n            <tr style=\"background-color:#CACACA\">\r\n                <th>Monto Total</th>\r\n            </tr>\r\n        </thead>\r\n        <tbody>\r\n            <tr>\r\n                <td>@montototal</td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n</body>\r\n</html>";

            if (txtfechainicio != txtfechafin)
            {
                Texto_Html = Texto_Html.Replace("@inicio", " inicio");
                Texto_Html = Texto_Html.Replace("@fechainicio", txtfechainicio.Text);
                string fechafin = "<td style = \"width:20%\"><label style=\"font-size:12px;font-weight:bold\">Fecha Fin:</label></td>\r\n" +
                    $"<td style=\"width:20%\"><label style =\"font-size:12px;\">{txtfechafin.Text}</label></ td >";
                Texto_Html = Texto_Html.Replace("@fechafin", fechafin);

            }
            else
            {
                Texto_Html = Texto_Html.Replace("@inicio", "");
                Texto_Html = Texto_Html.Replace("@fechainicio", txtfechainicio.Text);
                Texto_Html = Texto_Html.Replace("@fechafin", "");
            }

            double montoTotal = 0;
            string filas = string.Empty;
            foreach (DataGridViewRow row in dgvdata.Rows)
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
                filas += "</tr>";
                
                montoTotal += double.Parse(row.Cells[10].Value.ToString());
            }
            Texto_Html = Texto_Html.Replace("@filas", filas);
            Texto_Html = Texto_Html.Replace("@montototal", montoTotal.ToString());

            SaveFileDialog savefile = new SaveFileDialog();
            savefile.FileName = string.Format("ReporteVenta_{0}.pdf", System.DateTime.Now.ToString("d"));
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
    }
}



