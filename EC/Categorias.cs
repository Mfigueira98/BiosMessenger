using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace EC
{
    public class Categorias
    {
        private string _nombreCat, _codigoCat;

        public string NombreCat
        {
            get { return _nombreCat; }
            set
            {
                if (value.Trim() == "")
                    throw new Exception("Debe ingresar un nombre para la categoría.");

                if (Regex.IsMatch(value.Trim(), "[a-zA-Z]{5,30}"))
                    _nombreCat = value.Trim();
                else
                    throw new Exception("El nombre de la categoria debe tener entre 5 y 30 caracteres.");

            }
        }

        public string CodigoCat
        {
            get { return _codigoCat; }
            set
            {
                if (value.Trim() == "")
                    throw new Exception("Debe ingresar una categoría.");

                if (Regex.IsMatch(value.Trim(), "[a-zA-Z]{3}"))
                    _codigoCat = value.Trim();
                else
                    throw new Exception("El código debe tener exactamente 3 letras.");
            }
        }

        public Categorias(string pNombreCat, string pCodigoCat)
        {
            NombreCat = pNombreCat;
            CodigoCat = pCodigoCat;
        }
    }
}
