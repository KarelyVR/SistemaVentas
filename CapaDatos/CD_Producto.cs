using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos
{
    public class CD_Producto
    {
        //metodo que retorna una lista de Productos
        public List<Producto> Listar()
        {
            List<Producto> lista = new List<Producto>();
            using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
            {
                try
                {

                    StringBuilder query = new StringBuilder();
                    query.AppendLine("SELECT IdProducto, Codigo, Nombre, p.Descripcion, c.IdCategoria,c.Descripcion [DescripcionCategoria],Stock, PrecioCompra, PrecioVenta, p.Estado FROM PRODUCTO p");
                    query.AppendLine("INNER JOIN CATEGORIA c ON c.IdCategoria = p.IdCategoria");

                    SqlCommand cmd = new SqlCommand(query.ToString(), oconexion);
                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            lista.Add(new Producto()
                            {
                                IdProducto = Convert.ToInt32(dr["IdProducto"]),
                                Codigo = dr["Codigo"].ToString(),
                                Nombre = dr["Nombre"].ToString(),
                                Descripcion = dr["Descripcion"].ToString(),
                                oCategoria = new Categoria() { IdCategoria = Convert.ToInt32(dr["IdCategoria"]), Descripcion = dr["DescripcionCategoria"].ToString()},
                                Stock = Convert.ToInt32(dr["Stock"].ToString()),
                                PrecioVenta = Convert.ToDecimal(dr["PrecioVenta"].ToString()),
                                PrecioCompra = Convert.ToDecimal(dr["PrecioCompra"].ToString()),
                                Estado = Convert.ToBoolean(dr["Estado"])
                            });
                        }
                    }

                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                    lista = new List<Producto>();
                }
            }
            return lista;
        }

        //metodo para insertar Producto con procedimientos almacenados
        public int Registrar(Producto obj, out string Mensaje)
        {
            int idProductogenerado = 0;
            Mensaje = string.Empty;


            try
            {
                //conexion a la base de datos para comunicarse con el procedimiento
                using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
                {
                    SqlCommand cmd = new SqlCommand("sp_RegistrarProducto", oconexion);
                    cmd.Parameters.AddWithValue("Codigo", obj.Codigo);
                    cmd.Parameters.AddWithValue("Nombre", obj.Nombre);
                    cmd.Parameters.AddWithValue("Descripcion", obj.Descripcion);
                    cmd.Parameters.AddWithValue("IdCategoria", obj.oCategoria.IdCategoria);
                    cmd.Parameters.AddWithValue("Estado", obj.Estado);
                    cmd.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    idProductogenerado = Convert.ToInt32(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();

                }

            }
            catch (Exception ex)
            {
                idProductogenerado = 0;
                Mensaje = ex.Message;
            }

            return idProductogenerado;
        }

        //metodo para editar Producto con procedimientos almacenados
        public bool Editar(Producto obj, out string Mensaje)
        {
            bool respuesta = false;
            Mensaje = string.Empty;


            try
            {
                //conexion a la base de datos para comunicarse con el procedimiento
                using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
                {
                    SqlCommand cmd = new SqlCommand("sp_ModificarProducto", oconexion);
                    cmd.Parameters.AddWithValue("IdProducto", obj.IdProducto);
                    cmd.Parameters.AddWithValue("Codigo", obj.Codigo);
                    cmd.Parameters.AddWithValue("Nombre", obj.Nombre);
                    cmd.Parameters.AddWithValue("Descripcion", obj.Descripcion);
                    cmd.Parameters.AddWithValue("IdCategoria", obj.oCategoria.IdCategoria);
                    cmd.Parameters.AddWithValue("Estado", obj.Estado);
                    cmd.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    respuesta = Convert.ToBoolean(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();

                }

            }
            catch (Exception ex)
            {
                respuesta = false;
                Mensaje = ex.Message;
            }

            return respuesta;
        }

        //metodo para eliminar Producto con procedimientos almacenados
        public bool Eliminar(Producto obj, out string Mensaje)
        {
            bool respuesta = false;
            Mensaje = string.Empty;


            try
            {
                //conexion a la base de datos para comunicarse con el procedimiento
                using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
                {
                    SqlCommand cmd = new SqlCommand("sp_EliminarProducto", oconexion);
                    cmd.Parameters.AddWithValue("IdProducto", obj.IdProducto);
                    cmd.Parameters.Add("Respuesta", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    respuesta = Convert.ToBoolean(cmd.Parameters["Respuesta"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();

                }

            }
            catch (Exception ex)
            {
                respuesta = false;
                Mensaje = ex.Message;
            }

            return respuesta;
        }
    }
}
