using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace EC
{
    public class Usuarios
    {
        private string _nombreUsu, _contraseña, _nomCompleto, _email;
        private DateTime _fechaNac;

        public string NombreUsu
        {
            get { return _nombreUsu; }

            set 
            {
                if (value.Trim() == "")
                    throw new Exception("El nombre de usuario no puede estar vacío.");

                if (Regex.IsMatch(value.Trim(), "^[a-zA-Z0-9_]{5,20}$"))
                    _nombreUsu = value.Trim();

                else
                    throw new Exception("El nombre debe tener entre 8 y 20 caracteres.");
            }
        }

        public string Contraseña
        {
            get { return _contraseña; }

            set 
            {
                if (value.Trim() == "")
                    throw new Exception("Debe ingresar una contraseña.");

                if (Regex.IsMatch(value.Trim(), @"^(?=(?:.*[a-zA-Z]){3,})(?=(?:.*[0-9]){3,})(?=(?:.*[^a-zA-Z0-9]){2,}).{8}$"))
                    _contraseña = value.Trim();
                else
                    throw new Exception("Su contraseña debe tener exactamente 8 caracteres: 3 letras, 3 numeros y 2 simbolos");
            }
        }

        public string NomCompleto
        {
            get { return _nomCompleto; }

            set
            {
                if (value.Trim() == "")
                    throw new Exception("Debe ingresar su nombre completo.");

                if (Regex.IsMatch(value.Trim(), "[a-zA-Z ]{5,50}"))
                    _nomCompleto = value.Trim();

                else
                    throw new Exception("El nombre debe tener entre 5 y 50 caracteres.");
            }
        }

        public string Email
        {
            get { return _email; }

            set 
            {
                if (value.Trim() == "")
                    throw new Exception("Tiene que ingresar un email.");

                if (value.Length > 100)
                    throw new Exception("El email debe tener menos de 100 caracteres.");

                if (!Regex.IsMatch(value.Trim(), @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"))
                    throw new Exception("El formato del email no es válido.");
                    
                _email = value;
            }
        }

        public DateTime FechaNacimiento
        {
            get { return _fechaNac; }

            set
            {
                if (value >= DateTime.Now.Date)
                    throw new Exception("Su fecha de nacimiento debe ser menor a la fecha actual.");

                _fechaNac = value;
                    
            }
        }

        public Usuarios(string pNomUsu, string pContra, string pNomCompl, string pEmail, DateTime pFechaNac)
        {
            NombreUsu = pNomUsu;
            Contraseña = pContra;
            NomCompleto = pNomCompl;
            Email = pEmail;
            FechaNacimiento = pFechaNac;
        }
    }
}
