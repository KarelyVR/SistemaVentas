﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;
using CapaEntidad;

namespace CapaDatos
{
    public class CD_Permiso
    {
        public List<Permiso> Listar(int idusuario)
        {
            List<Permiso> lista = new List<Permiso>();
            using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
            {
                
                StringBuilder query = new StringBuilder();
                query.AppendLine("SELECT p.IdRol,p.NombreMenu from PERMISO p");
                query.AppendLine("INNER JOIN ROL r ON r.IdRol = p.IdRol");
                query.AppendLine("INNER JOIN USUARIO u ON u.IdRol = r.IdRol");
                query.AppendLine("WHERE u.IdUsuario = @idusuario");

                SqlCommand cmd = new SqlCommand(query.ToString(), oconexion);
                cmd.Parameters.AddWithValue("@idusuario", idusuario);
                cmd.CommandType = CommandType.Text;

                oconexion.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        lista.Add(new Permiso()
                        {
                            oRol = new Rol() {IdRol = Convert.ToInt32(dr["IdRol"])},
                            NombreMenu = dr["NombreMenu"].ToString()
                        });
                    }
                }

              
            }
            return lista;
        }
    }
}
