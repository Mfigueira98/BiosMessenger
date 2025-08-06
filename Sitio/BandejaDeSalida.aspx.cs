using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using EC;
using Logica;

public partial class BandejaDeSalida : System.Web.UI.Page
{
    EC.Usuarios usuLogueado;
    List<Usuarios> _Destinatarios = null;
    List<Mensajes> _Mensajes = null;
    List<Mensajes> _MensajesFiltro = null;

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
                    Session["MisUsuarios"] = _Destinatarios = Logica.FabricaLogica.GetLUsuarios().Listo();
                    ddlDestinatarios.DataSource = Session["MisUsuarios"];
                    ddlDestinatarios.DataTextField = "NombreUsu";
                    ddlDestinatarios.DataValueField = "NombreUsu";
                    ddlDestinatarios.DataBind();
                    ddlDestinatarios.Items.Insert(0, "Seleccione destinatario");

                    _Mensajes = Logica.FabricaLogica.GetLMensajes().ListarMensajesSalida(usuLogueado);
                    Session["Mensajes"] = _Mensajes;
                    gvMensajes.DataSource = _Mensajes;
                    gvMensajes.DataBind();
                    CargoListBox();
                }
            }

            else
            {
                _Destinatarios = Session["MisUsuarios"] as List<Usuarios>;
                _Mensajes = Session["Mensajes"] as List<Mensajes>;
                _MensajesFiltro = Session["MensajesFiltro"] as List<Mensajes>;
            }
        }
        catch (Exception ex)
        {
            lblError.Text = ex.ToString();
        }       
    }

    private void CargoListBox()
    {
        lbTipoMensajes.Items.Add(new ListItem("-- Seleccione un tipo --", ""));
        lbTipoMensajes.Items.Add(new ListItem("Común", "Comunes"));
        lbTipoMensajes.Items.Add(new ListItem("Privado", "Privados"));
        lbTipoMensajes.Items.Add(new ListItem("Recordatorio", "Recordatorios"));

        lbTipoMensajes.SelectedIndex = 0;
    }


    protected void btnLimpiar_Click(object sender, EventArgs e)
    {

        gvMensajes.DataSource = _Mensajes;
        gvMensajes.DataBind();
        

        Session["MensajesFiltro"] = _MensajesFiltro = _MensajesFiltro = null;
        txtFecha.Text = "";
        ddlDestinatarios.SelectedIndex = 0;
        lbTipoMensajes.SelectedIndex = 0;
        lblError.Text = "";
        pnlDetalleMensaje.Visible = false;
    }

    protected void gvMensajes_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMensajes.PageIndex = e.NewPageIndex;

        if (_MensajesFiltro == null)
        {
            gvMensajes.DataSource = _Mensajes;
            gvMensajes.DataBind();
        }
        else
        {
            gvMensajes.DataSource = _MensajesFiltro;
            gvMensajes.DataBind();
        }
    }


    protected void btnFiltrar_Click(object sender, EventArgs e)
    {
        try
        {
            List<Mensajes> _listaFiltro = _Mensajes;

            if (ddlDestinatarios.SelectedIndex > 0)
            {
                Usuarios usuSel = _Destinatarios[ddlDestinatarios.SelectedIndex - 1];

                _listaFiltro = (from unM in _listaFiltro
                                from u in unM.NomUsuReciben
                                where u.NombreUsu == usuSel.NombreUsu
                                select unM).Distinct().ToList();
            }

            if (lbTipoMensajes.SelectedValue != "")
            {
                string tipoMensSel = lbTipoMensajes.SelectedValue;

                if (tipoMensSel == "Comunes")
                    _listaFiltro = (from unM in _listaFiltro
                                    where unM is Comunes
                                    select unM).ToList();

                else if (tipoMensSel == "Privados")
                    _listaFiltro = (from unM in _listaFiltro
                                    where unM is Privados
                                    select unM).ToList();

                else if (tipoMensSel == "Recordatorios")
                    _listaFiltro = (from unM in _listaFiltro
                                    where unM is Recordatorios
                                    select unM).ToList();
            }

            if (txtFecha.Text.Trim().Length > 0)
            {
                DateTime _fecha = Convert.ToDateTime(txtFecha.Text);

                if (_fecha > DateTime.Now.Date)
                    throw new Exception("La fecha tiene que ser menor a hoy");

                _listaFiltro = (from unM in _listaFiltro
                                where unM.FechaHoraEnvio.Date == _fecha.Date
                                select unM).ToList();
            }

            if (_listaFiltro.Count() > 0)
            {
                _MensajesFiltro = _listaFiltro;
                Session["MensajesFiltro"] = _MensajesFiltro;

                gvMensajes.DataSource = _listaFiltro;
                gvMensajes.DataBind();
            }
            else
            {
                lblError.Text = "Los filtros no tienen resultados";
            }
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }

    protected void gvMensajes_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int pos = (gvMensajes.PageIndex * gvMensajes.PageSize) + gvMensajes.SelectedIndex;

            List<Mensajes> listaActual = Session["MensajesFiltro"] as List<Mensajes> ?? Session["Mensajes"] as List<Mensajes>;

            Mensajes mensajeSel = listaActual[pos];

            lblAsunto.Text = mensajeSel.Asunto;
            lblTexto.Text = mensajeSel.Texto;
            lblFechaEnvio.Text = mensajeSel.FechaHoraEnvio.ToString("dd/MM/yyyy HH:mm");

            if (mensajeSel is Comunes)
            {
                lblTipoMensaje.Text = "Común";
                lblDatosMensaje.Text = "Categoría: " + ((Comunes)mensajeSel).Categoria.CodigoCat;
            }
            else if (mensajeSel is Privados)
            {
                lblTipoMensaje.Text = "Privado";
                lblDatosMensaje.Text = "Fecha de caducidad: " + ((Privados)mensajeSel).FechaCad.ToString("dd/MM/yyyy");
            }
            else
            {
                lblTipoMensaje.Text = "Recordatorio";
                lblDatosMensaje.Text = "Tipo de recordatorio: " + ((Recordatorios)mensajeSel).TipoRecordatorio;
            }

            gvDestinatarios.DataSource = mensajeSel.NomUsuReciben;
            gvDestinatarios.DataBind();

            pnlDetalleMensaje.Visible = true;
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }
}
