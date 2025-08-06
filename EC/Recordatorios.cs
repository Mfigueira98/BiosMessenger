using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EC
{
    public class Recordatorios:Mensajes
    {
        private string _tipoRecordatorio;

        public string TipoRecordatorio
        {
            get { return _tipoRecordatorio; }

            set
            {
                if ((value.Trim() != "Laboral") && (value.Trim() != "Personal") && (value.Trim() != "Estudio"))
                    throw new Exception("Debe ingresar un tipo de recordatorio ya prestablecido: Laboral, Personal o Estudio.");

                _tipoRecordatorio = value.Trim();
            }
        }

        public Recordatorios(int pNumeroId, string pAsunto, string pTexto, DateTime pFechaHora, Usuarios pNomUsuEnvia, List<Usuarios> pNomUsuReciben, string pTipoRecordatorio)
           : base(pNumeroId, pAsunto, pTexto, pFechaHora, pNomUsuEnvia, pNomUsuReciben)
        {
            TipoRecordatorio = pTipoRecordatorio;
        }
    }
}
