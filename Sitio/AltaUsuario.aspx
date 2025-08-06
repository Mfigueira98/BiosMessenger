<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AltaUsuario.aspx.cs" Inherits="AltaUsuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .body {
            margin: 0;
            min-height: 100vh;
            width: 100%;
        }
        .auto-style1 {
            width: 367px;
        }
        .auto-style2 {
            text-align: center;
        }
        .auto-style3 {
            width: 367px;
            height: 26px;
        }
        .auto-style4 {
            height: 26px;
        }
        .auto-style5 {
            height: 26px;
            text-align: center;
        }
        .auto-style6 {
            height: 26px;
            text-align: left;
        }
    </style>
</head>
<body style="height: 454px" class="color-body">
    <form id="form1" runat="server">
        <table style="width:100%;">
            <tr>
                <td class="auto-style2" colspan="2">Complete los campos</td>
            </tr>
            <tr>
                <td class="auto-style1">Nombre de usuario:</td>
                <td>
                    <asp:TextBox ID="txtNomUsu" runat="server" Width="586px" BackColor="#DDEAF9" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Contraseña:</td>
                <td>
                    <asp:TextBox ID="txtPass" runat="server" TextMode="Password" Width="586px" BackColor="#DDEAF9" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Nombre completo:</td>
                <td>
                    <asp:TextBox ID="txtNomComp" runat="server" Width="586px" BackColor="#DDEAF9" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Correo electrónico:</td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server" Width="586px" BackColor="#DDEAF9" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">Fecha de nacimiento:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="txtFechaNac" runat="server" TextMode="Date" BackColor="#DDEAF9" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style5" colspan="2">
                    <asp:Button ID="btnRegistro" runat="server" Text="Registrar" OnClick="btnRegistro_Click" BackColor="#DDEAF9" />
                    <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" OnClick="btnLimpiar_Click" BackColor="#DDEAF9" />
                </td>
            </tr>
            <tr>
                <td class="auto-style5">&nbsp;</td>
                <td class="auto-style6">
                    <asp:Label ID="lblError" runat="server" ForeColor="Black"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx">Volver a inicio</asp:HyperLink>
                    </td>
                <td class="auto-style6">&nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>
