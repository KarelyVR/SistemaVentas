using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Detalle_Compra
    {
        public int IdDetalleCompra { get; set; }
        //El id Compra se hace haciendo referencia desde la tabla de compra
        public Producto oProducto { get; set; }
        public decimal PrecioCompra { get; set; }
        public decimal PrecioVenta { get; set; }
        public int Cantidad { get; set; }
        public decimal Total { get; set; }
        public string FechaRegistro { get; set; }
    }
}
