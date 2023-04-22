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

    }
}
