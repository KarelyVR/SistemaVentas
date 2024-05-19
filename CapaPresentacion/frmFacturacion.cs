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
        private Usuario _Usuario;
        private int idVenta;
        public frmFacturacion(Usuario oUsuario, int idcorrelativo)
        {
            _Usuario = oUsuario;
            idVenta = idcorrelativo;
            InitializeComponent();
        }

        private void iconButton1_Click(object sender, EventArgs e)
        {
            string mensaje = string.Empty;

            Factura obj = new Factura()
            {
                IdUsuario = _Usuario.IdUsuario, //id usuario (obtener con una busqueda o traer directo de lbluser)
                IdVenta = idVenta, //id detalle venta (obtener con una busqueda o traer directo de venta)
                NombreCliente = txtNombre.Text,
                PrimerApellido = txtApellidoP.Text,
                SegundoApellido = txtApellidoM.Text,
                Calle = txtCalle.Text,
                NumExt = Convert.ToInt32(txtNoExt.Text),
                NumInt = 0,
                Colonia = txtColonia.Text,
                Municipio = txtMunicipio.Text,
                Pais = txtPais.Text,
                CP = txtCP.Text,
                RFC = txtRFC.Text,  
                Correo = txtCorreo.Text,
                Telefono = txtTel.Text,
                RazonSocial = txtRS.Text,
                UsoCFDI = txtCDFI.Text, 
                Fecha = DateTime.Parse(txtFecha.Text)
            };

            if (txtNoInt.Text != string.Empty)
                obj.NumInt = Convert.ToInt32(txtNoInt.Text);

            // registro de la factura 
            
                //Insersion del usuario mediante procedimiento almacenado
                int idgenerado = new CN_Factura().Registrar(obj, out mensaje);

                if (idgenerado != 0)
                {
                    var factura = new CN_Factura().ObtenerFactura(idVenta);
                    {
                        factura.empresa = "Abarrotes Dani";
                        factura.direccion = "Del Limon 223, col. Los Cipreses, San Nicolás de los Garza";
                        factura.telefono = "8119920181";
                        factura.logo = PLogo.Image;
                        Usuario oUsuario = new Usuario() { NombreCompleto = _Usuario.NombreCompleto };
                        factura.vendedor = oUsuario.NombreCompleto;
                        factura.imprimir(factura);
                    }
                    this.Hide();
                }
                else
                {
                    MessageBox.Show(mensaje);
                }
            
            
        }
        private void Limpiar()
        {
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
            txtFecha.Text = DateTime.Now.ToString();
        }

    }
}
