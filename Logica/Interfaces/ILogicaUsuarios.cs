using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Logica
{
    public interface ILogicaUsuarios
    {
        void Alta(EC.Usuarios unUsu);
        void Baja(EC.Usuarios unUsu);
        EC.Usuarios Logueo(string nomUsu, string contraseña);
        void ModificarContraseña(EC.Usuarios nomUsu, string contraseña);
        EC.Usuarios BuscarActivos(string nomUsu);
        List<EC.Usuarios> Listo();

    }
}
