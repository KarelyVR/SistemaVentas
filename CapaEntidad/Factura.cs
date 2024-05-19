using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Factura
    {
        public Factura() { }
        public Factura(int IdFactura, int IdVenta, int IdUsuario, string NombreCliente, string PrimerApellido, string SegundoApellido, string Calle, int NumExt, int? NumInt, string Colonia, string Municipio, string Pais, string CP, string RFC, string Correo, string Telefono, string RazonSocial, string UsoCFDI, DateTime Fecha, string NombreCompleto)
        {
            this.IdFactura = IdFactura;
            this.IdUsuario = IdUsuario;
            this.IdVenta = IdVenta;
            this.NombreCliente = NombreCliente;
            this.PrimerApellido = PrimerApellido;
            this.SegundoApellido = SegundoApellido;
            this.Calle = Calle;
            this.NumInt = NumInt;
            this.NumExt = NumExt;
            this.Colonia = Colonia;
            this.Municipio = Municipio;
            this.Pais = Pais;
            this.CP = CP;
            this.RFC = RFC;
            this.Correo = Correo;
            this.Telefono = Telefono;
            this.RazonSocial = RazonSocial;
            this.UsoCFDI = UsoCFDI;
            this.Fecha = Fecha;
            this.NombreCompleto = NombreCompleto;
        }

        public int IdFactura { get; set; }
        public int IdUsuario { get; set; } //debe hacer referencia al id de la tabla usuarios *****
        public int IdVenta { get; set; } //debe hacer referencia al id de la tabla detalle venta *****
        public string NombreCliente { get; set; }
        public string PrimerApellido { get; set; }
        public string SegundoApellido { get; set; }
        public string Calle { get; set; }
        public int NumExt { get; set; }
        public int? NumInt { get; set; }
        public string Colonia { get; set; }
        public string Municipio { get; set; }
        public string Pais { get; set; }
        public string CP { get; set; }
        public string RFC { get; set; }
        public string Correo { get; set; }
        public string Telefono { get; set; }
        public string RazonSocial { get; set; }
        public string UsoCFDI { get; set; }
        public DateTime Fecha { get; set; }
        public string NombreCompleto {  get; set; }
    }
}
