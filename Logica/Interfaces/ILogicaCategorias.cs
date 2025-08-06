using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Logica
{
    public interface ILogicaCategorias
    {
        EC.Categorias Buscar(string codigo);
        List<EC.Categorias> Listo();
    }
}
