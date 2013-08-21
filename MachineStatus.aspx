<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MachineStatus.aspx.cs" Inherits="_Default" %>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ETC - Job Tracker</title>
<link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .auto-style1
        {
            height: 26px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
<div class="container">
  <div class="header" ><a href="Default.aspx"><img src="etc_logo.png" alt="ETC Job Date Tracker" name="Insert_logo" width="144" height="122" id="Insert_logo" style="background: #D24B09; display:block; padding-top:15px; padding-left:15px; background-image:url(site_bg.png) " /></a> 
    <!-- end .header --></div> 
    
    <div id ="Menu" class="MenuDiv">
    <ul class="MenuItem">
    <li><a href="Default.aspx">Home</a></li>
    </ul>
    
    <ul class="MenuItem">
    <li><a href="JDT.aspx">JDT</a></li>
    </ul>
    
    <ul class="MenuItem">
    <li><a href="JobBoard.aspx">Job Board</a></li>
    </ul>
    
    <ul class="MenuItem">
    <li><a href="MachineStatus.aspx">Machine Status</a></li>
    </ul>


<!-- End .MenuDiv -->    </div>
    
  <div class="content">
    <h1>Machine Status</h1>
    <table>
        <tr>
            <td class="auto-style1" align="center">
                <asp:Label ID="Label1" runat="server" Text="72-2" CssClass="MachineStatusText"></asp:Label>
            </td>

            <td class="auto-style1" align="center"> 72-3</td>
            <td class="auto-style1" align="center"> 72-4</td>
            <td class="auto-style1" align="center"> 72-5</td>
            <td class="auto-style1" align="center"> 72-6</td>
        </tr>
        <tr>
            <td align="center">
                <asp:Image ID="Machine_Image" ImageUrl="~/frame.png" BackColor="Red" runat="server" />
            </td>
            <td align="center">
                <asp:Image ID="Image1" ImageUrl="~/frame.png" BackColor="Green" runat="server" />
            </td>
            <td align="center">
                <asp:Image ID="Image2" ImageUrl="~/frame.png" BackColor="Yellow" runat="server" />
            </td>
            <td align="center">
                <asp:Image ID="Image3" ImageUrl="~/frame.png" BackColor="Blue" runat="server" />
            </td>
            <td align="center">
                <asp:Image ID="Image4" ImageUrl="~/frame.png" BackColor="Black" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="center">751759</td>
            <td align="center">751760</td>
            <td align="center">751859</td>
            <td align="center">751799</td>
            <td align="center">751729</td>
        </tr>

    </table>
    <!-- end .content --></div>
  <div class="footer">
    <p><i>ETC JDT Demo Rev. A</i> - James L. Armes</p>
      <p>Retrieved at <%: DateTime.Now %></p>
    <!-- end .footer --></div>
  <!-- end .container --></div>
    </form>
</body>