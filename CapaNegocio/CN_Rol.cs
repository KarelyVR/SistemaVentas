using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Rol
    {
        private CD_Rol objcd_rol = new CD_Rol();

        //metodo de capa de datos que retorna la lista de rol
        public List<Rol> Listar()
        {
            return objcd_rol.Listar();
        }
    }
}
