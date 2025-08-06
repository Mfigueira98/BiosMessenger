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
    internal class PersistenciaCategorias:IPCategorias
    {
        #region Singleton
        private static PersistenciaCategorias _instancia = null;
        private PersistenciaCategorias() { }
        public static PersistenciaCategorias GetInstance()
        {
            if (_instancia == null)
                _instancia = new PersistenciaCategorias();
            return _instancia;
        }
        #endregion

        public EC.Categorias Buscar(string codigo)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            EC.Categorias _unaCategoria = null;

            try
            {
                _cnn.Open();
                SqlCommand _comando = new SqlCommand("BuscarCategorias", _cnn);
                _comando.CommandType = CommandType.StoredProcedure;
                _comando.Parameters.AddWithValue("@codigoCat", codigo);

                SqlDataReader _lector = _comando.ExecuteReader();

                if (_lector.HasRows)
                {
                    _lector.Read();
                    string _nomCat = (string)_lector["NombreCat"];
                    string _codCat = (string)_lector["CodigoCat"];
                    _unaCategoria = new EC.Categorias(_nomCat, _codCat);
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
            return _unaCategoria;
        }

        public List<EC.Categorias> Listo()
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            Categorias _unaCategoria = null;
            List<EC.Categorias> _lista = new List<EC.Categorias>();

            SqlCommand _comando = new SqlCommand("ListarCategorias", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;

            try
            {
                _cnn.Open();
                SqlDataReader _lector = _comando.ExecuteReader();

                if (_lector.HasRows)
                {
                    while (_lector.Read())
                    {
                        _unaCategoria = new Categorias((string)_lector["NombreCat"], (string)_lector["CodigoCat"]);
                        _lista.Add(_unaCategoria);
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
