<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ETC - Job Tracker</title>
<link href="StyleSheet.css" rel="stylesheet" type="text/css" />
</head>

<body>
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
    <h1>Home</h1>
    <p>Welcome <%: UserName %> to the new face of the job tracker for Empirical Testing Corp.  Select a menu option from above to begin.</p>
    <!-- end .content --></div>
  <div class="footer">
    <p><i>ETC JDT Demo Rev. A</i> - James L. Armes</p>
      <p>Retrieved at <%: DateTime.Now %></p>
    <!-- end .footer --></div>
  <!-- end .container --></div>
</body>