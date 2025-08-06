using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using EC;

namespace Persistencia
{
    internal class PersistenciaUsuarios : IPUsuarios
    {
        #region Singleton
        private static PersistenciaUsuarios _instancia = null;
        private PersistenciaUsuarios() { }
        public static PersistenciaUsuarios GetInstance()
        {
            if (_instancia == null)
                _instancia = new PersistenciaUsuarios();
            return _instancia;
        }
        #endregion

        public void Alta(EC.Usuarios unUsuario)
        {
            SqlConnection _conexion = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("AltaUsuario", _conexion);
            _comando.CommandType = System.Data.CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@NomUsu", unUsuario.NombreUsu);
            _comando.Parameters.AddWithValue("@ContraUsu", unUsuario.Contraseña);
            _comando.Parameters.AddWithValue("@NomComUsu", unUsuario.NomCompleto);
            _comando.Parameters.AddWithValue("@FechaNacUsu", unUsuario.FechaNacimiento);
            _comando.Parameters.AddWithValue("@EmailUsu", unUsuario.Email);

            SqlParameter _retorno = new SqlParameter("@Retorno", SqlDbType.Int);
            _retorno.Direction = ParameterDirection.ReturnValue;
            _comando.Parameters.Add(_retorno);


            try
            {
                _conexion.Open();
                _comando.ExecuteNonQuery();

                int resultado = Convert.ToInt32(_retorno.Value);

                if (resultado == -1)
                    throw new Exception("Ya existe un usuario con ese nombre de usuario.");

                else if (resultado == 2)
                    throw new Exception("El usuario se ha registrado con exito.");


            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                _conexion.Close();
            }
        }

        public EC.Usuarios Logueo(string nomUsu, string contraseña)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            Usuarios _unUsuario = null;

            SqlCommand _comando = new SqlCommand("LogueoUsuario", _cnn);
            _comando.CommandType = System.Data.CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@NomUsuario", nomUsu);
            _comando.Parameters.AddWithValue("@Contrasena", contraseña);

            try
            {
                _cnn.Open();
                SqlDataReader _lector = _comando.ExecuteReader();

                if (_lector.HasRows)
                {
                    _lector.Read();
                    _unUsuario = new Usuarios((string)_lector["NomUsu"], 
                        (string)_lector["ContraUsu"], 
                        (string)_lector["NomComUsu"], 
                        (string)_lector["EmailUsu"], 
                        (DateTime)_lector["FechaNacUsu"]);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                _cnn.Close();
            }

            return _unUsuario;
        }
        public void Baja(string nomUsu)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            SqlCommand _comando = new SqlCommand("BajaUsuario", _cnn);
            _comando.CommandType = System.Data.CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@NomUsu", nomUsu);

            SqlParameter _retorno = new SqlParameter("@retorno", System.Data.SqlDbType.Int);
            _retorno.Direction = System.Data.ParameterDirection.ReturnValue;
            _comando.Parameters.Add(_retorno);

            try
            {
                _cnn.Open();
                _comando.ExecuteNonQuery();

                if ((int)_retorno.Value == -1)
                    throw new Exception("No existe el usuario, no se puede eliminar!");

                else if ((int)_retorno.Value == -3)
                    throw new Exception("Ocurrió un error al intentar eliminar el Usuario!");
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                _cnn.Close();
            }
        }

        public void ModificarContraseña(EC.Usuarios nomUsu, string contraseña)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            SqlCommand _comando = new SqlCommand("ModificarContrasenia", _cnn);
            _comando.CommandType = System.Data.CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@NomUsu", nomUsu.NombreUsu);
            _comando.Parameters.AddWithValue("@NuevaContra", contraseña);

            SqlParameter _retorno = new SqlParameter("@Retorno", SqlDbType.Int);
            _retorno.Direction = ParameterDirection.ReturnValue;
            _comando.Parameters.Add(_retorno);

            try
            {
                _cnn.Open();
                _comando.ExecuteNonQuery();

                if ((int)_retorno.Value == -1)
                    throw new Exception("El usuario no existe, no se puede modificar la contraseña.");
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                _cnn.Close();
            }
        }

        public EC.Usuarios BuscarActivos(string nomUsu)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            EC.Usuarios _unUsuario = null;

            try
            {
                _cnn.Open();

                SqlCommand _comando = new SqlCommand("BuscarUsuActivos", _cnn);
                _comando.CommandType = CommandType.StoredProcedure;
                _comando.Parameters.AddWithValue("@NomUsu", nomUsu);

                SqlDataReader _lector = _comando.ExecuteReader();

                if (_lector.HasRows)
                {
                    _lector.Read();
                    string _nomUsu = (string)_lector["NomUsu"];
                    string _contraseña = (string)_lector["ContraUsu"];
                    string _nomCompl = (string)_lector["NomComUsu"];
                    string _email = (string)_lector["EmailUsu"];
                    DateTime _fechaNac = (DateTime)_lector["FechaNacUsu"];
                    _unUsuario = new EC.Usuarios(_nomUsu, _contraseña, _nomCompl, _email, _fechaNac);
                }

                _lector.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally 
            {
                _cnn.Close();
            }
            return _unUsuario;
        }

        internal EC.Usuarios BuscarTodos(string nomUsu)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            EC.Usuarios _unUsuario = null;

            try
            {
                _cnn.Open();

                SqlCommand _comando = new SqlCommand("BuscarUsuarios", _cnn);
                _comando.CommandType = CommandType.StoredProcedure;
                _comando.Parameters.AddWithValue("@NomUsu", nomUsu);

                SqlDataReader _lector = _comando.ExecuteReader();

                if (_lector.HasRows)
                {
                    _lector.Read();
                    string _nomUsu = (string)_lector["NomUsu"];
                    string _contraseña = (string)_lector["ContraUsu"];
                    string _nomCompl = (string)_lector["NomComUsu"];
                    string _email = (string)_lector["EmailUsu"];
                    DateTime _fechaNac = (DateTime)_lector["FechaNacUsu"];
                    _unUsuario = new EC.Usuarios(_nomUsu, _contraseña, _nomCompl, _email, _fechaNac);
                }

                _lector.Close();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                _cnn.Close();
            }
            return _unUsuario;
        }
        public List<EC.Usuarios> Listo()
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            Usuarios _unUsuario = null;
            List <EC.Usuarios> _lista = new List<EC.Usuarios>();

            SqlCommand _comando = new SqlCommand("ListarUsuariosActivos", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;

            try
            {
                _cnn.Open();
                SqlDataReader _lector = _comando.ExecuteReader();

                if (_lector.HasRows)
                {
                    while (_lector.Read())
                    {
                        _unUsuario = new Usuarios((string)_lector["NomUsu"],
                        (string)_lector["ContraUsu"],
                        (string)_lector["NomComUsu"],
                        (string)_lector["EmailUsu"],
                        (DateTime)_lector["FechaNacUsu"]);
                        _lista.Add(_unUsuario);
                    }
                }
                _lector.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                _cnn.Close();
            }
            return _lista;
        }
    }
}
