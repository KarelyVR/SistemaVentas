using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class ProductosVenta
    {
        public string producto { get; set; }
        public decimal precio { get; set;}
        public int cantidad { get; set;}
        public decimal subtotal { get; set; }
    }
}
