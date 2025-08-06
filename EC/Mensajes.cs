using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace EC
{
    public abstract class Mensajes
    {
        private int _idMensaje;
        private string _asunto, _texto;
        private DateTime _fechaHoraEnvio;
        private Usuarios _nomUsuEnvia;
        private List<Usuarios> _nomUsuReciben;

        public int IdMensaje
        {
            get { return _idMensaje; }
            set { _idMensaje = value; }
        }

        public DateTime FechaHoraEnvio
        {
            get { return _fechaHoraEnvio; }
            set { _fechaHoraEnvio = value; }
        }

        public string Asunto
        {
            get { return _asunto; }

            set
            {
                if (value.Trim() == "")
                    throw new Exception("Debe ingresar un asunto.");

                if (value.Trim().Length <= 100)
                    _asunto = value.Trim();
                else
                    throw new Exception("El asunto no puede exceder los 100 caracteres.");
            }
        }

        public string Texto
        {
            get { return _texto; }

            set
            {
                if (value.Trim() == "")
                    throw new Exception("No es posible enviar un mensaje vacío.");

                if (value.Trim().Length <= 1000)
                    _texto = value.Trim();
                else
                    throw new Exception("El texto no puede exceder los 1000 caracteres.");
            }
        }

        public Usuarios NomUsuEnvia
        {
            get { return _nomUsuEnvia; }
            set
            {
                if (value == null)
                    throw new Exception("Debe ingresar un Usuario.");

                _nomUsuEnvia = value;
            }
        }

        public List<Usuarios> NomUsuReciben
        {
            get { return _nomUsuReciben; }
            set
            {

                if (value == null)
                    throw new Exception("La lista de usuarios no puede estar vacía.");

                if (value.Count == 0)
                    throw new Exception("Debe ingresar al menos un usuario.");

                _nomUsuReciben = value;
            }
        }

        public Mensajes(int pNumeroId, string pAsunto, string pTexto, DateTime pFechaHora, Usuarios pNomUsuEnvia, List<Usuarios> pNomUsuReciben)
        {
            IdMensaje = pNumeroId;
            Asunto = pAsunto;
            Texto = pTexto;
            FechaHoraEnvio = pFechaHora;
            NomUsuEnvia = pNomUsuEnvia;
            NomUsuReciben = pNomUsuReciben;
        }
    }
}
