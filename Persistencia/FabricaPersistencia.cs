using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Persistencia
{
    public class FabricaPersistencia
    {
        public static IPUsuarios GetPUsuarios()
        {
            return PersistenciaUsuarios.GetInstance();
        }

        public static IPRecordatorios GetPRecordatorios()
        {
            return PersistenciaRecordatorios.GetInstance();
        }

        public static IPCategorias GetPCategorias()
        {
            return PersistenciaCategorias.GetInstance();
        }

        public static IPComunes GetPComunes()
        {
            return PersistenciaComunes.GetInstance();
        }

        public static IPPrivados GetPPrivados()
        {
            return PersistenciaPrivados.GetInstance();
        }


    }
}
