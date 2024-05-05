using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Factura
    {
        //instancia a nuestra clase de la capa datos
        private CD_Factura objcd_Factura = new CD_Factura();

        //metodo de capa de datos que retorna el procedimiento de insertar
        public int Registrar(Factura obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (obj.RFC == "")
            {
                Mensaje += "Es necesario el RFC\n";
            }

            if (Mensaje != string.Empty)
            {
                return 0;
            }
            else
            {
                return objcd_Factura.Registrar(obj, out Mensaje);
            }

        }


    }
}
