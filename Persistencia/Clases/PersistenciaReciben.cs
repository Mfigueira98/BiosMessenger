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
       internal class PersistenciaReciben
    {
        #region Singleton
        private static PersistenciaReciben _instancia;
        private PersistenciaReciben() { }
        public static PersistenciaReciben GetInstance()
        {
            if (_instancia == null)
                _instancia = new PersistenciaReciben();

            return _instancia;
        }
        #endregion

        internal void AltaUsuReciben(Usuarios nomUsuReciben, int numeroId, SqlTransaction transaccion)
        {
            SqlCommand _comando = new SqlCommand("AltaUsuarioReciben", transaccion.Connection);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@nomUsuReciben", nomUsuReciben.NombreUsu);
            _comando.Parameters.AddWithValue("@idMensaje", numeroId);

            SqlParameter _retornoSP = new SqlParameter("@RetornoSP", SqlDbType.Int);
            _retornoSP.Direction = ParameterDirection.ReturnValue;
            _comando.Parameters.Add(_retornoSP);

            try
            {
                _comando.Transaction = transaccion;
                _comando.ExecuteNonQuery();

                if ((int)_retornoSP.Value == -1)
                    throw new Exception("El usuario no existe - ERROR.");

                if ((int)_retornoSP.Value == -2)
                    throw new Exception("El mensaje no existe - ERROR.");

                if ((int)_retornoSP.Value == -3)
                    throw new Exception("No se puede ingresar el mismo usuario - ERROR.");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal List<Usuarios> ListarUsuariosDeMensaje(int numeroId)
        {
            List<Usuarios> _lista = new List<Usuarios>();

            SqlConnection _conexion = new SqlConnection(Conexion.Cnn);
            SqlCommand _comando = new SqlCommand("UsuarioReciben", _conexion);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@idMensaje", numeroId);

            SqlDataReader _lector;
            try
            {
                _conexion.Open();
                _lector = _comando.ExecuteReader();

                if (_lector.HasRows)
                {
                    while (_lector.Read())
                    {
                        _lista.Add(new Usuarios((string)_lector["NomUsu"], 
                            (string)_lector["ContraUsu"], 
                            (string)_lector["NomComUsu"], 
                            (string)_lector["EmailUsu"], 
                            (DateTime)_lector["FechaNacUsu"]));                            
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                _conexion.Close();
            }
            return _lista;
        }
    }
}
