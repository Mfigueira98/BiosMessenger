using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EC;
using Logica;
using System.Drawing;

public partial class AltaUsuario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    private void LimpioPantalla()
    {
        txtNomUsu.Text = "";
        txtPass.Text = "";
        txtNomComp.Text = "";
        txtEmail.Text = "";
        txtFechaNac.Text = "";
    }
    protected void btnRegistro_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime fechaNac = Convert.ToDateTime(txtFechaNac.Text);

            EC.Usuarios unUsu = null;
            unUsu = new EC.Usuarios(txtNomUsu.Text.Trim(), txtPass.Text.Trim(), txtNomComp.Text.Trim(),
                txtEmail.Text.Trim(), fechaNac);
            Logica.FabricaLogica.GetLUsuarios().Alta(unUsu);

            LimpioPantalla();
            lblError.ForeColor = Color.Green;
            lblError.Text = "El usuario ha sido registrado exitosamente.";
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }
    protected void btnLimpiar_Click(object sender, EventArgs e)
    {
        LimpioPantalla();
    }
}