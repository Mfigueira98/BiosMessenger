<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BajaUsuario.aspx.cs" Inherits="BajaUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .auto-style6 {
        width: 100%;
        height: 196px;
    }
    .auto-style7 {
        width: 100%;
        height: 256px;
    }
    .auto-style8 {
        width: 658px;
    }
    .auto-style9 {
        width: 658px;
        text-align: center;
    }
        .auto-style10 {
            width: 658px;
            text-align: center;
            font-size: xx-large;
            color: #0000CC;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="auto-style7">
    <tr>
        <td>&nbsp;</td>
        <td class="auto-style8">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td class="auto-style10">Eliminar Usuario</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td class="auto-style9">
            <asp:Button ID="btnBaja" runat="server" Text="Confirmar baja de usuario" OnClick="btnBaja_Click" BackColor="#DDEAF9" />
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td class="auto-style9">
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td class="auto-style8">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td colspan="3">&nbsp;</td>
    </tr>
</table>
</asp:Content>

