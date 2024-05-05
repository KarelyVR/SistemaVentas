using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Factura
    {
        public int IdFactura { get; set; }
        public Usuario oUsuario { get; set; } //debe hacer referencia al id de la tabla usuarios *****
        public Detalle_Venta oDetalleVenta { get; set; } //debe hacer referencia al id de la tabla detalle venta *****
        public string NombreCliente { get; set; }
        public string PrimerApellido { get; set; }
        public string SegundoApellido { get; set; }
        public string Calle { get; set; }
        public string Colonia { get; set; }
        public string Municipio { get; set; }
        public int NumInt { get; set; }
        public int NumExt { get; set; }
        public string Pais { get; set; }
        public string CP { get; set; }
        public string RFC { get; set; }
        public string Correo { get; set; }
        public string Telefono { get; set; }
        public string RazonSocial { get; set; }
        public string UsoCFDI { get; set; }
        public string Fecha { get; set; }
    }
}
