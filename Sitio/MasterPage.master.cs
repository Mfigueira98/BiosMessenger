using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            EC.Usuarios usuLogueado = (EC.Usuarios)Session["UsuarioLogueado"];

            if (usuLogueado != null)
            {
                lblUsuario.Text = usuLogueado.NombreUsu;
            }
        }
    }

    protected void btnSalir_Click(object sender, EventArgs e)
    {
        Session["UsuarioLogueado"] = null;
        Response.Redirect("~/Default.aspx");
    }
}
