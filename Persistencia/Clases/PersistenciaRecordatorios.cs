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
    internal class PersistenciaRecordatorios:IPRecordatorios
    {
        #region Singleton
        private static PersistenciaRecordatorios _instancia = null;
        private PersistenciaRecordatorios() { }
        public static PersistenciaRecordatorios GetInstance()
        {
            if (_instancia == null)
                _instancia = new PersistenciaRecordatorios();
            return _instancia;
        }
        #endregion

        public void Alta(EC.Recordatorios unRecordatorio)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("AltaMensajeRecordatorio", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@asunto", unRecordatorio.Asunto);
            _comando.Parameters.AddWithValue("@texto", unRecordatorio.Texto);
            _comando.Parameters.AddWithValue("@tipoRecordatorio", unRecordatorio.TipoRecordatorio);
            _comando.Parameters.AddWithValue("@usuarioEnvia", unRecordatorio.NomUsuEnvia.NombreUsu);
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

                foreach (EC.Usuarios unUsuario in unRecordatorio.NomUsuReciben)
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

        public List<EC.Recordatorios> Listar()
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("ListarMensajesRecordatorios", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;

            List<EC.Recordatorios> _lista = new List<EC.Recordatorios>();
            EC.Recordatorios _unRecordatorio = null;

            try
            {
                _cnn.Open();

                SqlDataReader _lector = _comando.ExecuteReader();

                //Verifico si hay usuarios reciben
                if (_lector.HasRows)
                {
                    while (_lector.Read())
                    {
                        _unRecordatorio = new Recordatorios((int)_lector["IdMensaje"],
                            (string)_lector["Asunto"],
                            (string)_lector["Texto"],
                            (DateTime)_lector["FechaHoraEnvio"],
                            PersistenciaUsuarios.GetInstance().BuscarTodos((string)_lector["NomUsu"]),
                            PersistenciaReciben.GetInstance().ListarUsuariosDeMensaje((int)_lector["IdMensaje"]),
                            (string)_lector["TipoRecordatorio"]);
                        _lista.Add(_unRecordatorio);

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

        public List<EC.Recordatorios> ListarMensajesSalida(EC.Usuarios unUsu)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            Recordatorios _unRecordatorio = null;
            List<EC.Recordatorios> _lista = new List<EC.Recordatorios>();

            SqlCommand _comando = new SqlCommand("ListarMensajesRecordatoriosEnviados", _cnn);
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
                        _unRecordatorio = new Recordatorios((int)_lector["IdMensaje"],
                            (string)_lector["Asunto"],
                            (string)_lector["Texto"],
                            (DateTime)_lector["FechaHoraEnvio"],
                            PersistenciaUsuarios.GetInstance().BuscarTodos((string)_lector["NomUsu"]),
                            PersistenciaReciben.GetInstance().ListarUsuariosDeMensaje((int)_lector["IdMensaje"]),
                            (string)_lector["TipoRecordatorio"]);
                        _lista.Add(_unRecordatorio);
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

        public List<EC.Recordatorios> ListarMensajesEntrada(EC.Usuarios unUsu)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            Recordatorios _unRecordatorio = null;
            List<EC.Recordatorios> _lista = new List<EC.Recordatorios>();

            SqlCommand _comando = new SqlCommand("ListarMensajesRecordatoriosRecibidos", _cnn);
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
                        _unRecordatorio = new Recordatorios((int)_lector["IdMensaje"],
                            (string)_lector["Asunto"],
                            (string)_lector["Texto"],
                            (DateTime)_lector["FechaHoraEnvio"],
                            PersistenciaUsuarios.GetInstance().BuscarTodos((string)_lector["NomUsu"]),
                            PersistenciaReciben.GetInstance().ListarUsuariosDeMensaje((int)_lector["IdMensaje"]),
                            (string)_lector["TipoRecordatorio"]);
                        _lista.Add(_unRecordatorio);
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
