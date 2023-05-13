using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CN_Categoria
    {
        //instancia a nuestra clase de la capa datos
        private CD_Categoria objcd_Categoria = new CD_Categoria();

        //metodo de capa de datos que retorna la lista de la clase Categoria
        public List<Categoria> Listar()
        {
            return objcd_Categoria.Listar();
        }

        //metodo de capa de datos que retorna el procedimiento de insertar
        public int Registrar(Categoria obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (obj.Descripcion == "")
            {
                Mensaje += "Es necesaria la descripción de la Categoria\n";
            }

            if (Mensaje != string.Empty)
            {
                return 0;
            }
            else
            {
                return objcd_Categoria.Registrar(obj, out Mensaje);
            }

        }

        //metodo de capa de datos que retorna el procedimiento de editar
        public bool Editar(Categoria obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (obj.Descripcion == "")
            {
                Mensaje += "Es necesaria la descripción de la Categoria\n";
            }

            if (Mensaje != string.Empty)
            {
                return false;
            }
            else
            {
                return objcd_Categoria.Editar(obj, out Mensaje);
            }

        }

        //metodo de capa de datos que retorna el procedimiento de eliminar
        public bool Eliminar(Categoria obj, out string Mensaje)
        {
            return objcd_Categoria.Eliminar(obj, out Mensaje);
        }

        public bool Eliminar(Usuario obj, out string mensaje)
        {
            throw new NotImplementedException();
        }
    }
}
