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
    internal class PersistenciaPrivados:IPPrivados
    {
        #region Singleton
        private static PersistenciaPrivados _instancia = null;
        private PersistenciaPrivados() { }
        public static PersistenciaPrivados GetInstance()
        {
            if (_instancia == null)
                _instancia = new PersistenciaPrivados();
            return _instancia;
        }
        #endregion

        public void Alta(EC.Privados unPrivado)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("AltaMensajePrivado", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@asunto", unPrivado.Asunto);
            _comando.Parameters.AddWithValue("@texto", unPrivado.Texto);
            _comando.Parameters.AddWithValue("@fechaCaducidad", unPrivado.FechaCad);
            _comando.Parameters.AddWithValue("@usuarioEnvia", unPrivado.NomUsuEnvia.NombreUsu);
            SqlParameter _retorno = new SqlParameter("@Retorno", SqlDbType.Int);
            _retorno.Direction = ParameterDirection.ReturnValue;
            _comando.Parameters.Add(_retorno);

            SqlTransaction _transaccion = null;

            try
            {
                _cnn.Open();

                _transaccion = _cnn.BeginTransaction();

                _comando.Transaction = _transaccion;
                _comando.ExecuteNonQuery();

                int _numeroId = Convert.ToInt32(_retorno.Value);

                if (_numeroId == -1)
                    throw new Exception("El usuario no existe.");

                else if (_numeroId == 0)
                    throw new Exception("Error no especificado.");

                foreach (EC.Usuarios unUsuario in unPrivado.NomUsuReciben)
                {
                    PersistenciaReciben.GetInstance().AltaUsuReciben(unUsuario, _numeroId, _transaccion);
                }

                _transaccion.Commit();

            }
            catch (Exception ex)
            {
                _transaccion.Rollback();
                throw ex;
            }
            finally
            {
                _cnn.Close();
            }
        }

        public List<EC.Privados> Listar()
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("ListarMensajesPrivados", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;

            List<EC.Privados> _lista = new List<EC.Privados>();
            EC.Privados _unPrivado = null;

            try
            {
                _cnn.Open();

                SqlDataReader _lector = _comando.ExecuteReader();

                if (_lector.HasRows)
                {
                    while (_lector.Read())
                    {
                        _unPrivado = new Privados((int)_lector["IdMensaje"],
                            (string)_lector["Asunto"],
                            (string)_lector["Texto"],
                            (DateTime)_lector["FechaHoraEnvio"],
                            PersistenciaUsuarios.GetInstance().BuscarTodos((string)_lector["NomUsu"]),
                            PersistenciaReciben.GetInstance().ListarUsuariosDeMensaje((int)_lector["IdMensaje"]),
                            (DateTime)_lector["FechaCaducidad"]);
                        _lista.Add(_unPrivado);

                    }
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
            return _lista;
        }

        public List<EC.Privados> ListarMensajesSalida(EC.Usuarios unUsu)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            Privados _unPrivado = null;
            List<EC.Privados> _lista = new List<EC.Privados>();

            SqlCommand _comando = new SqlCommand("ListarMensajesPrivadosEnviados", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@nomUsu", unUsu.NombreUsu);

            try
            {
                _cnn.Open();
                SqlDataReader _lector = _comando.ExecuteReader();

                if (_lector.HasRows)
                {
                    while (_lector.Read())
                    {
                        _unPrivado = new Privados((int)_lector["IdMensaje"],
                            (string)_lector["Asunto"],
                            (string)_lector["Texto"],
                            (DateTime)_lector["FechaHoraEnvio"],
                            PersistenciaUsuarios.GetInstance().BuscarTodos((string)_lector["NomUsu"]),
                            PersistenciaReciben.GetInstance().ListarUsuariosDeMensaje((int)_lector["IdMensaje"]),
                            (DateTime)_lector["FechaCaducidad"]);
                        _lista.Add(_unPrivado);
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

        public List<EC.Privados> ListarMensajesEntrada(EC.Usuarios unUsu)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            Privados _unPrivado = null;
            List<EC.Privados> _lista = new List<EC.Privados>();

            SqlCommand _comando = new SqlCommand("ListarMensajesPrivadosRecibidos", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@nomUsu", unUsu.NombreUsu);

            try
            {
                _cnn.Open();
                SqlDataReader _lector = _comando.ExecuteReader();

                if (_lector.HasRows)
                {
                    while (_lector.Read())
                    {
                        _unPrivado = new Privados((int)_lector["IdMensaje"],
                            (string)_lector["Asunto"],
                            (string)_lector["Texto"],
                            (DateTime)_lector["FechaHoraEnvio"],
                            PersistenciaUsuarios.GetInstance().BuscarTodos((string)_lector["NomUsu"]),
                            PersistenciaReciben.GetInstance().ListarUsuariosDeMensaje((int)_lector["IdMensaje"]),
                            (DateTime)_lector["FechaCaducidad"]);
                        _lista.Add(_unPrivado);
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
