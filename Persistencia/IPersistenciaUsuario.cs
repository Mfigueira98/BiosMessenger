using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EC;

namespace Persistencia
{
    public interface IPersistenciaUsuario
    {
        void AltaUsuario(Usuarios UnU);
        void ModificarContrasenia(string nomUsu, string nuevaContra);
        void EliminarUsuarioPropio(string nomUsu);
        

    }
}
