using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Persistencia
{
    public interface IPUsuarios
    {
        EC.Usuarios Logueo(string nomUsu, string contraseña);
        void Alta(EC.Usuarios unUsu);
        void Baja(string nomUsu);
        EC.Usuarios BuscarActivos(string nomUsu);
        void ModificarContraseña(EC.Usuarios nomUsu, string contraseña);
        List<EC.Usuarios> Listo();
    }
}
