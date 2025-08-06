using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Logica
{
    public class FabricaLogica
    {
        public static ILogicaUsuarios GetLUsuarios()
        {
            return (LogicaUsuarios.GetInstancia());
        }

        public static ILogicaCategorias GetLCategorias()
        {
            return (LogicaCategorias.GetInstancia());
        }

        public static ILogicaMensajes GetLMensajes()
        {
            return LogicaMensajes.GetInstancia();
        }
    }
}
