using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using CapaEntidad;
using CapaNegocio;
using CapaPresentacion.Modales;
using FontAwesome.Sharp;


namespace CapaPresentacion
{
    //el constructor siempre se ejecuta primero
    public partial class Inicio : Form
    {
        public static Usuario usuarioActual;
        private static IconMenuItem MenuActivo = null;
        private static Form FormularioActivo = null;


        //va a recibir un objeto 'usuario'
        public Inicio(Usuario objusuario)
        {
            usuarioActual = objusuario;
            InitializeComponent();
        }

        private void Inicio_Load(object sender, EventArgs e)
        {
            //Muestra solo los menus que tiene permitido el rol del usuario
            List<Permiso> listapermisos = new CN_Permiso().Listar(usuarioActual.IdUsuario);

            foreach (IconMenuItem iconmenu in menu.Items)
            {
                bool encontrado = listapermisos.Any(m => m.NombreMenu == iconmenu.Name);
                if(encontrado == false)
                {
                    iconmenu.Visible = false;
                }
            }

            //al momento de cargar el formulario el lblusuario tendra el nombre del usuario que se logeo
            lblusuario.Text = usuarioActual.NombreCompleto;
            idUser.Text = usuarioActual.IdUsuario.ToString();

            MostrarNotificacionesDeStockBajo(); //Se agrega esto para notificaciones
        }

        //evento al dar clic a cada menu
        private void AbrirFormulario(IconMenuItem menu, Form formulario)
        {
            if (MenuActivo != null)
            {
                MenuActivo.BackColor = Color.White;
            }
            menu.BackColor = Color.Silver;
            MenuActivo = menu;

            if(FormularioActivo != null)
            {
                FormularioActivo.Close();
            }

            FormularioActivo = formulario;
            formulario.TopLevel = false;
            formulario.FormBorderStyle = FormBorderStyle.None;
            formulario.Dock = DockStyle.Fill;
            formulario.BackColor = Color.LavenderBlush;

            contenedor.Controls.Add(formulario);

            formulario.Show();
        }
        private void menuusuario_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario((IconMenuItem)sender, new frmUsuarios());
        }

        private void submenucategoria_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario(menumantenedor, new frmCategoria());
        }

        private void submenuproducto_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario(menumantenedor, new frmProducto());
        }

        private void submenuregistrarventa_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario(menuventas, new frmVentas(usuarioActual));
        }

        private void submenudetalleventa_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario(menuventas, new frmDetalleVenta());
        }

        private void submenuregistrarcompra_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario(menucompras, new frmCompras(usuarioActual));
        }

        private void submenudetallecompra_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario(menucompras, new frmDetalleCompra());
        }

        private void menuproveedores_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario((IconMenuItem)sender, new frmProveedores());
        }

        

        private void menuacercade_Click(object sender, EventArgs e)
        {
            mdAcercade md = new mdAcercade();
            md.ShowDialog();
        }

        private void submenureportecompras_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario(menureportes, new frmReporteCompras());
        }

        private void submenureporteventas_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario(menureportes, new frmReporteVentas());
        }

        private void btnsalir_Click(object sender, EventArgs e)
        {
            if(MessageBox.Show("¿Cerrar Sesión?","Salir",MessageBoxButtons.YesNo,MessageBoxIcon.Question) == DialogResult.Yes)
                this.Close();
        }

        private void iconMenuItem1_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario(Ayuda, new Ayuda());
        }

        private void sunmenureembolso_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario(submenureembolso, new frmReembolso());
        }

        private void iconPictureBox1_Click(object sender, EventArgs e)
        {
            panel1.Hide();
            AbrirFormulario(Ayuda, new Ayuda());
        }

        //Se agrega esto para notificaciones
        public List<Producto> ObtenerProductosConStockBajo(int limiteStock)
        {
            List<Producto> productosConStockBajo = new List<Producto>();

            // Obtener la cadena de conexión desde el app.config
            string connectionString = ConfigurationManager.ConnectionStrings["cadena_conexion"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("ObtenerProductosConStockBajo", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@limiteStock", limiteStock);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Producto producto = new Producto
                    {
                        IdProducto = Convert.ToInt32(reader["IdProducto"]),
                        Codigo = reader["Codigo"].ToString(),
                        Nombre = reader["Nombre"].ToString(),
                        Descripcion = reader["Descripcion"].ToString(),
                        // Agregar los demás campos necesarios
                        Stock = Convert.ToInt32(reader["Stock"]),
                        PrecioCompra = Convert.ToDecimal(reader["PrecioCompra"]),
                        PrecioVenta = Convert.ToDecimal(reader["PrecioVenta"]),
                        Estado = Convert.ToBoolean(reader["Estado"])
                    };
                    productosConStockBajo.Add(producto);
                }
                reader.Close();
            }

            return productosConStockBajo;
        }
        //Se agrega esto para notificaciones
        private void MostrarNotificacionesDeStockBajo()
        {
            List<Producto> productosConStockBajo = ObtenerProductosConStockBajo(10);

            if (productosConStockBajo.Count > 0)
            {
                string mensaje = "Los siguientes productos tienen stock bajo:\n\n";
                foreach (Producto producto in productosConStockBajo)
                {
                    mensaje += $"{producto.Nombre} (Stock: {producto.Stock})\n";
                }
                MessageBox.Show(mensaje, "Notificaciones de Stock Bajo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            else
            {
                MessageBox.Show("No hay productos con stock bajo.", "Notificaciones", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        //Se agrega esto para notificaciones
        private void btnNotificaciones_Click(object sender, EventArgs e)
        {
            List<Producto> productosConStockBajo = ObtenerProductosConStockBajo(10);

            if (productosConStockBajo.Count > 0)
            {
                string mensaje = "Los siguientes productos tienen stock bajo:\n\n";
                foreach (Producto producto in productosConStockBajo)
                {
                    mensaje += $"{producto.Nombre} (Stock: {producto.Stock})\n";
                }
                MessageBox.Show(mensaje, "Notificaciones de Stock Bajo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            else
            {
                MessageBox.Show("No hay productos con stock bajo.", "Notificaciones", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
    }
}
