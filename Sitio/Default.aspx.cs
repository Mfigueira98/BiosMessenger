using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using EC;
using Logica;

public partial class _Default : System.Web.UI.Page
{
    List<Usuarios> _UsuariosActivos = null;
    List<Mensajes> _Mensajes = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["UsuariosActivos"] = _UsuariosActivos = FabricaLogica.GetLUsuarios().Listo();
            Session["Mensajes"] = _Mensajes = FabricaLogica.GetLMensajes().Listar();

            MostrarEstadisticas();
        }
        else
        {
            _UsuariosActivos = Session["UsuariosActivos"] as List<Usuarios>;
            _Mensajes = Session["Mensajes"] as List<Mensajes>;
        }
    }

    protected void BtnIngresar_Click(object sender, EventArgs e)
    {
        try
        {
            ILogicaUsuarios logicaUsuarios = FabricaLogica.GetLUsuarios();
            Usuarios unUsu = logicaUsuarios.Logueo(TxtUsuario.Text.Trim(), TxtPass.Text.Trim());

            if (unUsu != null)
            {
                Session["UsuarioLogueado"] = unUsu;
                Response.Redirect("PaginaPrincipal.aspx");
            }

            else
            {
                lblError.Text = "Datos incorrectos.";
            }
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message; 
        }
    }
    private void MostrarEstadisticas()
    {
        try
        {
            int cantUsuariosActivos = _UsuariosActivos.Count();
            lblUsuActivos.Text = "" + cantUsuariosActivos;

            int cantComunes = _Mensajes.Count(m => m is Comunes);
            lblMsjesComunes.Text = "" + cantComunes;

            int cantPrivados = _Mensajes.Count(m => m is Privados);
            lblMsjesPrivados.Text = "" + cantPrivados;

            int cantRecordatorios = _Mensajes.Count(m => m is Recordatorios);
            lblMsjesRecordatorios.Text = "" + cantRecordatorios;

            var mailsPorCategoria = (from unM in _Mensajes
                                     where unM is Comunes
                                     group unM by ((Comunes)unM).Categoria.NombreCat 
                                     into grupito
                                     orderby grupito.Count() descending
                                     select new
                                     {
                                         Categoria = grupito.Key,
                                         Cantidad = grupito.Count()
                                     }).ToList();

            string resultado = "";

            foreach (var item in mailsPorCategoria)
            {
                resultado += item.Categoria + ": " + item.Cantidad + "<br/>";
            }

            lblMsjesCategorias.Text = resultado;
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }
}