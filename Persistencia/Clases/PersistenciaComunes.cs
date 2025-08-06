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
    internal class PersistenciaComunes:IPComunes
    {
        #region Singleton
        private static PersistenciaComunes _instancia = null;
        private PersistenciaComunes() { }
        public static PersistenciaComunes GetInstance()
        {
            if (_instancia == null)
                _instancia = new PersistenciaComunes();
            return _instancia;
        }
        #endregion

        public void Alta(EC.Comunes unComun)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("AltaMensajeComun", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@asunto", unComun.Asunto);
            _comando.Parameters.AddWithValue("@texto", unComun.Texto);
            _comando.Parameters.AddWithValue("@codigoCat", unComun.Categoria.CodigoCat);
            _comando.Parameters.AddWithValue("@usuarioEnvia", unComun.NomUsuEnvia.NombreUsu);
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
                    throw new Exception("No existe la categoría.");

                if (_numeroId == -2)
                    throw new Exception("El usuario no existe.");

                else if (_numeroId == 0)
                    throw new Exception("Error no especificado.");

                foreach (EC.Usuarios unUsuario in unComun.NomUsuReciben)
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

        public List<EC.Comunes> Listar()
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("ListarMensajesComunes", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;

            List<EC.Comunes> _lista = new List<EC.Comunes>();
            EC.Comunes _unComun = null;

            try
            {
                _cnn.Open();

                SqlDataReader _lector = _comando.ExecuteReader();

                if (_lector.HasRows)
                {
                    while (_lector.Read())
                    {
                        _unComun = new Comunes((int)_lector["IdMensaje"],
                            (string)_lector["Asunto"],
                            (string)_lector["Texto"],
                            (DateTime)_lector["FechaHoraEnvio"],
                            PersistenciaUsuarios.GetInstance().BuscarTodos((string)_lector["NomUsu"]),
                            PersistenciaReciben.GetInstance().ListarUsuariosDeMensaje((int)_lector["IdMensaje"]),
                            PersistenciaCategorias.GetInstance().Buscar((string)_lector["CodigoCategoria"]));
                        _lista.Add(_unComun);

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

        public List<EC.Comunes> ListarMensajesSalida(EC.Usuarios unUsu)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            Comunes _unComun = null;
            List<EC.Comunes> _lista = new List<EC.Comunes>();

            SqlCommand _comando = new SqlCommand("ListarMensajesComunesEnviados", _cnn);
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
                        _unComun = new Comunes((int)_lector["IdMensaje"],
                            (string)_lector["Asunto"],
                            (string)_lector["Texto"],
                            (DateTime)_lector["FechaHoraEnvio"],
                            PersistenciaUsuarios.GetInstance().BuscarTodos((string)_lector["NomUsu"]),
                            PersistenciaReciben.GetInstance().ListarUsuariosDeMensaje((int)_lector["IdMensaje"]),
                            PersistenciaCategorias.GetInstance().Buscar((string)_lector["CodigoCategoria"]));
                        _lista.Add(_unComun);
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

        public List<EC.Comunes> ListarMensajesEntrada(EC.Usuarios unUsu)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            Comunes _unComun = null;
            List<EC.Comunes> _lista = new List<EC.Comunes>();

            SqlCommand _comando = new SqlCommand("ListarMensajesComunesRecibidos", _cnn);
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
                        _unComun = new Comunes((int)_lector["IdMensaje"],
                            (string)_lector["Asunto"],
                            (string)_lector["Texto"],
                            (DateTime)_lector["FechaHoraEnvio"],
                            PersistenciaUsuarios.GetInstance().BuscarTodos((string)_lector["NomUsu"]),
                            PersistenciaReciben.GetInstance().ListarUsuariosDeMensaje((int)_lector["IdMensaje"]),
                            PersistenciaCategorias.GetInstance().Buscar((string)_lector["CodigoCategoria"]));
                        _lista.Add(_unComun);
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
