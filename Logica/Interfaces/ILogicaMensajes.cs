using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Logica
{
    public interface ILogicaMensajes
    {
        void Alta(EC.Mensajes unMensajes);
        List<EC.Mensajes> ListarMensajesSalida(EC.Usuarios unUsu);
        List<EC.Mensajes> ListarMensajesEntrada(EC.Usuarios unUsu);
        List<EC.Mensajes> Listar();

    }
}
