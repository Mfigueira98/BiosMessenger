using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EC;
using Persistencia;

namespace Logica
{
    internal class LogicaMensajes : ILogicaMensajes
    {
        private static LogicaMensajes _instancia = null;
        private LogicaMensajes() { }
        public static LogicaMensajes GetInstancia()
        {
            if (_instancia == null)
                _instancia = new LogicaMensajes();
            return _instancia;
        }

        public void Alta(Mensajes unMensaje)
        {
            if(unMensaje is Comunes)
                FabricaPersistencia.GetPComunes().Alta((Comunes)unMensaje);

            else if (unMensaje is Privados privado)
            {
                if (privado.FechaCad > DateTime.Now.AddHours(24))
                    FabricaPersistencia.GetPPrivados().Alta((Privados)unMensaje);

                else
                    throw new Exception("La fecha de caducidad debe ser mayor a 24 horas.");
            }

            else
            {
                FabricaPersistencia.GetPRecordatorios().Alta((Recordatorios)unMensaje);
            }
        }

        public List<Mensajes> Listar()
        {
            List<Mensajes> _lista = new List<Mensajes>();

            _lista.AddRange(FabricaPersistencia.GetPComunes().Listar());
            _lista.AddRange(FabricaPersistencia.GetPPrivados().Listar());
            _lista.AddRange(FabricaPersistencia.GetPRecordatorios().Listar());

            _lista = (from unM in (_lista)
                               orderby unM.FechaHoraEnvio descending
                               select unM).ToList();

            return _lista;
        }

        public List<Mensajes> ListarMensajesSalida(Usuarios unUsu)
        {
            List<Mensajes> _lista = new List<Mensajes>();

            _lista.AddRange(FabricaPersistencia.GetPComunes().ListarMensajesSalida(unUsu));
            _lista.AddRange(FabricaPersistencia.GetPPrivados().ListarMensajesSalida(unUsu));
            _lista.AddRange(FabricaPersistencia.GetPRecordatorios().ListarMensajesSalida(unUsu));

            _lista = (from unM in (_lista)
                      orderby unM.FechaHoraEnvio descending
                      select unM).ToList();
                    

            return _lista;
        }

        public List<Mensajes> ListarMensajesEntrada(Usuarios unUsu)
        {
            List<Mensajes> _lista = new List<Mensajes>();

            _lista.AddRange(FabricaPersistencia.GetPComunes().ListarMensajesEntrada(unUsu));
            _lista.AddRange(FabricaPersistencia.GetPPrivados().ListarMensajesEntrada(unUsu));
            _lista.AddRange(FabricaPersistencia.GetPRecordatorios().ListarMensajesEntrada(unUsu));

            _lista = (from unM in (_lista)
                      orderby unM.FechaHoraEnvio descending
                      select unM).ToList();

            return _lista;
        }
    }
}
