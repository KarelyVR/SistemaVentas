using CapaEntidad;
using CapaNegocio;
using CapaPresentacion.Utilidades;
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
    public partial class frmFacturacion : Form
    {
        public frmFacturacion()
        {
            InitializeComponent();
            
        }

        private void iconButton1_Click(object sender, EventArgs e)
        {
            string mensaje = string.Empty;

            Factura obj = new Factura()
            {
                IdFactura = Convert.ToInt32(txtid.Text),
                oDetalleVenta = new Detalle_Venta() { IdDetalleVenta = Convert.ToInt32(txtVenta.Text) }, //id detalle venta (obtener con una busqueda o traer directo de venta)
                oUsuario = new Usuario() { IdUsuario = Convert.ToInt32(txtUser.Text) }, //id usuario (obtener con una busqueda o traer directo de lbluser)
                NombreCliente = txtNombre.Text,
                PrimerApellido = txtApellidoP.Text,
                SegundoApellido = txtApellidoM.Text,
                Calle = txtCalle.Text,
                NumExt = Convert.ToInt32(txtNoExt.Text),
                NumInt = Convert.ToInt32(txtNoInt.Text),
                Colonia = txtColonia.Text,
                Municipio = txtMunicipio.Text,
                Pais = txtPais.Text,
                CP = txtCP.Text,
                RFC = txtRFC.Text,  
                Correo = txtCorreo.Text,
                Telefono = txtTel.Text,
                RazonSocial = txtRS.Text,
                UsoCFDI = txtCDFI.Text, 
                Fecha = txtFecha.Text,

            };

            // registro de la factura 
            if (obj.IdFactura == 0)
            {
                //Insersion del usuario mediante procedimiento almacenado
                int idgenerado = new CN_Factura().Registrar(obj, out mensaje);

                if (idgenerado != 0)
                {
                    Limpiar();
                }
                else
                {
                    MessageBox.Show(mensaje);
                }
            }
            
        }
        private void Limpiar()
        {
            txtid.Text = "0";
            txtVenta.Text = "0";
            txtUser.Text = "0";
            txtNombre.Text = "";
            txtApellidoM.Text = "";
            txtApellidoP.Text = "";
            txtRFC.Text = "";
            txtCorreo.Text = "";
            txtTel.Text = "";
            txtRS.Text = "";
            txtCDFI.Text = "";
            txtCalle.Text = "";
            txtNoInt.Text = "";
            txtNoExt.Text = "";
            txtCP.Text = "";
            txtColonia.Text = "";
            txtMunicipio.Text = "";
            txtPais.Text = "";

            txtNombre.Select();
        }

        private void frmFacturacion_Load(object sender, EventArgs e)
        {

            txtFecha.Text = DateTime.Now.ToString("dd/MM/yyyy");

            txtid.Text = "0";
            txtVenta.Text = "0";
            txtUser.Text = "0";
        }

    }
}
