<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AltaMensajePrivado.aspx.cs" Inherits="AltaMensajePrivado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style6 {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr>
            <td class="auto-style7">Destinatario/os:</td>
            <td class="auto-style9">
                <asp:DropDownList ID="ddlUsuarios" runat="server" Width="136px" BackColor="#DDEAF9">
                </asp:DropDownList>
            </td>
            <td class="auto-style8">
                <br />
                <asp:ListBox ID="lbDestinatarios" runat="server" Width="156px" BackColor="#DDEAF9"></asp:ListBox>
                <br />
                <asp:Label ID="lblError2" runat="server"></asp:Label>
            </td>
            <td class="auto-style6">
                <asp:Button ID="btnIngresar" runat="server" onclick="btnIngresar_Click" Text="Ingresar Destinatario" BackColor="#DDEAF9" />
                <br />
                <asp:Button ID="btnBorrar" runat="server" onclick="btnBorrar_Click" Text="Borrar Destinatario" BackColor="#DDEAF9" />
            </td>
        </tr>
        <tr>
            <td class="auto-style7">Fecha Caducidad:</td>
            <td class="auto-style8" colspan="2">
                <asp:TextBox ID="txtFechaCad" runat="server" Width="536px" TextMode="Date" BackColor="#DDEAF9"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7">Asunto:</td>
            <td class="auto-style8" colspan="2">
                <asp:TextBox ID="txtAsunto" runat="server" Width="536px" BackColor="#DDEAF9"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7">Mensaje:</td>
            <td class="auto-style8" colspan="2">
                <asp:TextBox ID="txtMensaje" runat="server" Height="400px" Width="536px" BackColor="#DDEAF9"></asp:TextBox>
            </td>
            <td class="auto-style6">
                <asp:Button ID="btnEnviar" runat="server" onclick="btnEnviar_Click" Text="Enviar" BackColor="#DDEAF9" />
            </td>
        </tr>
        <tr>
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style6" colspan="2">
                <asp:Button ID="btnCancelar" runat="server" onclick="btnCancelar_Click" Text="Cancelar" BackColor="#DDEAF9" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style6" colspan="2">
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style8" colspan="2">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>

