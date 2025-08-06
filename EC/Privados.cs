using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EC
{
    public class Privados:Mensajes
    {
        private DateTime _fechaCad;

        public DateTime FechaCad
        {
            get { return _fechaCad; }

            set
            { _fechaCad = value; }
        }

        public Privados(int pNumeroId, string pAsunto, string pTexto, DateTime pFechaHora, Usuarios pNomUsuEnvia, List<Usuarios> pNomUsuReciben, DateTime pFechaCad)
            : base(pNumeroId, pAsunto, pTexto, pFechaHora, pNomUsuEnvia, pNomUsuReciben)
        {
            FechaCad = pFechaCad;
        }
    }
}
