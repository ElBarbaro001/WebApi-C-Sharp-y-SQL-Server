using WebApi.Models;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Security.Cryptography.X509Certificates;
using System;
using WebApi.Controllers;

namespace WebApi.Conexion
{
    public class EjecutarSentencias
    {
        //Metodo para Insertar los Datos del Cliente en la Base de Datos
        public static bool RegistarCliente(Cliente regCliente) {
            using (SqlConnection conectar = new SqlConnection(Conexion.rutaConexion)) { 
                SqlCommand cmd = new SqlCommand("reg_cliente", conectar);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@tp_documento", regCliente.tp_documento);
                cmd.Parameters.AddWithValue("@documento", regCliente.documento);
                cmd.Parameters.AddWithValue("@nombres", regCliente.nombres);
                cmd.Parameters.AddWithValue("@primer_apellido", regCliente.primer_apellido);
                cmd.Parameters.AddWithValue("@segundo_apellido", regCliente.segundo_apellido);
                cmd.Parameters.AddWithValue("@genero", regCliente.genero);
                cmd.Parameters.AddWithValue("@fecha_nacimiento", regCliente.fecha_nacimiento);
                cmd.Parameters.AddWithValue("@dir_casa", regCliente.dir_casa);
                cmd.Parameters.AddWithValue("@dir_trabajo", regCliente.dir_trabajo);
                cmd.Parameters.AddWithValue("@tfno_casa", regCliente.tfno_casa);
                cmd.Parameters.AddWithValue("@tfno_trabajo", regCliente.tfno_trabajo);
                cmd.Parameters.AddWithValue("@email", regCliente.email);
                try
                {
                    conectar.Open();
                    cmd.ExecuteNonQuery();
                    return true;
                }
                catch (Exception ex)
                {
                    return false;
                }
            }
        }
        //Listar Clientes que se encuentrar registrados en la Tabla
        public static List<Cliente> Listar() { 
            List<Cliente> ListarClientes = new List<Cliente>();
            using (SqlConnection conectar = new SqlConnection(Conexion.rutaConexion)) {
                SqlCommand cmd = new SqlCommand("sp_listar_clientes", conectar);
                cmd.CommandType = CommandType.Text;
                try
                {
                    conectar.Open();
                    cmd.ExecuteNonQuery();
                    using (SqlDataReader leer = cmd.ExecuteReader()) { 
                        while (leer.Read())
                        {
                            ListarClientes.Add(new Cliente() { 
                                codigo = Convert.ToInt32(leer["codigo"]),
                                tp_documento = leer["tp_documento"].ToString(),
                                documento = Convert.ToInt32(leer["documento"].ToString()),
                                nombres = leer["nombres"].ToString(),
                                primer_apellido = leer["primer_apellido"].ToString(),
                                segundo_apellido = leer["segundo_apellido"].ToString(),
                                genero = leer["genero"].ToString(),
                                fecha_nacimiento = Convert.ToDateTime(leer["fecha_nacimiento"].ToString()),
                                dir_casa = leer["dir_casa"].ToString(),
                                dir_trabajo = leer["dir_trabajo"].ToString(),
                                tfno_casa = leer["tfno_casa"].ToString(),
                                tfno_trabajo = leer["tfno_trabajo"].ToString(),
                                email = leer["email"].ToString()
                            });
                        }
                    }
                    return ListarClientes;
                }
                catch (Exception ex)
                {

                    return ListarClientes;
                }
            }
        }
        //Eliminar Cliente
        public static bool EliminarCliente(int documento)
        {
            using (SqlConnection conectarDb = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("sp_eliminar_cliente", conectarDb);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@documento", documento);

                try
                {
                    conectarDb.Open();
                    cmd.ExecuteNonQuery();
                    return true;
                }
                catch (Exception ex)
                {
                    return false;
                }
            }
        }
        // Modificar los datos de un Cliente
        public static bool ModificarCliente(Cliente modCliente)
        {
            using (SqlConnection conectarDb = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("sp_modificar_cliente", conectarDb);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@codigo", modCliente.codigo);
                cmd.Parameters.AddWithValue("@tp_documento", modCliente.tp_documento);
                cmd.Parameters.AddWithValue("@documento", modCliente.documento);
                cmd.Parameters.AddWithValue("@fecha_nacimiento", modCliente.fecha_nacimiento);
                try
                {
                    conectarDb.Open();
                    cmd.ExecuteNonQuery();
                    return true;
                }
                catch (Exception ex)
                {
                    return false;
                }
            }
        }
        //Buscar Cliente por Nombre o Apellidos
        public static List<Cliente> BuscarCliente(string nombre) {
            List<Cliente> BuscarClientes = new List<Cliente>();
            using (SqlConnection conectarDb = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("sp_buscar_cliente", conectarDb);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@cadena", nombre);
                try
                {
                    conectarDb.Open();
                    cmd.ExecuteNonQuery();
                    using (SqlDataReader leer = cmd.ExecuteReader())
                    {
                        while (leer.Read())
                        {
                            BuscarClientes.Add(new Cliente()
                            {
                                codigo = Convert.ToInt32(leer["codigo"]),
                                tp_documento = leer["tp_documento"].ToString(),
                                documento = Convert.ToInt32(leer["documento"].ToString()),
                                nombres = leer["nombres"].ToString(),
                                primer_apellido = leer["primer_apellido"].ToString(),
                                segundo_apellido = leer["segundo_apellido"].ToString(),
                                genero = leer["genero"].ToString(),
                                fecha_nacimiento = Convert.ToDateTime(leer["fecha_nacimiento"].ToString()),
                                dir_casa = leer["dir_casa"].ToString(),
                                dir_trabajo = leer["dir_trabajo"].ToString(),
                                tfno_casa = leer["tfno_casa"].ToString(),
                                tfno_trabajo = leer["tfno_trabajo"].ToString(),
                                email = leer["email"].ToString()
                            });
                        }
                    }
                    return BuscarClientes;
                }
                catch (Exception ex)
                {

                    return BuscarClientes;
                }
            }
        }
        //Buscar Cliente por Documento
        public static List<Cliente> BuscarClientexDocumento(int documento)
        {
            List<Cliente> BuscarClientes = new List<Cliente>();
            using (SqlConnection conectarDb = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("sp_buscar_cliente_documento", conectarDb);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@documento", documento);
                try
                {
                    conectarDb.Open();
                    cmd.ExecuteNonQuery();
                    using (SqlDataReader leer = cmd.ExecuteReader())
                    {
                        while (leer.Read())
                        {
                            BuscarClientes.Add(new Cliente()
                            {
                                tp_documento = leer["tp_documento"].ToString(),
                                documento = Convert.ToInt32(leer["documento"].ToString()),
                                nombres = leer["nombres"].ToString(),
                                primer_apellido = leer["primer_apellido"].ToString(),
                                segundo_apellido = leer["segundo_apellido"].ToString()
                            });
                        }
                    }
                    return BuscarClientes;
                }
                catch (Exception ex)
                {

                    return BuscarClientes;
                }
            }
        }
        //Buscar Clientes por Rango de Fechas
        public static List<Cliente> BuscarClienteFecNto(DateTime fechainicial, DateTime fechafinal)
        {
            List<Cliente> BuscarClientes = new List<Cliente>();
            using (SqlConnection conectarDb = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("sp_buscar_cliente_fecnato", conectarDb);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fechainicial",Convert.ToDateTime(fechainicial).ToString());
                cmd.Parameters.AddWithValue("@fechafinal", Convert.ToDateTime(fechafinal).ToString());
                try
                {
                    conectarDb.Open();
                    cmd.ExecuteNonQuery();
                    using (SqlDataReader leer = cmd.ExecuteReader())
                    {
                        while (leer.Read())
                        {
                            BuscarClientes.Add(new Cliente()
                            {
                                nombres = leer["nombres"].ToString(),
                                primer_apellido = leer["primer_apellido"].ToString(),
                                segundo_apellido = leer["segundo_apellido"].ToString(),
                                fecha_nacimiento =Convert.ToDateTime(leer["fecha_nacimiento"].ToString()),
                            });
                        }
                    }
                    return BuscarClientes;
                }
                catch (Exception ex)
                {

                    return BuscarClientes;
                }
            }
        }
        //Calcular Edad
        public static List<Cedad> CalcularEdad(string fechainicial, string fechafinal)
        {
            List<Cedad> Listaredad = new List<Cedad>();
            using (SqlConnection conectar = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand sp = new SqlCommand("sp_calcular_edad", conectar);
                sp.CommandType = CommandType.StoredProcedure;
                sp.Parameters.AddWithValue("@fechainicial", fechainicial);
                sp.Parameters.AddWithValue("@fechafinal", fechafinal);
                try
                {
                    conectar.Open();
                    sp.ExecuteNonQuery();
                    using (SqlDataReader leer = sp.ExecuteReader())
                    {
                        while (leer.Read())
                        {
                            Listaredad.Add(new Cedad()
                            {
                                edad = leer["edad"].ToString()
                            });
                        }
                    }
                    return Listaredad;
                }
                catch (Exception ex)
                {

                    return Listaredad;
                }
            }
        }
        public static List<Cliente> CalcularEdadString(string fechainicial, string fechafinal)
        {
            List<Cliente> Listaredad = new List<Cliente>();
            using (SqlConnection conectar = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand sp = new SqlCommand("sp_calcular_edad_string", conectar);
                sp.CommandType = CommandType.StoredProcedure;
                sp.Parameters.AddWithValue("@fechainicial", fechainicial);
                sp.Parameters.AddWithValue("@fechafinal", fechafinal);
                try
                {
                    conectar.Open();
                    sp.ExecuteNonQuery();
                    using (SqlDataReader leer = sp.ExecuteReader())
                    {
                        while (leer.Read())
                        {
                            Listaredad.Add(new Cliente()
                            {
                                edad = leer["edad"].ToString()
                            });
                        }
                    }
                    return Listaredad;
                }
                catch (Exception ex)
                {

                    return Listaredad;
                }
            }
        }
    }
}
