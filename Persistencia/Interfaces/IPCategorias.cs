using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Persistencia
{
    public interface IPCategorias
    {
        List<EC.Categorias> Listo();
        EC.Categorias Buscar(string codigo);
    }
}
