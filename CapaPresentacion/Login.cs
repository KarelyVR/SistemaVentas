using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using CapaNegocio;
using CapaEntidad;
using System.Windows.Controls;
using System.Reflection.Emit;

/*
using System.Data.Sql;
using System.Data.SqlClient;
*/

namespace CapaPresentacion
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void btncancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btningresar_Click(object sender, EventArgs e)
        {
            //Listar los usuarios
            List<Usuario> TEST = new CN_Usuario().Listar();

            //Expresion lambda para automatizar la busqueda del usuario dentro de la lista
            Usuario ousuario = new CN_Usuario().Listar().Where(u => u.Documento == txtdocumento.Text && u.Clave == txtclave.Text).FirstOrDefault();

            //VALIDACION para saber si encontro o no al usuario
            if (ousuario != null)
            {

                //Muestra la pantalla de inicio
                Inicio form = new Inicio(ousuario);
                form.Show();
                //Oculta el formulario
                this.Hide();

                //cuando se cierre 'inicio' podra unirse con el evento creado de cerrar
                form.FormClosing += frm_closing;

            }
            else //en caso de no encontrar al usuario se despliega un aviso
            {
                MessageBox.Show("No se encontro el usuario", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }
        //evento que recibe un objeto y una funcion de cerrar para mostrar el form de 'login'
        private void frm_closing(object sender, FormClosingEventArgs e)
        {
            txtdocumento.Text = "";
            txtclave.Text = "";
            this.Show();
        }

        private void lblRecuperarContra_Click(object sender, EventArgs e)
        {
            //muestra los botones y etiquetas para ingresar nueva contraseña 

            lblRecuperarContra.Visible = false;
            this.BackColor = Color.LightCyan;
            label5.Visible = true;

            btningresar.Visible = false;
            btncancelar.Visible = false;

            btnAceptar.Visible = true;
            btnCancelar2.Visible = true;

            txtdocumento.Text = "";
            txtclave.Text = "";

            label4.Text = "Nueva contraseña";

        }

        private void btnCancelar2_Click(object sender, EventArgs e)
        {
            // oculta los botones y etiquetas para ingresar nueva contraseña

            lblRecuperarContra.Visible = true;
            this.BackColor = Color.AliceBlue;
            label5.Visible = false;

            btningresar.Visible = true;
            btncancelar.Visible = true;

            btnAceptar.Visible = false;
            btnCancelar2.Visible = false;

            txtdocumento.Text = "";
            txtclave.Text = "";

            label4.Text = "Contraseña";
        }

        private void btnAceptar_Click(object sender, EventArgs e)
        {

            // Listar los usuarios
            List<Usuario> usuarios = new CN_Usuario().Listar();

            // Buscar al usuario dentro de la lista
            Usuario usuario = usuarios.FirstOrDefault(u => u.Documento == txtdocumento.Text);

            // VALIDACIÓN para saber si encontró o no al usuario
            if (usuario != null)
            {
                // Modificas la contraseña del usuario según lo que se haya ingresado en el txtNuevaContraseña
                usuario.Clave = txtclave.Text;

                // Aquí debes llamar a tu método de editar usuario para guardar los cambios
                string mensaje;
                bool resultado = new CN_Usuario().EditarClave(usuario, out mensaje);

                if (resultado)
                {
                    MessageBox.Show("Se ha cambiado la contraseña correctamente", "ÉXITO", MessageBoxButtons.OK, MessageBoxIcon.Information);
                   
                    //los botones y etiquetas vuelven a su lugar
                    lblRecuperarContra.Visible = true;
                    this.BackColor = Color.AliceBlue;
                    label5.Visible = false;

                    btningresar.Visible = true;
                    btncancelar.Visible = true;

                    btnAceptar.Visible = false;
                    btnCancelar2.Visible = false;

                    label4.Text = "Contraseña";
                    txtdocumento.Text = "";
                    txtclave.Text = "";
                }
                else
                {
                    MessageBox.Show(mensaje, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
        }
    }
}
