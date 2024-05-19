using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class ProductosVenta
    {
        public ProductosVenta() { }
        public ProductosVenta(string producto, decimal precio, int cantidad, decimal subtotal) 
        {
            this.producto = producto;   
            this.precio = precio;
            this.cantidad = cantidad;
            this.subtotal = subtotal;
        }
        public string producto { get; set; }
        public decimal precio { get; set;}
        public int cantidad { get; set;}
        public decimal subtotal { get; set; }
    }
}
