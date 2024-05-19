using System;
using System.Collections.Generic;
using System.Linq;
using System.Drawing.Printing;
using System.Windows.Forms;
using Image = System.Drawing.Image;
using System.Drawing;

namespace CapaEntidad
{
    public class ConsultarFactura
    {
        public Factura Factura { get; set; }
        public Venta Venta { get; set; }
        public List<ProductosVenta> ProductosVenta { get; set; }
        public Image logo { get; set; }
        public string empresa { get; set; }
        public string direccion { get; set; }
        public string telefono { get; set; }
        public string vendedor { get; set; }

        private PrintDocument doc = new PrintDocument();
        private PrintPreviewDialog vista = new PrintPreviewDialog();

        public void imprimir(ConsultarFactura p)
        {
            // Configura el documento de impresión
            doc.PrinterSettings.PrinterName = doc.DefaultPageSettings.PrinterSettings.PrinterName;
            doc.PrintPage += new PrintPageEventHandler(imprimefactura);

            // Asigna el documento de impresión a la vista previa antes de mostrarla
            vista.Document = doc;

            // Muestra la vista previa de impresión
            if (Form.ActiveForm != null)
                vista.Show(Form.ActiveForm);
            else
                vista.Show();
        }
        public void imprimefactura(object sender, PrintPageEventArgs e)
        {
            int posX, posY;
            Font fuente = new Font("consola", 24, FontStyle.Bold);

            try
            {
                posX = 35;
                posY = 10;
                e.Graphics.DrawImage(logo, 30, 30, 150, 150);
                e.Graphics.DrawString(empresa, fuente, Brushes.Black, 200, 100);
                fuente = new Font("consola", 15, FontStyle.Bold);
                e.Graphics.DrawString(Factura.Fecha.ToString(), fuente, Brushes.Black, 540, 50);
                posY += 130;
                e.Graphics.DrawString(empresa, fuente, Brushes.Black, 650, posY);
                posY += 30;
                fuente = new Font("consola", 12, FontStyle.Bold);
                e.Graphics.DrawString(direccion, fuente, Brushes.Black, 330, posY);
                posY += 30;
                e.Graphics.DrawString(telefono, fuente, Brushes.Black, 700, posY);
                posY += 30;
                fuente = new Font("consola", 14, FontStyle.Bold);
                e.Graphics.DrawString("Vendedor: " + Factura.NombreCompleto, fuente, Brushes.Black, 35, posY);
                posY += 30;
                fuente = new Font("consola", 12, FontStyle.Bold);
                e.Graphics.DrawString("------------------------------------------------------------------------------------------------------------------------------", fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("FACTURA #" + Factura.IdFactura, fuente, Brushes.Black, posX, posY);
                posY += 50;
                fuente = new Font("consola", 10, FontStyle.Bold);
                e.Graphics.DrawString(Factura.NombreCliente + " " + Factura.PrimerApellido + " " + Factura.SegundoApellido, fuente, Brushes.Black, posX, posY);
                e.Graphics.DrawString(Factura.Telefono, fuente, Brushes.Black, 710, posY);
                posY += 20;
                e.Graphics.DrawString(Factura.RFC, fuente, Brushes.Black, posX, posY);
                e.Graphics.DrawString(Factura.Correo, fuente, Brushes.Black, 600, posY);
                posY += 20;
                e.Graphics.DrawString(Factura.Calle + " " + Factura.NumExt + " (" + Factura.NumInt + "), " + Factura.Colonia + ", " + Factura.Municipio, fuente, Brushes.Black, posX, posY);
                posY += 20;
                e.Graphics.DrawString("C.P. " + Factura.CP, fuente, Brushes.Black, posX, posY);
                posY += 20;
                fuente = new Font("consola", 12, FontStyle.Bold);
                e.Graphics.DrawString("------------------------------------------------------------------------------------------------------------------------------", fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("------------------------------------------------------------------------------------------------------------------------------", fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("PRODUCTO                                                            PRECIO                    CANT                    SUBTOTAL", fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("------------------------------------------------------------------------------------------------------------------------------", fuente, Brushes.Black, posX, posY);
                posY += 30;

                for (int i = 0; i < ProductosVenta.Count; i++)
                {
                    e.Graphics.DrawString(ProductosVenta[i].producto, fuente, Brushes.Black, posX, posY);
                    posY += 20;
                    e.Graphics.DrawString(espaciar(0, 75) + ProductosVenta[i].precio + espaciar(ProductosVenta[i].precio.ToString().Length, 35) + ProductosVenta[i].cantidad + espaciar(ProductosVenta[i].cantidad.ToString().Length, 35) + ProductosVenta[i].subtotal, fuente, Brushes.Black, posX, posY);
                    posY += 30;
                }
                e.Graphics.DrawString("------------------------------------------------------------------------------------------------------------------------------", fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("                                                                                                                            Monto Total: " + Venta.MontoTotal, fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("                                                                                                                            Pagó con: " + Venta.MontoPago, fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("                                                                                                                            Cambio: " + Venta.MontoCambio, fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("------------------------------------------------------------------------------------------------------------------------------", fuente, Brushes.Black, posX, posY);
                posY += 30;
                fuente = new Font("consola", 12, FontStyle.Bold);
                e.Graphics.DrawString("GRACIAS POR SU COMPRA!", fuente, Brushes.Black, 300, 1050);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public string espaciar(int tamaño, int valor)
        {
            string espacio = "";
            int subvalor = 0;
            subvalor = valor - tamaño;

            for (int i = 0; i < subvalor; i++)
            {
                espacio = espacio + " ";
            }
            return espacio;
        }
    }
}