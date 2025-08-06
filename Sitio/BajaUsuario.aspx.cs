using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EC;
using Logica;

public partial class BajaUsuario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnBaja_Click(object sender, EventArgs e)
    {
        try
        {
            EC.Usuarios unUsu = (EC.Usuarios)Session["UsuarioLogueado"];
            
            FabricaLogica.GetLUsuarios().Baja(unUsu);

            Response.Redirect("Default.aspx");

        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }
}