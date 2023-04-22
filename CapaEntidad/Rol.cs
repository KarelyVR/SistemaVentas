using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    //campos necesarios que representan a las columnas en la tabla
    public class Rol
    {
        public int IdRol { get; set; }
        public string Descripcion { get; set; }
        public string FechaRegistro { get; set; }
    }
}
