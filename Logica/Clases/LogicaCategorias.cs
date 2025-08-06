using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EC;
using Persistencia;

namespace Logica
{
    internal class LogicaCategorias : ILogicaCategorias
    {
        private static LogicaCategorias _instancia = null;
        private LogicaCategorias() { }

        public static LogicaCategorias GetInstancia()
        {
            if (_instancia == null)
                _instancia = new LogicaCategorias();
            return _instancia;
        }

        public Categorias Buscar(string codigo)
        {
            return FabricaPersistencia.GetPCategorias().Buscar(codigo);
        }

        public List<Categorias> Listo()
        {
            return FabricaPersistencia.GetPCategorias().Listo();
        }
    }
}
