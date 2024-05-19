using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.Drawing.Printing;
using System.Windows.Controls;
using Image = System.Drawing.Image;
using System.Windows.Forms;
using CapaEntidad;

namespace CapaNegocio
{
    public class CrearTicket
    {
        public string empresa {  get; set; }
        public string direccion { get; set;}
        public string telefono { get; set;}
        public string fecha { get; set; }
        public string vendedor { get; set; }
        public Image logo { get; set;}

        public string MontoTotal { get; set; }

        public string MontoPagoCon { get; set; }

        public string MontoCambio { get; set; }

        public List<ProductosVenta> listaProductos = new List<ProductosVenta>();

        private PrintDocument doc = new PrintDocument();
        private PrintPreviewDialog vista = new PrintPreviewDialog();

        public void imprimir(CrearTicket p)
        {
            // Configura el documento de impresión
            doc.PrinterSettings.PrinterName = doc.DefaultPageSettings.PrinterSettings.PrinterName;
            doc.PrintPage += new PrintPageEventHandler(imprimeticket);

            // Asigna el documento de impresión a la vista previa antes de mostrarla
            vista.Document = doc;

            // Muestra la vista previa de impresión
            if (Form.ActiveForm != null)
                vista.Show(Form.ActiveForm);
            else
                vista.Show();
        }


        public void imprimeticket(object sender, PrintPageEventArgs e)
        {
            int posX, posY;
            Font fuente = new Font("consola", 15, FontStyle.Bold);
            
            try
            {
                posX = 10;
                posY = 10;
                e.Graphics.DrawImage(logo, 15, 20, 100, 100);
                e.Graphics.DrawString(fecha, fuente, Brushes.Black, 115, posY);
                posY += 110;
                e.Graphics.DrawString(empresa, fuente, Brushes.Black, posX, posY);
                posY += 30;
                fuente = new Font("consola", 8, FontStyle.Bold);
                e.Graphics.DrawString(direccion, fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString(telefono, fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("Vendedor: " + vendedor, fuente, Brushes.Black, posX, posY);
                posY += 30;
                fuente = new Font("consola", 9, FontStyle.Bold);
                e.Graphics.DrawString("-------------------------------------------------------------------------", fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("PRODUCTO               PRECIO     CANT     SUBTOTAL", fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("-------------------------------------------------------------------------", fuente, Brushes.Black, posX, posY);
                posY += 30;

                for (int i = 0; i <listaProductos.Count; i++)
                {
                    e.Graphics.DrawString(listaProductos[i].producto, fuente, Brushes.Black, posX, posY);
                    posY += 20;
                    e.Graphics.DrawString(espaciar(0,36) + listaProductos[i].precio + espaciar(listaProductos[i].precio.ToString().Length, 18) + listaProductos[i].cantidad + espaciar(listaProductos[i].cantidad.ToString().Length, 18) + listaProductos[i].subtotal, fuente, Brushes.Black, posX, posY);
                    posY += 30;
                }
                e.Graphics.DrawString("-------------------------------------------------------------------------", fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("                                                Monto Total: " + MontoTotal, fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("                                                Pagó con: " + MontoPagoCon, fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("                                                Cambio: " + MontoCambio, fuente, Brushes.Black, posX, posY);
                posY += 30;
                e.Graphics.DrawString("-------------------------------------------------------------------------", fuente, Brushes.Black, posX, posY);
                posY += 30;
                fuente = new Font("consola", 12, FontStyle.Bold);
                e.Graphics.DrawString("GRACIAS POR SU COMPRA!", fuente, Brushes.Black, posX, posY);

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

            for(int i = 0; i < subvalor; i++)
            {
                espacio = espacio + " ";
            }
            return espacio;
        }

    }
}
