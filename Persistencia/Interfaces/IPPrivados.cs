using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Persistencia
{
    public interface IPPrivados
    {
        void Alta(EC.Privados unPrivado);
        List<EC.Privados> ListarMensajesSalida(EC.Usuarios unUsu);
        List<EC.Privados> ListarMensajesEntrada(EC.Usuarios unUsu);
        List<EC.Privados> Listar();
    }
}
