<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BandejaDeSalida.aspx.cs" Inherits="BandejaDeSalida" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .color-table {
            background-color: #DDEAF9;
        }
        .auto-style6 {
            width: 161px;
        }
        .auto-style11 {
            width: 885px;
        }
        .auto-style12 {
            text-align: left;
            width: 240px;
        }
        .auto-style13 {
            text-align: center;
            width: 65px;
        }
        .auto-style14 {
            width: 65px;
        }
        .auto-style15 {
            width: 885px;
            text-align: center;
        }
        .auto-style17 {
            width: 33px;
            text-align: left;
        }
        .auto-style18 {
            text-align: left;
        }
        .auto-style19 {
            width: 139px;
            text-align: center;
            height: 31px;
        }
        .auto-style20 {
            width: 33px;
            text-align: left;
            height: 31px;
        }
        .auto-style21 {
            width: 240px;
        }
        .auto-style22 {
            text-align: center;
            width: 139px;
        }
        .auto-style23 {
            width: 142px;
        }
        .auto-style24 {
            width: 142px;
            height: 26px;
        }
        .auto-style25 {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr>
            <td class="auto-style13" rowspan="2">
                <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar" OnClick="btnFiltrar_Click" BackColor="#DDEAF9" />
                <br />
            </td>
            <td class="auto-style19">Tipo de mensaje:<br />
                </td>
            <td class="auto-style20">
                <div>
                    <asp:ListBox ID="lbTipoMensajes" runat="server" BackColor="#DDEAF9"></asp:ListBox>
                </div>
                <div class="auto-style18">
                </div>
                <br />
            </td>
            <td class="auto-style12" rowspan="2">
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar Filtros" OnClick="btnLimpiar_Click" BackColor="#DDEAF9" />
            </td>
        </tr>
        <tr>
            <td class="auto-style22">Destinatarios:</td>
            <td class="auto-style17">
                <asp:DropDownList ID="ddlDestinatarios" runat="server" AutoPostBack="True" Width="300px" BackColor="#DDEAF9">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style13">Fecha:</td>
            <td class="auto-style11" colspan="2">
                <asp:TextBox ID="txtFecha" runat="server" Height="22px" TextMode="Date" Width="226px" BackColor="#DDEAF9"></asp:TextBox>
            </td>
            <td class="auto-style21">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style14">&nbsp;</td>
            <td class="auto-style11" colspan="2">
                <asp:GridView ID="gvMensajes" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="#DDEAF9" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Height="170px" PageSize="6" Width="877px" OnPageIndexChanging="gvMensajes_PageIndexChanging" OnSelectedIndexChanged="gvMensajes_SelectedIndexChanged" DataKeyNames="IdMensaje">
                    <Columns>
                        <asp:BoundField DataField="FechaHoraEnvio" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                        <asp:BoundField DataField="Asunto" HeaderText="Asunto" />
                        <asp:CommandField ShowSelectButton="True" ButtonType="Image" SelectImageUrl="~/Imagenes/Selección.png" >
                        <ControlStyle Height="30px" Width="30px" />
                        </asp:CommandField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#DDEAF9" ForeColor="#000066" HorizontalAlign="Left" />
                    <RowStyle ForeColor="#000066" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                </asp:GridView>

            </td>
            <td class="auto-style21">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style14">&nbsp;</td>
            <td class="auto-style15" colspan="2">
                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
            </td>
            <td class="auto-style21">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style14">&nbsp;</td>
            <td class="auto-style15" colspan="2">

                <asp:Panel ID="pnlDetalleMensaje" runat="server" Visible="false" Style="margin-top:20px; border:1px solid #ccc; padding:10px;">
   <table border="1" style="width: 100%; border-collapse: collapse;" class="color-table">
  <tr>
    <th class="auto-style23">Asunto</th>
    <td><asp:Label ID="lblAsunto" runat="server" /></td>
  </tr>
  <tr>
    <th class="auto-style23">Tipo de Mensaje</th>
    <td><asp:Label ID="lblTipoMensaje" runat="server" /></td>
  </tr>
  <tr>
    <th class="auto-style24">Texto</th>
    <td class="auto-style25"><asp:Label ID="lblTexto" runat="server" /></td>
  </tr>
  <tr>
    <th class="auto-style23">Datos mensaje</th>
    <td><asp:Label ID="lblDatosMensaje" runat="server" /></td>
  </tr>
  <tr>
    <th class="auto-style23">Destinatarios</th>
    <td>
      <asp:GridView ID="gvDestinatarios" runat="server" AutoGenerateColumns="False">
        <Columns>
          <asp:BoundField DataField="NombreUsu" HeaderText="Nombre" />
        </Columns>
      </asp:GridView>
    </td>
  </tr>
       <tr>
           <th class="auto-style23">&nbsp;</th>
           <td>
               <asp:Label ID="lblFechaEnvio" runat="server" />
           </td>
       </tr>
</table>
</asp:Panel>
            </td>
            <td class="auto-style21">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style14">&nbsp;</td>
            <td class="auto-style15" colspan="2">
                &nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style14">&nbsp;</td>
            <td class="auto-style15" colspan="2">
                &nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style14">&nbsp;</td>
            <td class="auto-style15" colspan="2">
                &nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style14">&nbsp;</td>
            <td class="auto-style15" colspan="2">
                &nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
        </tr>
    </table>
</asp:Content>

