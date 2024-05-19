using DocumentFormat.OpenXml.Presentation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Venta
    {
        public Venta() { }
        public Venta(int IdVenta, int IdUsuario, string TipoDocumento, string NumeroDocumento, decimal MontoPago, decimal MontoCambio, decimal MontoTotal, string FechaRegistro)
        {
            this.IdVenta = IdVenta;
            this.IdUsuario = IdUsuario;
            this.TipoDocumento = TipoDocumento;
            this.NumeroDocumento = NumeroDocumento;
            this.MontoPago = MontoPago;
            this.MontoCambio = MontoCambio;
            this.MontoTotal = MontoTotal;
            this.FechaRegistro = FechaRegistro;
        }
        public int IdVenta { get; set; }
        public int IdUsuario { get; set; }
        public Usuario oUsuario { get; set; }
        public string TipoDocumento { get; set; }
        public string NumeroDocumento { get; set; }
        public decimal MontoPago { get; set; }
        public decimal MontoCambio { get; set; }
        public decimal MontoTotal { get; set; }
        public List<Detalle_Venta> oDetalle_Venta { get; set; }
        public string FechaRegistro { get; set; }
    }
}
