using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EC;
using Persistencia;

namespace Logica
{
    internal class LogicaUsuarios : ILogicaUsuarios
    {
        private static LogicaUsuarios _instancia = null;
        private LogicaUsuarios() { }
        public static LogicaUsuarios GetInstancia()
        {
            if (_instancia == null)
                _instancia = new LogicaUsuarios();
            return _instancia;
        }
        public void Alta(Usuarios unUsu)
        {
            FabricaPersistencia.GetPUsuarios().Alta(unUsu);
        }
        public void Baja(Usuarios unUsu)
        {
            FabricaPersistencia.GetPUsuarios().Baja(unUsu.NombreUsu);
        }
        public void ModificarContraseña(Usuarios unUsu, string nuevaContra)
        {
            FabricaPersistencia.GetPUsuarios().ModificarContraseña(unUsu, nuevaContra);
        }
        public Usuarios Logueo(string nomUsu, string contraseña)
        {
            return FabricaPersistencia.GetPUsuarios().Logueo(nomUsu, contraseña);
        }
        public Usuarios BuscarActivos(string nomUsu)
        {
            return FabricaPersistencia.GetPUsuarios().BuscarActivos(nomUsu);
        }
        public List<Usuarios> Listo()
        {
            return FabricaPersistencia.GetPUsuarios().Listo();
        }

    }
}
