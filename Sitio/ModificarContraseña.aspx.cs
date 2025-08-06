using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EC;
using Logica;
using System.Drawing;

public partial class ModificarContraseña : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        try
        {
            EC.Usuarios unUsu = (EC.Usuarios)Session["UsuarioLogueado"];

            string contraIngresada = txtPassActual.Text.Trim();
            string contraUsu = unUsu.Contraseña;
            if (contraIngresada != contraUsu)
                throw new Exception("Contraseña incorrecta.");

            string contraNueva = txtNewPass.Text.Trim();
            string contraValidar = txtConfirmPass.Text.Trim();
            if (contraNueva != contraValidar)
                throw new Exception("Las contraseñas no coinciden.");

            Logica.FabricaLogica.GetLUsuarios().ModificarContraseña(unUsu, contraNueva);
            unUsu.Contraseña = contraNueva;

            lblError.ForeColor = Color.Green;
            lblError.Text = "La contraseña ha sido actualizada.";
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }
}