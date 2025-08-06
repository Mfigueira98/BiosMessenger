using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EC
{
    public class Comunes:Mensajes
    {
        private Categorias _categoria;

        public Categorias Categoria
        {
            get { return _categoria; }

            set
            {
                if (value == null)
                    throw new Exception("Debe ingresar una categoría.");

                _categoria = value;

            }
        }

        public Comunes(int pNumeroId, string pAsunto, string pTexto, DateTime pFechaHora, Usuarios pNomUsuEnvia, List<Usuarios> pNomUsuReciben, Categorias pCategoria)
            : base(pNumeroId, pAsunto, pTexto, pFechaHora, pNomUsuEnvia, pNomUsuReciben)
        {
            Categoria = pCategoria;
        }
    }
}
