using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Persistencia
{
    public interface IPComunes
    {
        void Alta(EC.Comunes unComun);
        List<EC.Comunes> ListarMensajesSalida(EC.Usuarios unUsu);
        List<EC.Comunes> ListarMensajesEntrada(EC.Usuarios unUsu);
        List<EC.Comunes> Listar();
    }
}
