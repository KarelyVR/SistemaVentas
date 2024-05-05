using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Threading.Tasks;

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
                    cmd.Parameters.AddWithValue("IdUsuario", obj.oUsuario.IdUsuario);
                    cmd.Parameters.AddWithValue("IdFactura", obj.IdFactura);
                    cmd.Parameters.AddWithValue("IdDetalleVenta", obj.oDetalleVenta.IdDetalleVenta);
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
        
    }
}
