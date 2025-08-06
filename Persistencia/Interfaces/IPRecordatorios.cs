using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Persistencia
{
    public interface IPRecordatorios
    {
        void Alta(EC.Recordatorios unRecordatorio);
        List<EC.Recordatorios> ListarMensajesSalida(EC.Usuarios unUsu);
        List<EC.Recordatorios> ListarMensajesEntrada(EC.Usuarios unUsu);
        List<EC.Recordatorios> Listar();
    }
}
