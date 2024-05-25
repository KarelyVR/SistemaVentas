using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaEntidad;
using System.Windows.Forms;

namespace CapaDatos
{
    public class CD_Reembolso
    {
        public static int Reembolso(string idProducto, int cantidad)
        {
            int i;
            using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("sp_ReembolsoProducto", oconexion);
                    cmd.Parameters.AddWithValue("@Producto", idProducto);
                    cmd.Parameters.AddWithValue("@Stock", cantidad);
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();
                    i = cmd.ExecuteNonQuery();
                    oconexion.Close();
                    
                }
                catch (Exception ex)
                {
                    i = 0;
                }
            }
            return i;
        }
    }
}
