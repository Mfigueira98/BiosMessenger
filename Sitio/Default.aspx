<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

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
            width: 40%;
            height: 217px;

        }
        .auto-style2 {
            width: 111px;
        }
        .auto-style4 {
            text-align: left;
        }
        .auto-style5 {
            text-align: center;
        }
        .auto-style9 {
            width: 70%;
            height: 159px;
        }
        .auto-style10 {
            margin-left: 40px;
        }
        .auto-style11 {
            width: 257px;
        }
        .auto-style12 {
            width: 111px;
            height: 35px;
        }
        .auto-style13 {
            height: 35px;
        }
        .auto-style14 {
            height: 31px;
        }
    </style>
</head>
<body style="height: 779px" class="color-body">
    <form id="form1" runat="server">
        <table class="auto-style1" align="center">
            <tbody class="auto-style4">
                <tr>
                    <td colspan="2">Ingreso del Usuario</td>
                </tr>
                <tr>
                    <td class="auto-style2">Usuario:</td>
                    <td>
                        <asp:TextBox ID="TxtUsuario" runat="server" Width="465px" BackColor="#DDEAF9"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style12">Contraseña:</td>
                    <td class="auto-style13">
                        <asp:TextBox ID="TxtPass" runat="server" TextMode="Password" Width="463px" BackColor="#DDEAF9"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5" colspan="2">
                        <asp:Button ID="BtnIngresar" runat="server" Text="Ingresar" Width="85px" OnClick="BtnIngresar_Click" BackColor="#DDEAF9" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="auto-style5">
                        <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">Si desea registrarse, click aquí
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/AltaUsuario.aspx">Registrarse</asp:HyperLink>
                    </td>
                </tr>
            </tbody>
        </table>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            <table align="center" class="auto-style9">
                <tr>
                    <td colspan="2" class="auto-style14">Usuarios activos:
                        <asp:Label ID="lblUsuActivos" runat="server" ForeColor="Blue"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style10" colspan="2">Mensajes comunes enviados:
                        <asp:Label ID="lblMsjesComunes" runat="server" ForeColor="Blue"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">Mensajes privados enviados:
                        <asp:Label ID="lblMsjesPrivados" runat="server" ForeColor="Blue"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">Mensajes recordatorios enviados:
                        <asp:Label ID="lblMsjesRecordatorios" runat="server" ForeColor="Blue"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style11">Mensajes por categoria de mail:&nbsp;
                        </td>
                    <td>
                        <asp:Label ID="lblMsjesCategorias" runat="server" ForeColor="#0000CC"></asp:Label>
                    </td>
                </tr>
            </table>
        </p>
    </form>
</body>
</html>
