using CapaDatos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CN_Reembolso
    {
        public int RealizarReembolso(string idProducto, int cantidad) 
        { 
            int i = CD_Reembolso.Reembolso(idProducto, cantidad);
            return i;
        }

    }
}
