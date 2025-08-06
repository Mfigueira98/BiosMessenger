<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ModificarContraseña.aspx.cs" Inherits="ModificarContraseña" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .auto-style7 {
        width: 100%;
        height: 190px;
    }
    .auto-style8 {
        width: 354px;
    }
    .auto-style9 {
        height: 43px;
    }
    .auto-style10 {
        text-align: center;
        width: 440px;
    }
    .auto-style11 {
        width: 440px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="auto-style7">
    <tr>
        <td class="auto-style9" colspan="3"></td>
    </tr>
    <tr>
        <td class="auto-style8">Ingrese contraseña actual:</td>
        <td class="auto-style11">
            <asp:TextBox ID="txtPassActual" runat="server" TextMode="Password" Width="424px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style8">Ingrese nueva contraseña:</td>
        <td class="auto-style11">
            <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" Width="424px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style8">Confirme nueva contraseña:</td>
        <td class="auto-style11">
            <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" Width="424px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style8">&nbsp;</td>
        <td class="auto-style10">
            <asp:Button ID="btnModificar" runat="server" Text="Modificar contraseña" OnClick="btnModificar_Click" />
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style8">&nbsp;</td>
        <td class="auto-style10">
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
        </td>
        <td>&nbsp;</td>
    </tr>
</table>
</asp:Content>

