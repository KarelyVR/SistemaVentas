using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Detalle_Venta
    {
        public Detalle_Venta() { }
        public Detalle_Venta(int IdDetalleVenta, int IdProducto, decimal PrecioVenta, int Cantidad, decimal SubTotal, string FechaRegistro)
        {
            this.IdDetalleVenta = IdDetalleVenta;
            this.oProducto.IdProducto = IdProducto;
            this.PrecioVenta = PrecioVenta;
            this.Cantidad = Cantidad;
            this.SubTotal = SubTotal;
            this.FechaRegistro = FechaRegistro;
        }
        public int IdDetalleVenta { get; set; }
        //El id Venta se hace haciendo referencia desde la tabla de Venta
        public Producto oProducto { get; set; }
        public decimal PrecioVenta { get; set; }
        public int Cantidad { get; set; }
        public decimal SubTotal { get; set; }
        public string FechaRegistro { get; set; }
    }
}
