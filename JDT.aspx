<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JDT.aspx.cs" Inherits="_Default" %>

<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ETC - Job Tracker</title>
<link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .auto-style1
        {
            height: 28px;
        }
        .auto-style2
        {
            width: 150px;
        }
        .auto-style3
        {
            height: 26px;
        }
        .auto-style4
        {
            height: 28px;
            width: 150px;
        }
        .auto-style5
        {
            height: 26px;
            width: 150px;
        }
    </style>
    </head>

<body>
    <form id="form1" runat="server">

<div class="container">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
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
    <h1>Job Tracker:</h1>
    
    <h3><asp:SqlDataSource ID="JDTDatabase" runat="server" ConnectionString="<%$ ConnectionStrings:jdtConnectionString %>" ProviderName="<%$ ConnectionStrings:jdtConnectionString.ProviderName %>" SelectCommand="SELECT idJob, Status, StaticTesting, ReportOrMemo, DynamicTesting, Comments FROM job">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SQLListBox" runat="server" ConnectionString="<%$ ConnectionStrings:jdtConnectionString %>" ProviderName="<%$ ConnectionStrings:jdtConnectionString.ProviderName %>" SelectCommand="SELECT idJob FROM job"></asp:SqlDataSource>
        <asp:SqlDataSource ID="PM_Data" runat="server" ConnectionString="<%$ ConnectionStrings:jdtConnectionString %>" ProviderName="<%$ ConnectionStrings:jdtConnectionString.ProviderName %>" SelectCommand="SELECT Name FROM pm"></asp:SqlDataSource>
        <asp:SqlDataSource ID="TestEngineer_Data" runat="server" ConnectionString="<%$ ConnectionStrings:jdtConnectionString %>" ProviderName="<%$ ConnectionStrings:jdtConnectionString.ProviderName %>" SelectCommand="SELECT Name FROM testengineer"></asp:SqlDataSource>
        <asp:TextBox ID="TextBox_Error_Messages" runat="server" Visible="False" BorderStyle="None" CssClass="errorText" Width="100%" ReadOnly="True"></asp:TextBox>
      </h3>
      <asp:Button ID="Button_Test" runat="server" OnClick="Button_Test_Click" Text="Test" />
      <asp:Button ID="ViewTest" runat="server" Text="Equipment" OnClick="ViewTest_Click" />
      <asp:MultiView runat="server" ActiveViewIndex="0" ID="MultiView1">
          <asp:View runat="server">
      <table> <!-- Start of the main JDT View -->
          <tr>
              <td>
                    Select Job:&nbsp;</td>
              <td>

                  <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged1" AutoPostBack="true" CssClass="TextBoxControl">
          <asp:ListItem Selected="True" >No Job Selected</asp:ListItem> 
          </asp:DropDownList>

              </td>
              <td valign="middle"> Rev:  <asp:DropDownList ID="DropDown_Revision" runat="server" CssClass="TextBoxControl" Width="47px" AutoPostBack="True" OnSelectedIndexChanged="DropDown_Revision_SelectedIndexChanged">
                  <asp:ListItem>A</asp:ListItem>
                  <asp:ListItem>B</asp:ListItem>
                  <asp:ListItem>C</asp:ListItem>
                  <asp:ListItem>D</asp:ListItem>
                  <asp:ListItem>E</asp:ListItem>
                  <asp:ListItem>F</asp:ListItem>
                  <asp:ListItem>G</asp:ListItem>
                  <asp:ListItem>H</asp:ListItem>
                  <asp:ListItem>I</asp:ListItem>
                  <asp:ListItem>J</asp:ListItem>
                  <asp:ListItem>K</asp:ListItem>
                  </asp:DropDownList></td>
              <td>
                  &nbsp;</td>
          </tr>
      </table>
      <table>
              <tr> <!-- First row of Data -->
                  <td>Status:</td>
                  <td>
                      <asp:DropDownList ID="DropDownList_Status" runat="server" CssClass="TextBoxControl">
                          <asp:ListItem Selected="True"> </asp:ListItem>
                          <asp:ListItem>Cancelled</asp:ListItem>
                          <asp:ListItem>Closed</asp:ListItem>
                          <asp:ListItem>Done</asp:ListItem>
                          <asp:ListItem>Hold</asp:ListItem>
                          <asp:ListItem>MFG</asp:ListItem>
                          <asp:ListItem>Pre-Test</asp:ListItem>
                          <asp:ListItem>Quarantine</asp:ListItem>
                          <asp:ListItem>Receive</asp:ListItem>
                          <asp:ListItem>Running</asp:ListItem>
                          <asp:ListItem>Science Fair</asp:ListItem>
                          <asp:ListItem>Wait Queue</asp:ListItem>
                      </asp:DropDownList>
                  </td>
                  <td>&nbsp;</td>
                  <td class="auto-style2">Customer Contact:  </td>
                  <td class="auto-style2">
                      <asp:DropDownList ID="DropDownList_Customer_Contact" runat="server" DataSourceID="Customers" DataTextField="Customer Contact" DataValueField="Customer Contact">
                      </asp:DropDownList>
                      <asp:SqlDataSource ID="Customers" runat="server" ConnectionString="<%$ ConnectionStrings:jdtConnectionString %>" ProviderName="<%$ ConnectionStrings:jdtConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [customer]"></asp:SqlDataSource>
                  </td>
                  
              </tr>
              <tr> <!-- Second row of Dta -->
                  <ajaxToolkit:CalendarExtender ID="Calendar_DeliveryDate" runat="server" TargetControlID="TextBox_DeliveryDate" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                  
                  <td class="auto-style1">Delivery Dates:</td>
                  <td>
                      <asp:TextBox ID="TextBox_DeliveryDate" runat="server" AutoPostBack="True"></asp:TextBox></td>
                  <td class="auto-style1"></td>
                  <td class="auto-style2">Customer Name:  </td>
                  <td class="auto-style2">
                      <asp:DropDownList ID="DropDownList_Customer_Name" runat="server" DataSourceID="Customers" DataTextField="Company Name" DataValueField="Company Name">
                      </asp:DropDownList>
                  </td>
              </tr>
              <tr>
                  <td>Report or Memo </td>
                  <td class="auto-style1">
                      <asp:DropDownList ID="DropDownList_ReportOrMemo" runat="server" Height="24px" Width="120px" CssClass="TextBoxControl">
                          <asp:ListItem Selected="True">N/A</asp:ListItem>
                          <asp:ListItem>Report</asp:ListItem>
                          <asp:ListItem>Memo</asp:ListItem>
                      </asp:DropDownList>
                  </td>
                  
                  <td>&nbsp;</td>
                  <td class="auto-style2">System Name</td>
                  <td class="auto-style2">
                      <asp:TextBox ID="TextBox_System_Name" runat="server"></asp:TextBox>
                  </td>
              </tr>
          <tr>
              <td>Static Testing:  </td>
              <td><asp:CheckBox ID="CheckBox_Static_Testing" runat="server" /></td>
              <td></td>
              <td class="auto-style2">Device Type:  </td>
              <td class="auto-style2">
                  <asp:DropDownList ID="DropDown_DeviceType" runat="server" Height="24px" Width="120px" CssClass="TextBoxControl">
                      <asp:ListItem Selected="True"> </asp:ListItem>
                      <asp:ListItem>ACP System</asp:ListItem>
                      <asp:ListItem>ALP System</asp:ListItem>
                      <asp:ListItem>Ankle Implant</asp:ListItem>
                      <asp:ListItem>Bone Screw</asp:ListItem>
                      <asp:ListItem>Clavicle</asp:ListItem>
                      <asp:ListItem>Coating</asp:ListItem>
                      <asp:ListItem>Connector</asp:ListItem>
                      <asp:ListItem>Dental Implant</asp:ListItem>
                      <asp:ListItem>Drill</asp:ListItem>
                      <asp:ListItem>Elbow Implant</asp:ListItem>
                      <asp:ListItem>ESFD</asp:ListItem>
                      <asp:ListItem>Foot Implant</asp:ListItem>
                      <asp:ListItem>Hip Implant</asp:ListItem>
                      <asp:ListItem>Hook</asp:ListItem>
                      <asp:ListItem>IBFD Cervical</asp:ListItem>
                      <asp:ListItem>IBFD Lumbar</asp:ListItem>
                      <asp:ListItem>IM Device</asp:ListItem>
                      <asp:ListItem>Instruments</asp:ListItem>
                      <asp:ListItem>ISP Lumbar</asp:ListItem>
                      <asp:ListItem>ISS Lumbar</asp:ListItem>
                      <asp:ListItem>Knee Implant</asp:ListItem>
                      <asp:ListItem>Lumbar SA</asp:ListItem>
                      <asp:ListItem>OCT System</asp:ListItem>
                      <asp:ListItem>PDS System</asp:ListItem>
                      <asp:ListItem>Plate - Bone</asp:ListItem>
                      <asp:ListItem>Plate - Laminoplasty</asp:ListItem>
                      <asp:ListItem>PLIF</asp:ListItem>
                      <asp:ListItem>Protocol Only</asp:ListItem>
                      <asp:ListItem>Prototyping</asp:ListItem>
                      <asp:ListItem>PSS Cervical</asp:ListItem>
                      <asp:ListItem>PSS Component</asp:ListItem>
                      <asp:ListItem>PSS Lumbar</asp:ListItem>
                      <asp:ListItem>Regulatory</asp:ListItem>
                      <asp:ListItem>Rods</asp:ListItem>
                      <asp:ListItem>RSP</asp:ListItem>
                      <asp:ListItem>SA Cervicle</asp:ListItem>
                      <asp:ListItem>SA Lumbar</asp:ListItem>
                      <asp:ListItem>Screw - Facet</asp:ListItem>
                      <asp:ListItem>Screw - Non-Facet</asp:ListItem>
                      <asp:ListItem>Shoulder Implant</asp:ListItem>
                      <asp:ListItem>Staple</asp:ListItem>
                      <asp:ListItem>Sterilization</asp:ListItem>
                      <asp:ListItem>TDR Cervical</asp:ListItem>
                      <asp:ListItem>TDR Lumbar</asp:ListItem>
                      <asp:ListItem>Test Blocks Only</asp:ListItem>
                      <asp:ListItem>Thumb Implant</asp:ListItem>
                      <asp:ListItem>Tibial Tray</asp:ListItem>
                      <asp:ListItem>Toe</asp:ListItem>
                      <asp:ListItem>VBR</asp:ListItem>
                      <asp:ListItem>Wrist Implant</asp:ListItem>
                  </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td>Dynamic Testing:</td>
              <td><asp:CheckBox ID="CheckBox_Dynamic_Testing" runat="server" /></td>
              <td></td>
              <td class="auto-style4">PM:</td>
                  <td class="auto-style4">
                      <asp:DropDownList ID="DropDown_PM" runat="server" DataSourceID="PM_Data" DataTextField="Name" DataValueField="Name" CssClass="TextBoxControl">
                      </asp:DropDownList>
                  </td>
          </tr>
          <tr>
              <td>PO Date:</td>
              <td>
                      <asp:TextBox ID="TextBox_PODate" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="Calendar_PODate" runat="server" TargetControlID="TextBox_PODate" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                  </td>
              <td></td>
              <td class="auto-style2">Test Engineer:</td>
                  <td class="auto-style2">
                      <asp:DropDownList ID="DropDown_TestEngineer" runat="server" DataSourceID="TestEngineer_Data" DataTextField="Name" DataValueField="Name" CssClass="TextBoxControl">
                      </asp:DropDownList>
                  </td>
          </tr>

          <tr>
              <td>Folder Build:</td>
              <td>
                      <asp:TextBox ID="TextBox_FBuild" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="Calendar_FBuild" runat="server" TargetControlID="TextBox_FBuild" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                  </td>
              <td></td>
              <td class="auto-style2">Report Written</td>
              <td class="auto-style2">
                      <asp:TextBox ID="TextBox_ReportWritten" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="Calendar_Report_Written" runat="server" TargetControlID="TextBox_ReportWritten" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                  </td>
          </tr>

          <tr>
              <td>Folder Check:</td>
              <td>
                      <asp:TextBox ID="TextBox_FCheck" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="Calendar_FCheck" runat="server" TargetControlID="TextBox_FCheck" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                  </td>
              <td></td>
              <td class="auto-style2">Report Initial Check:  </td>
              <td class="auto-style2">
                  <asp:TextBox ID="TextBox_Initial_Report_Check" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="Calendar_Initial_Report_Check" runat="server" TargetControlID="TextBox_Initial_Report_Check" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
              </td>
          </tr>

          <tr>
              <td class="auto-style3">Target Start:</td>
              <td class="auto-style3">
                      <asp:TextBox ID="TextBox_Target_Start" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="Calendar_Target_Start" runat="server" TargetControlID="TextBox_Target_Start" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                  </td>
              <td class="auto-style3"></td>
              <td class="auto-style5">Report Final Check:  </td>
              <td class="auto-style5">
                  <asp:TextBox ID="TextBox_Final_Report_Check" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="Calendar_Final_Report_Check" runat="server" TargetControlID="TextBox_Final_Report_Check" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
              </td>
          </tr>

          <tr>
              <td class="auto-style3">Test Start:</td>
              <td class="auto-style3">
                      <asp:TextBox ID="TextBox_Test_Start" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="Calendar_Test_Start" runat="server" TargetControlID="TextBox_Test_Start" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                  </td>
              <td class="auto-style3"></td>
              <td class="auto-style5">Invoiced Date:  </td>
              <td class="auto-style5">
                      <asp:TextBox ID="TextBox_InvoiceDate" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="Calendar_Invoice_Date" runat="server" TargetControlID="TextBox_InvoiceDate" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                  </td>
          </tr>

          <tr>
              <td>Test End:</td>
              <td>
                      <asp:TextBox ID="TextBox_Test_End" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="Calendar_Test_End" runat="server" TargetControlID="TextBox_Test_End" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                  </td>
              <td></td>
              <td class="auto-style2">Comments:  </td>
              <td class="auto-style2">
                  <asp:TextBox ID="TextBox_Comments" runat="server" Height="36px" MaxLength="254" Rows="2" TextMode="MultiLine" Width="255px"></asp:TextBox>
              </td>
          </tr>

          </table>

         
              </asp:View> <!-- End of JDT Main View -->
          <asp:View runat="server"> <!-- Beginning of Equipment View for current job -->
              &nbsp;<table>
                  <tr>
                      <td>
                          Calipers:
                      </td>
                      <td>
                          <asp:DropDownList ID="DropDownList_Calipers" runat="server" AutoPostBack="True" CssClass="TextBoxControl" OnSelectedIndexChanged="DropDownList_Calipers_SelectedIndexChanged">
                              <asp:ListItem> </asp:ListItem>
                              <asp:ListItem>CP0007</asp:ListItem>
                          </asp:DropDownList>
                      </td>
                      <td>
                          Calipers Date:
                      </td>
                      <td>
                          <asp:TextBox ID="Calipers_Date" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="CalendarExtender_Calipers_Date" runat="server" TargetControlID="Calipers_Date" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                      </td>
                  </tr>

                  <tr>
                      <td>
                          Micrometer:
                      </td>
                      <td>
                          <asp:DropDownList ID="DropDownList_Micrometers" runat="server" AutoPostBack="True" CssClass="TextBoxControl" OnSelectedIndexChanged="DropDownList_Micrometers_SelectedIndexChanged">
                               <asp:ListItem> </asp:ListItem>
                              <asp:ListItem>CP0007</asp:ListItem>
                          </asp:DropDownList>
                      </td>
                      <td>
                          Micrometer Date:
                      </td>
                      <td>
                          <asp:TextBox ID="Micrometer_Date" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="CalendarExtender_MicrometerDate" runat="server" TargetControlID="Micrometer_Date" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                      </td>
                 </tr>
                  <tr>
                      <td>
                          Scale:  
                      </td>
                      <td>
                          <asp:DropDownList ID="DropDownList_Scale" runat="server" AutoPostBack="True" CssClass="TextBoxControl" OnSelectedIndexChanged="DropDownList_Scale_SelectedIndexChanged">
                               <asp:ListItem> </asp:ListItem>
                              <asp:ListItem>CP0007</asp:ListItem>
                          </asp:DropDownList>
                      </td>
                      <td>
                          Scale Date:
                      </td>
                      <td>
                          <asp:TextBox ID="Scale_Date" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="CalendarExtender_Scale_Date" runat="server" TargetControlID="Scale_Date" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                      </td>
                  </tr>
                  <tr>
                      <td>
                          Torque Wrench: 
                      </td>
                      <td>
                          <asp:DropDownList ID="DropDownList_TorqueWrench" runat="server" AutoPostBack="True" CssClass="TextBoxControl" OnSelectedIndexChanged="DropDownList_TorqueWrench_SelectedIndexChanged">
                               <asp:ListItem> </asp:ListItem>
                              <asp:ListItem>CP0007</asp:ListItem>
                          </asp:DropDownList>
                      </td>
                      <td>
                          Torque Wrench Date:
                      </td>
                      <td>
                          <asp:TextBox ID="TW_Date" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="CalendarExtender_TWDate" runat="server" TargetControlID="TW_Date" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                      </td>
                  </tr>
                  <tr>
                      <td>
                          Protractor:
                      </td>
                      <td>
                          <asp:DropDownList ID="DropDownList_Protractor" runat="server" AutoPostBack="True" CssClass="TextBoxControl" OnSelectedIndexChanged="DropDownList_Protractor_SelectedIndexChanged">
                               <asp:ListItem> </asp:ListItem>
                              <asp:ListItem>CP0007</asp:ListItem>
                          </asp:DropDownList>
                      </td>
                      <td>
                          Protractor Date:
                      </td>
                      <td>
                          <asp:TextBox ID="Protractor_Date" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="CalendarExtender_ProtractorDate" runat="server" TargetControlID="Protractor_Date" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                      </td>
                  </tr>
                  <tr>
                      <td>
                          Load Verify (force): 
                      </td>
                      <td>
                          <asp:DropDownList ID="DropDownList_LV_Force" runat="server" AutoPostBack="True" CssClass="TextBoxControl" OnSelectedIndexChanged="DropDownList_LV_Force_SelectedIndexChanged">
                               <asp:ListItem> </asp:ListItem>
                              <asp:ListItem>CP0007</asp:ListItem>
                          </asp:DropDownList>
                      </td>
                      <td>
                          Load Verify Date:
                      </td>
                      <td>
                          <asp:TextBox ID="Load_Verify_Force_Date" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="CalendarExtender_LVForce" runat="server" TargetControlID="Load_Verify_Force_Date" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                      </td>
                  </tr>
                  <tr>
                      <td>
                          Load Verify (torque): 
                      </td>
                      <td>
                          <asp:DropDownList ID="DropDownList_LV_Torque" runat="server" AutoPostBack="True" CssClass="TextBoxControl" OnSelectedIndexChanged="DropDownList_LV_Torque_SelectedIndexChanged">
                               <asp:ListItem> </asp:ListItem>
                              <asp:ListItem>CP0007</asp:ListItem>
                          </asp:DropDownList>
                      </td>
                      <td>
                          Load Verify Date:
                      </td>
                      <td>
                          <asp:TextBox ID="LV_Torque_Date" runat="server" AutoPostBack="True"></asp:TextBox>
                  <ajaxToolkit:CalendarExtender ID="CalendarExtender_LV_Torque" runat="server" TargetControlID="LV_Torque_Date" Format="dd-MMM-yyyy" CssClass="newtheme"></ajaxToolkit:CalendarExtender>
                      </td>
                  </tr>
                    
              </table>
          </asp:View>
      </asp:MultiView>
       <table> <!-- Tables for the buttons -->
          <tr>
              <td class="auto-style2">&nbsp;</td>
              <td>
                  &nbsp;</td>
              <td>&nbsp;</td>
              <td></td>
              <td></td>
          </tr>
              <tr>
                  <td>&nbsp;</td>
                  <td>
                      &nbsp;</td>
              </tr>
              <tr>
                <td class="auto-style2">
                    Specify Job #:&nbsp; </td>
                  <td>

                  <asp:TextBox ID="TextBox_NewJobNumber" runat="server"></asp:TextBox>

                  </td>
                  <td>


                    <asp:Button ID="Button_NewJob" runat="server" Text="New Job" OnClick="Button_NewJob_Click" PostBackUrl="~/JDT.aspx" Width="125px" CssClass="TextBoxControl" />

                  </td>
                  <td>


                      <asp:Button ID="Button_UpdateJob" runat="server" Text="Save Changes" OnClick="Button_UpdateJob_Click" PostBackUrl="~/JDT.aspx" Width="125px" CssClass="TextBoxControl" /> 

                  </td>

                  <td>


                      <asp:Button ID="Button1" runat="server" Text="Add Revision" Width="125px" CssClass="TextBoxControl" OnClick="Button1_Click"/>

                  </td>
                  <td>

                      <asp:Button ID="Button_Delete" runat="server" Text="Delete this Job/Revision" OnClick="Button_Delete_Click" Height="28px" Width="156px" />

                  </td>
              </tr>
           <tr>
               <td>

               </td>
           </tr>
          </table>
    </div>
  <div class="footer">
    <p><i>ETC JDT Demo Rev. A </i> - James L. Armes</p>
      <p>Retrieved at <%: DateTime.Now %></p>
    <!-- end .footer --></div>
  <!-- end .container --></div>
    </form>
</body>
