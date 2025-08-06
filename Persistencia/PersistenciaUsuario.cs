using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;
using EC;

namespace Persistencia
{
    internal class PersistenciaUsuario:IPersistenciaUsuario
    {
        private static PersistenciaUsuario _instancia = null;

        private PersistenciaUsuario() { }

        public static PersistenciaUsuario GetInstancia()
        {
            if (_instancia == null)
                _instancia = new PersistenciaUsuario();

            return _instancia;
        }

        public void AltaUsuario(Usuarios u)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.Cnn);
            SqlCommand oComando = new SqlCommand("AltaUsuario", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            // Parámetros de entrada
            SqlParameter _nombreUsu = new SqlParameter("@NomUsu", u.NombreUsu);
            SqlParameter _contra = new SqlParameter("@Contra", u.Contraseña);
            SqlParameter _nomCompleto = new SqlParameter("@NombreCompleto", u.NomCompleto);
            SqlParameter _fechaNac = new SqlParameter("@FechaNac", u.FechaNacimiento);
            SqlParameter _email = new SqlParameter("@Email", u.Email);

            // Parámetro de retorno
            SqlParameter _retorno = new SqlParameter("@Retorno", SqlDbType.Int);
            _retorno.Direction = ParameterDirection.ReturnValue;

            // Agregar parámetros al comando
            oComando.Parameters.Add(_nombreUsu);
            oComando.Parameters.Add(_contra);
            oComando.Parameters.Add(_nomCompleto);
            oComando.Parameters.Add(_fechaNac);
            oComando.Parameters.Add(_email);
            oComando.Parameters.Add(_retorno);

            try
            {
                oConexion.Open();
                oComando.ExecuteNonQuery();

                int resultado = Convert.ToInt32(_retorno.Value);

                switch (resultado)
                {
                    case -1:
                        throw new Exception("Ya existe un usuario con ese nombre.");
                    case -2:
                        throw new Exception("Error interno en la base de datos.");
                    case 1:
                        // Salio bien
                        break;
                    default:
                        throw new Exception("Error desconocido.");
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al dar de alta el usuario: " + ex.Message);
            }
            finally
            {
                oConexion.Close();
            }
        }

        public void ModificarContrasenia(string nomUsu, string nuevaContra)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.Cnn);
            SqlCommand oComando = new SqlCommand("ModificarContraseniaUsuario", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@NomUsu", nomUsu);
            oComando.Parameters.AddWithValue("@NuevaContra", nuevaContra);

            SqlParameter _Retorno = new SqlParameter("@Retorno", SqlDbType.Int);
            _Retorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(_Retorno);

            try
            {
                oConexion.Open();
                oComando.ExecuteNonQuery();
                int resultado = (int)_Retorno.Value;

                if (resultado == -1)
                    throw new Exception("El usuario no existe.");
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al modificar la contraseña: " + ex.Message);
            }
            finally
            {
                oConexion.Close();
            }
        }
        public void EliminarUsuarioPropio(string nomUsu)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.Cnn);
            SqlCommand oComando = new SqlCommand("EliminarUsuarioPropio", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@NomUsu", nomUsu);

            SqlParameter _Retorno = new SqlParameter("@Retorno", SqlDbType.Int);
            _Retorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(_Retorno);

            try
            {
                oConexion.Open();
                oComando.ExecuteNonQuery();
                int resultado = (int)_Retorno.Value;

                if (resultado == -1)
                    throw new Exception("El usuario no existe.");
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al eliminar el usuario: " + ex.Message);
            }
            finally
            {
                oConexion.Close();
            }
        }

    }
}
