<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JobBoard.aspx.cs" Inherits="_Default" %>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ETC - Job Tracker</title>
<link href="StyleSheet.css" rel="stylesheet" type="text/css" />
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
    
      <asp:SqlDataSource ID="JDT" runat="server" ConnectionString="<%$ ConnectionStrings:jdtConnectionString %>" ProviderName="<%$ ConnectionStrings:jdtConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT testengineer.Name, job.idJob, job.ReportWritten, job.ReportInitialCheck, job.ReportFinalCheck, job.Revision, job.Comments FROM testengineer INNER JOIN job ON testengineer.idTestEngineer = job.TestEngineer_idTestEngineer WHERE job.Status='Done' ORDER BY testengineer.Name, job.idJob DESC"></asp:SqlDataSource>
      <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="idJob,Revision" DataSourceID="JDT" ForeColor="#333333" GridLines="None" Width="100%" OnRowDataBound="GridView1_RowDataBound" OnDataBound="GridView1_DataBound" >
          <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
          <Columns>
              <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
              <asp:BoundField DataField="idJob" HeaderText="Job #" InsertVisible="False" ReadOnly="True" SortExpression="idJob" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small"/>
              <asp:BoundField DataField="Revision" HeaderText="Revision" SortExpression="Revision" ItemStyle-HorizontalAlign="Center" ReadOnly="True" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small"/>
              <asp:BoundField DataField="ReportWritten" HeaderText="Report Written" SortExpression="ReportWritten" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yy}" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small"/>
              <asp:BoundField DataField="ReportInitialCheck" HeaderText="Report Initial Check" SortExpression="ReportInitialCheck" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yy}" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small"/>
              <asp:BoundField DataField="ReportFinalCheck" HeaderText="Report Final Check" SortExpression="ReportFinalCheck" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yy}" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small"/>
              <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" ItemStyle-Font-Size="Medium"/>
          </Columns>
          <EditRowStyle BackColor="#999999" />
          <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
          <HeaderStyle BackColor="#006b6e" Font-Bold="True" ForeColor="White" />
          <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
          <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
          <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
          <SortedAscendingCellStyle BackColor="#E9E7E2" />
          <SortedAscendingHeaderStyle BackColor="#506C8C" />
          <SortedDescendingCellStyle BackColor="#FFFDF8" />
          <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
      </asp:GridView>
    </div>
  <div class="footer">
    <p><i>ETC JDT Demo Rev. A</i> - James L. Armes</p>
      <p>Retrieved at <%: DateTime.Now %></p>
    <!-- end .footer --></div>
  <!-- end .container --></div>
    </form>
</body>