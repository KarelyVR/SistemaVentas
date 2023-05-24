using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Producto
    {
        //instancia a nuestra clase de la capa datos
        private CD_Producto objcd_Producto = new CD_Producto();

        //metodo de capa de datos que retorna la lista de la clase Producto
        public List<Producto> Listar()
        {
            return objcd_Producto.Listar();
        }

        //metodo de capa de datos que retorna el procedimiento de insertar
        public int Registrar(Producto obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (obj.Codigo == "")
            {
                Mensaje += "Es necesario el código del Producto\n";
            }

            if (obj.Nombre == "")
            {
                Mensaje += "Es necesario el nombre del Producto\n";
            }

            if (obj.Descripcion == "")
            {
                Mensaje += "Es necesaria la descripción del Producto\n";
            }

            if (Mensaje != string.Empty)
            {
                return 0;
            }
            else
            {
                return objcd_Producto.Registrar(obj, out Mensaje);
            }

        }

        //metodo de capa de datos que retorna el procedimiento de editar
        public bool Editar(Producto obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (obj.Codigo == "")
            {
                Mensaje += "Es necesario el código del Producto\n";
            }

            if (obj.Nombre == "")
            {
                Mensaje += "Es necesario el nombre del Producto\n";
            }

            if (obj.Descripcion == "")
            {
                Mensaje += "Es necesaria la descripción del Producto\n";
            }

            if (Mensaje != string.Empty)
            {
                return false;
            }
            else
            {
                return objcd_Producto.Editar(obj, out Mensaje);
            }

        }

        //metodo de capa de datos que retorna el procedimiento de eliminar
        public bool Eliminar(Producto obj, out string Mensaje)
        {
            return objcd_Producto.Eliminar(obj, out Mensaje);
        }
    }
}
