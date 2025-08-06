using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using EC;
using Logica;

public partial class AltaMensajeComun : System.Web.UI.Page
{
    EC.Usuarios usuLogueado;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            usuLogueado = (EC.Usuarios)Session["UsuarioLogueado"];

            if (!IsPostBack)
            {
                if (usuLogueado == null)
                {
                    Response.Redirect("~/Default.aspx");
                }
                else
                {
                    Session["Destinatarios"] = new List<EC.Usuarios>();

                    Session["MisCategorias"] = Logica.FabricaLogica.GetLCategorias().Listo();
                    ddlCategoria.DataSource = Session["MisCategorias"];
                    ddlCategoria.DataTextField = "CodigoCat";
                    ddlCategoria.DataBind();

                    Session["MisUsuarios"] = Logica.FabricaLogica.GetLUsuarios().Listo();
                    ddlUsuarios.DataSource = Session["MisUsuarios"];
                    ddlUsuarios.DataTextField = "NombreUsu";
                    ddlUsuarios.DataBind();
                }                
            }
        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }        
    }

    private void Limpiar()
    {
        ddlCategoria.Enabled = true;
        ddlUsuarios.Enabled = true;
        lbDestinatarios.Items.Clear();
        txtAsunto.Text = "";
        txtMensaje.Text = "";
        Session["Destinatarios"] = null;
    }


    protected void btnEnviar_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlCategoria.SelectedIndex == -1)
            {
                lblError.ForeColor = Color.Red;
                lblError.Text = "Debe seleccionar una categoría.";
                return;
            }

            List<EC.Categorias> categorias = (List<EC.Categorias>)Session["MisCategorias"];

            EC.Categorias catSeleccionada = categorias[ddlCategoria.SelectedIndex];

            List<EC.Usuarios> usuDest = (List<EC.Usuarios>)Session["Destinatarios"];

            if (usuDest.Count == 0)
            {
                lblError.ForeColor = Color.Red;
                lblError.Text = "Debe seleccionar al menos un destinatario.";
                return;
            }

            string asunto = txtAsunto.Text.Trim();
            string mensaje = txtMensaje.Text.Trim();
            DateTime fechaHora = DateTime.Now;

            EC.Comunes unComun = new EC.Comunes(0, asunto,
                mensaje,
                fechaHora,
                usuLogueado,
                usuDest,
                catSeleccionada);

            Logica.FabricaLogica.GetLMensajes().Alta(unComun);

            lblError.ForeColor = Color.Green;
            lblError.Text = "Mensaje enviado.";

            Limpiar();
        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }
    }
    protected void btnIngresar_Click(object sender, EventArgs e)
    {
        try
        {
            List<EC.Usuarios> todosUsuarios = (List<EC.Usuarios>)Session["MisUsuarios"];
            if (todosUsuarios == null)
            {
                lblError2.ForeColor = Color.Red;
                lblError2.Text = "No hay usuarios cargados.";
                return;
            }

            List<EC.Usuarios> destinatarios = (List<EC.Usuarios>)Session["Destinatarios"];
            Session["Destinatarios"] = destinatarios;

            EC.Usuarios usuarioSeleccionado = todosUsuarios
                .FirstOrDefault(u => u.NombreUsu == ddlUsuarios.SelectedValue);

            if (usuarioSeleccionado == null)
            {
                lblError2.ForeColor = Color.Red;
                lblError2.Text = "Usuario inválido.";
                return;
            }

            var repetidos = from u in destinatarios
                            where u.NombreUsu == usuarioSeleccionado.NombreUsu
                            select u;

            if (repetidos.Count() > 0)
            {
                lblError2.ForeColor = Color.Red;
                lblError2.Text = "No se puede ingresar el mismo usuario.";
                return;
            }

            destinatarios.Add(usuarioSeleccionado);

            lbDestinatarios.Items.Clear();
            lbDestinatarios.DataSource = destinatarios;
            lbDestinatarios.DataTextField = "NombreUsu";
            lbDestinatarios.DataBind();

            lblError2.Text = "";
        }
        catch (Exception ex)
        {
            lblError2.ForeColor = Color.Red;
            lblError2.Text = ex.Message;
        }
    }
    protected void btnBorrar_Click(object sender, EventArgs e)
    {
        try
        {
            if (lbDestinatarios.SelectedIndex >= 0)
            {
                List<EC.Usuarios> destinatarios = (List<EC.Usuarios>)Session["Destinatarios"];

                destinatarios.RemoveAt(lbDestinatarios.SelectedIndex);

                lbDestinatarios.Items.Clear();
                lbDestinatarios.DataSource = destinatarios;
                lbDestinatarios.DataTextField = "NombreUsu";
                lbDestinatarios.DataBind();

                lblError2.Text = "";


            }
            else
            {
                lblError2.ForeColor = Color.Red;
                lblError2.Text = "Debe seleccionar un Usuario de la lista para eliminar.";
            }
        }
        catch (Exception ex)
        {
            lblError2.ForeColor = Color.Red;
            lblError2.Text = ex.Message;
        }
    }
    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        lblError.Text = "";
        lblError2.Text = "";
        Limpiar();
    }
}