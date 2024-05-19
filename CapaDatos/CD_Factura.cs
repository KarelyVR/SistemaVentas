using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Navigation;
using System.Data.Entity.Infrastructure;
using System.Windows.Forms.VisualStyles;
using System.Windows.Forms;

namespace CapaDatos
{
    public class CD_Factura
    {
  

        //metodo para insertar Factura con procedimientos almacenados
        public int Registrar(Factura obj, out string Mensaje)
        {
            int idFacturagenerado = 0;
            Mensaje = string.Empty;


            try
            {
                //conexion a la base de datos para comunicarse con el procedimiento
                using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
                {
                    SqlCommand cmd = new SqlCommand("sp_RegistrarFactura", oconexion);
                    cmd.Parameters.AddWithValue("IdUsuario", obj.IdUsuario);
                    cmd.Parameters.AddWithValue("IdVenta", obj.IdVenta);
                    cmd.Parameters.AddWithValue("NombreCliente", obj.NombreCliente);
                    cmd.Parameters.AddWithValue("PrimerApellido", obj.PrimerApellido);
                    cmd.Parameters.AddWithValue("SegundoApellido", obj.SegundoApellido);
                    cmd.Parameters.AddWithValue("Calle", obj.Calle);
                    cmd.Parameters.AddWithValue("NumExt", obj.NumExt);
                    cmd.Parameters.AddWithValue("NumInt", obj.NumInt);
                    cmd.Parameters.AddWithValue("Colonia", obj.Colonia);
                    cmd.Parameters.AddWithValue("Municipio", obj.Municipio);
                    cmd.Parameters.AddWithValue("Pais", obj.Pais);
                    cmd.Parameters.AddWithValue("CP", obj.CP);
                    cmd.Parameters.AddWithValue("RFC", obj.RFC);
                    cmd.Parameters.AddWithValue("Correo", obj.Correo);
                    cmd.Parameters.AddWithValue("Telefono", obj.Telefono);
                    cmd.Parameters.AddWithValue("RazonSocial", obj.RazonSocial);
                    cmd.Parameters.AddWithValue("UsoCFDI", obj.UsoCFDI);
                    cmd.Parameters.AddWithValue("Fecha", obj.Fecha);
                    cmd.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    idFacturagenerado = Convert.ToInt32(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();
                }

            }
            catch (Exception ex)
            {
                idFacturagenerado = 0;
                Mensaje = ex.Message;
            }

            return idFacturagenerado;
        }

        public ConsultarFactura ObtenerFactura(int IdVenta)
        {
            try
            {
                //conexion a la base de datos para comunicarse con el procedimiento
                using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
                {
                    oconexion.Open();

                    using (SqlCommand cmd = oconexion.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "sp_ConsultarFactura";
                        cmd.Parameters.AddWithValue("@idventa", IdVenta);

                        using (var reader = cmd.ExecuteReader())
                        {
                            Factura factura = null;
                            Venta venta = null;
                            List<ProductosVenta> listaProductosVenta = new List<ProductosVenta>();

                            // Leer la primera result set (Factura)
                            if (reader.Read())
                            {
                                factura = new Factura(
                                    (int)reader["IdFactura"],
                                    (int)reader["IdVenta"],
                                    (int)reader["IdUsuario"],
                                    (string)reader["NombreCliente"],
                                    (string)reader["PrimerApellido"],
                                    (string)reader["SegundoApellido"],
                                    (string)reader["Calle"],
                                    (int)reader["NumExt"],
                                    (int)reader["NumInt"],
                                    (string)reader["Colonia"],
                                    (string)reader["Municipio"],
                                    (string)reader["Pais"],
                                    (string)reader["CP"],
                                    (string)reader["RFC"],
                                    (string)reader["Correo"],
                                    (string)reader["Telefono"],
                                    (string)reader["RazonSocial"],
                                    (string)reader["UsoCFDI"],
                                    (DateTime)reader["Fecha"],
                                    (string)reader["NombreCompleto"]
                                );
                            }

                            // Mover al siguiente result set (Venta)
                            if (reader.NextResult() && reader.Read())
                            {
                                venta = new Venta(
                                    (int)reader["IdVenta"],
                                    (int)reader["IdUsuario"],
                                    (string)reader["TipoDocumento"],
                                    (string)reader["NumeroDocumento"],
                                    (decimal)reader["MontoPago"],
                                    (decimal)reader["MontoCambio"],
                                    (decimal)reader["MontoTotal"],
                                    (string)reader["FechaRegistro"].ToString()
                                );
                            }

                            // Mover al siguiente result set (Detalle_Venta)
                            if (reader.NextResult())
                            {
                                while (reader.Read())
                                {
                                    var ProductoVenta = new ProductosVenta(
                                        (string)reader["Nombre"],
                                        (decimal)reader["PrecioVenta"],
                                        (int)reader["Cantidad"],
                                        (decimal)reader["SubTotal"]
                                    );

                                    listaProductosVenta.Add(ProductoVenta);
                                }
                            }
                            ConsultarFactura Resultado = new ConsultarFactura();

                            Resultado.Factura = factura;
                            Resultado.Venta = venta;
                            Resultado.ProductosVenta = listaProductosVenta;

                            return Resultado;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}
