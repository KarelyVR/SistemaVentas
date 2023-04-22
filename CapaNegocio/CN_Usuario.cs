using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using CapaDatos;
using CapaEntidad;


namespace CapaNegocio
{
    public class CN_Usuario
    {
        //instancia a nuestra clase de la capa datos
        private CD_Usuario objcd_usuario = new CD_Usuario();
        
        //metodo de capa de datos que retorna la lista de la clase usuario
        public List<Usuario> Listar()
        {
            return objcd_usuario.Listar();
        }

        //metodo de capa de datos que retorna el procedimiento de insertar
        public int Registrar(Usuario obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (obj.Documento == "")
            {
                Mensaje += "Es necesario el documento del usuario\n";
            }

            if (obj.NombreCompleto == "")
            {
                Mensaje += "Es necesario el nombre del usuario\n";
            }

            if (obj.Clave == "")
            {
                Mensaje += "Es necesaria la clave del usuario\n";
            }

            if(Mensaje != string.Empty)
            {
                return 0;
            }
            else
            {
                return objcd_usuario.Registrar(obj, out Mensaje);
            }
            
        }

        //metodo de capa de datos que retorna el procedimiento de editar
        public bool Editar(Usuario obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (obj.Documento == "")
            {
                Mensaje += "Es necesario el documento del usuario\n";
            }

            if (obj.NombreCompleto == "")
            {
                Mensaje += "Es necesario el nombre del usuario\n";
            }

            if (obj.Clave == "")
            {
                Mensaje += "Es necesaria la clave del usuario\n";
            }

            if (Mensaje != string.Empty)
            {
                return false;
            }
            else
            {
                return objcd_usuario.Editar(obj, out Mensaje);
            }
            
        }

        //metodo de capa de datos que retorna el procedimiento de eliminar
        public bool Eliminar(Usuario obj, out string Mensaje)
        {
            return objcd_usuario.Eliminar(obj, out Mensaje);
        }
    }
}
