using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Data;
using System.Web.Configuration;
using System.Data.SqlClient;
using MySql.Data.MySqlClient;
using AjaxControlToolkit;
using System.Runtime.CompilerServices;

public partial class _Default : System.Web.UI.Page
{
    private string connectionString = "server=localhost; uid=root; pwd=beebe123; database=jdt;";
    public bool NewEntrySaved;

   
    protected void Page_PreInit(object sender, EventArgs e)
    {
        
    }

    protected void Refresh_Job_Numbers()
    {
        string selectSQL = "SELECT DISTINCT idJob FROM job";

        MySqlConnection con = new MySqlConnection(connectionString);

        MySqlCommand cmd = new MySqlCommand(selectSQL, con);

        con.Open();

        DropDownList1.DataSource = cmd.ExecuteReader();
        DropDownList1.DataTextField = "idJob";

        this.DataBind();

        con.Close();

        DropDownList1.SelectedIndex = -1;
    }

    protected void Refresh_Revisions()
    {
        string selectSQL = "SELECT Revision FROM job WHERE idJob = " + DropDownList1.SelectedValue;

        MySqlConnection con = new MySqlConnection(connectionString);
        MySqlCommand cmd = new MySqlCommand(selectSQL, con);

        using (con)
        {
            con.Open();
            DropDown_Revision.DataSource = cmd.ExecuteReader();
            DropDown_Revision.DataTextField = "Revision";
            DropDown_Revision.DataBind();
        }

        DropDown_Revision.SelectedIndex = DropDown_Revision.Items.Count - 1;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!this.IsPostBack)
            {
                Refresh_Job_Numbers();
                Refresh_Revisions();
            }
        }
        catch (Exception JDTException_Page_Load)
        {
            Throw_Error_Message(JDTException_Page_Load.Message);
        }

        TextBox_Error_Messages.Visible = false;
        

    }

    protected void RefreshDropDown()
    {
        string selectSQL = "SELECT * FROM job";

        MySqlConnection con = new MySqlConnection(connectionString);

        MySqlCommand cmd = new MySqlCommand(selectSQL, con);

        con.Open();

        DropDownList1.DataSource = cmd.ExecuteReader();
        DropDownList1.DataTextField = "idJob";

        this.DataBind();

        con.Close();

    }

    protected string FormatDate(string date)
    {
        if (date.Length > 1)
        {
            return date;
        }
        else
        {
            return ("0" + date);
        }
    }

 

    protected string Format_Entire_Date(string Date)
    {
        if (Date.Length > 4)
        {
            Debug.WriteLine("Date Passed in:  " + Date);

            DateTime temp_DateTime;

            DateTime.TryParse(Date, out temp_DateTime);

            Debug.WriteLine("Perceived Date:  " + temp_DateTime.Day.ToString() + "-" + temp_DateTime.Month.ToString() + "-" + temp_DateTime.Year.ToString());

            string return_Date = FormatDate(temp_DateTime.Day.ToString()) + "-" + FormatDate(temp_DateTime.Month.ToString()) + "-" + temp_DateTime.Year.ToString();

            Debug.WriteLine("Date Returned:  " + return_Date);

            return return_Date;
        }
        else
        {
            return "";
        }
    }


    protected void DropDownList1_SelectedIndexChanged1(object sender, EventArgs e)
    {
        //
        // Need to individually check parses for data
        //

        Refresh_Revisions();

        // Retrieve information for selected job:
        string selectSQL = "SELECT * FROM `job` WHERE (idJob=@JobID AND Revision=@Rev)";

        MySqlConnection con = new MySqlConnection(connectionString);

        MySqlCommand cmd = new MySqlCommand(selectSQL, con);

        cmd.Parameters.AddWithValue("@JobID", DropDownList1.SelectedValue);
        cmd.Parameters.AddWithValue("@Rev", DropDown_Revision.SelectedValue);

        con.Open();

        MySqlDataReader reader = cmd.ExecuteReader();
        reader.Read();

        int result;
        bool b_result;

        // Partnership Manager
        int.TryParse(reader["PM_idPM"].ToString(), out result);
        DropDown_PM.SelectedIndex = result - 1;

        // Test Engineer
        int.TryParse(reader["TestEngineer_idTestEngineer"].ToString(), out result);
        DropDown_TestEngineer.SelectedIndex = result - 1;

        // Status
        try
        {
            DropDownList_Status.Text = reader["Status"].ToString();
        }
        catch
        {
            Throw_Error_Message("Error displaying Status Text");
        }
        // Delivery Dates
        TextBox_DeliveryDate.Text = Format_Entire_Date(reader["DeliveryDate"].ToString());
        Date_Text_Update(TextBox_DeliveryDate);

        // Report or Memo?
        string ReportOrMemo = reader["ReportOrMemo"].ToString();

        // Static Testing
        bool.TryParse(reader["StaticTesting"].ToString(), out b_result);
        CheckBox_Static_Testing.Checked = b_result;

        // Dynamic Testing
        bool.TryParse(reader["DynamicTesting"].ToString(), out b_result);
        CheckBox_Dynamic_Testing.Checked = b_result;

        // PO Date
        TextBox_PODate.Text = Format_Entire_Date(reader["PODate"].ToString());
        Date_Text_Update(TextBox_PODate);
        // Folder Build Date
        TextBox_FBuild.Text = Format_Entire_Date(reader["FolderBuilt"].ToString());
        Date_Text_Update(TextBox_FBuild);
        // Folder Check Date
        TextBox_FCheck.Text = Format_Entire_Date(reader["FolderCheck"].ToString());
        Date_Text_Update(TextBox_FCheck);
        // Target Start Date
        TextBox_Target_Start.Text = Format_Entire_Date(reader["TargetStart"].ToString());
        Date_Text_Update(TextBox_Target_Start);
        // Actual Test Start Date
        TextBox_Test_Start.Text = Format_Entire_Date(reader["TestStart"].ToString());
        Date_Text_Update(TextBox_Test_Start);
        // Actual Test End Date
        TextBox_Test_End.Text = Format_Entire_Date(reader["TestEnd"].ToString());
        Date_Text_Update(TextBox_Test_End);
        // Customer Contact Information
        TextBox_Customer_Contact.Text = reader["CustomerContact"].ToString();

        // Customer Name
        TextBox_Customer_Name.Text = reader["CustomerName"].ToString();

        // System Name
        TextBox_System_Name.Text = reader["SystemName"].ToString();

        // Device Type
        DropDown_DeviceType.SelectedValue = reader["DeviceType"].ToString();

        // Report Written Date
        TextBox_ReportWritten.Text = Format_Entire_Date(reader["ReportWritten"].ToString());
        Date_Text_Update(TextBox_ReportWritten);
        // Report Initial Checked?
        TextBox_Initial_Report_Check.Text = Format_Entire_Date(reader["ReportInitialCheck"].ToString());
        Date_Text_Update(TextBox_Initial_Report_Check);
        // Report Final checked?
        TextBox_Final_Report_Check.Text = Format_Entire_Date(reader["ReportFinalCheck"].ToString());
        Date_Text_Update(TextBox_Final_Report_Check);

        // Invoice Date
        TextBox_InvoiceDate.Text = Format_Entire_Date(reader["Invoiced"].ToString());
        Date_Text_Update(TextBox_InvoiceDate);

        TextBox_Comments.Text = reader["Comments"].ToString();

        // 1 has to be subtracted to account for indices of list starting at 0 where the DB table starts at 1
        reader.Close();

        DropDownList_Status.DataBind();
        DropDownList_ReportOrMemo.DataBind();
        CheckBox_Dynamic_Testing.DataBind();
        CheckBox_Static_Testing.DataBind();
        DropDown_PM.DataBind();
        DropDown_TestEngineer.DataBind();

        con.Close();
    }
        


    protected void Button_UpdateJob_Click(object sender, EventArgs e)
    {
        try
        {
            string updateCommand = "UPDATE job " +
                "SET PM_idPM=@PMid, TestEngineer_idTestEngineer=@idTestEngineer, Status=@status, ReportOrMemo=@ReportMemo, StaticTesting=@Statictesting, DynamicTesting=@Dynamictesting, CustomerContact=@CustomerContact, CustomerName=@CustomerName, SystemName=@SystemName, DeviceType=@DeviceType, Comments=@Comments, ";

            MySqlConnection con = new MySqlConnection(connectionString);

            MySqlCommand cmd = new MySqlCommand(updateCommand, con);

            // Set parameters to locally set values
            //cmd.Parameters.AddWithValue("@Rev", DropDown_Revision.SelectedValue);
            cmd.Parameters.AddWithValue("@PMid", (DropDown_PM.SelectedIndex + 1));
            cmd.Parameters.AddWithValue("@idTestEngineer", (DropDown_TestEngineer.SelectedIndex + 1));
            cmd.Parameters.AddWithValue("@status", DropDownList_Status.Text);

            if (TextBox_DeliveryDate.Text != "")
            {
                updateCommand += "DeliveryDate=@DeliveryDate,";
                cmd.Parameters.AddWithValue("@DeliveryDate", GetDateTime(TextBox_DeliveryDate));
            }

            cmd.Parameters.AddWithValue("@ReportMemo", DropDownList_ReportOrMemo.Text);
            cmd.Parameters.AddWithValue("@Statictesting", CheckBox_Static_Testing.Checked);
            cmd.Parameters.AddWithValue("@Dynamictesting", CheckBox_Dynamic_Testing.Checked);

            if (TextBox_PODate.Text != "")
            {
                updateCommand += "PODate=@PODate,";
                cmd.Parameters.AddWithValue("@PODate", GetDateTime(TextBox_PODate));
            }

            if (TextBox_FBuild.Text != "")
            {
                updateCommand += "FolderBuilt=@FolderBuild,";
                cmd.Parameters.AddWithValue("@FolderBuild", GetDateTime(TextBox_FBuild));
            }

            if (TextBox_FCheck.Text != "")
            {
                updateCommand += "FolderCheck=@FolderCheck,";
                cmd.Parameters.AddWithValue("@FolderCheck", GetDateTime(TextBox_FCheck));
            }

            if (TextBox_Target_Start.Text != "")
            {
                updateCommand += "TargetStart=@TargetStart,";
                cmd.Parameters.AddWithValue("@TargetStart", GetDateTime(TextBox_Target_Start));
            }

            if (TextBox_Test_Start.Text != "")
            {
                updateCommand += "TestStart=@TestStart,";
                cmd.Parameters.AddWithValue("@TestStart", GetDateTime(TextBox_Test_Start));
            }

            if (TextBox_Test_End.Text != "")
            {
                updateCommand += "TestEnd=@TestEnd,";
                cmd.Parameters.AddWithValue("@TestEnd", GetDateTime(TextBox_Test_End));
            }

            cmd.Parameters.AddWithValue("@CustomerContact", TextBox_Customer_Contact.Text);
            cmd.Parameters.AddWithValue("@CustomerName", TextBox_Customer_Name.Text);
            cmd.Parameters.AddWithValue("@SystemName", TextBox_System_Name.Text);
            cmd.Parameters.AddWithValue("@DeviceType", DropDown_DeviceType.SelectedValue);

            if (TextBox_ReportWritten.Text != "")
            {
                updateCommand += "ReportWritten=@ReportWritten,";
                cmd.Parameters.AddWithValue("@ReportWritten", GetDateTime(TextBox_ReportWritten));
            }

            if (TextBox_Initial_Report_Check.Text != "")
            {
                updateCommand += "ReportInitialCheck=@InitialCheck,";
                cmd.Parameters.AddWithValue("@InitialCheck", GetDateTime(TextBox_Initial_Report_Check));
            }

            if (TextBox_Final_Report_Check.Text != "")
            {
                updateCommand += "ReportFinalCheck=@ReportFinalCheck,";
                cmd.Parameters.AddWithValue("@ReportFinalCheck", GetDateTime(TextBox_Final_Report_Check));
            }
            
            if (TextBox_InvoiceDate.Text != "")
            {
                updateCommand += "Invoiced=@Invoiced,";
                cmd.Parameters.AddWithValue("@Invoiced", GetDateTime(TextBox_InvoiceDate));
            }

            cmd.Parameters.AddWithValue("@Comments", TextBox_Comments.Text);

            Debug.WriteLine("Update Substring Prior:  " + updateCommand);

            Debug.WriteLine(updateCommand.Last());

            // Removes last comma if there is one
            if (updateCommand.Last() == ',' || updateCommand.Last() == ' ')
            {
                updateCommand = updateCommand.Substring(0, updateCommand.Length - 1);
            }

            if (updateCommand.Last() == ',' || updateCommand.Last() == ' ')
            {
                updateCommand = updateCommand.Substring(0, updateCommand.Length - 1);
            }

            Debug.WriteLine("Update Substring After:  " + updateCommand);

            updateCommand += " WHERE (idJob=@JobID AND Revision=@Rev)";

            //
            // Last comma removal from SQL statement not working!  See lns. 351-356.
            //

            cmd.Parameters.AddWithValue("@Jobid", DropDownList1.SelectedValue);
            cmd.Parameters.AddWithValue("@Rev", DropDown_Revision.SelectedValue);

            Debug.WriteLine("Job id:  " + DropDownList1.SelectedValue + "       " + " Revision:  " + DropDown_Revision.SelectedValue);

            Debug.WriteLine(updateCommand.ToString());

            cmd.CommandText = updateCommand;

            using (con)
            {
                con.Open();
                cmd.ExecuteNonQuery(); // Need error checking here
            }
        }
        catch (Exception UpdateException)
        {
            Throw_Error_Message(UpdateException.Message);
        }

    }

    protected string GetDateTime(TextBox DateTimeTextBox)
    {
        Debug.WriteLine("Entered:  " + DateTimeTextBox.Text);

        // Monitor this IF statement
        if (DateTimeTextBox.Text.Length < 4)
        {
            return DateTimeTextBox.Text;
        }
        else
        {
            string month = DateTimeTextBox.Text.Substring(3, 3);
            string year = "20" + DateTimeTextBox.Text.Substring(7, 2);
            string day = DateTimeTextBox.Text.Substring(0, 2);

            int month_Int = 0;

            switch (month)
            {
                case "Jan":
                    month_Int = 1;
                    break;
                case "Feb":
                    month_Int = 2;
                    break;
                case "Mar":
                    month_Int = 3;
                    break;
                case "Apr":
                    month_Int = 4;
                    break;
                case "May":
                    month_Int = 5;
                    break;
                case "Jun":
                    month_Int = 6;
                    break;
                case "Jul":
                    month_Int = 7;
                    break;
                case "Aug":
                    month_Int = 8;
                    break;
                case "Sep":
                    month_Int = 9;
                    break;
                case "Oct":
                    month_Int = 10;
                    break;
                case "Nov":
                    month_Int = 11;
                    break;
                case "Dec":
                    month_Int = 12;
                    break;
            }

            string date = year + "-" + month_Int + "-" + day;

            return date;
        }
    }

    protected void Button_NewJob_Click(object sender, EventArgs e)
    {
        // Empty containers
        DropDownList_Status.SelectedIndex = 0;
        TextBox_DeliveryDate.Text = "";
        DropDownList_ReportOrMemo.SelectedIndex = 0;
        CheckBox_Dynamic_Testing.Checked = false;
        CheckBox_Static_Testing.Checked = false;
        TextBox_PODate.Text = "";
        TextBox_FBuild.Text = "";
        TextBox_FCheck.Text = "";
        TextBox_Target_Start.Text = "";
        TextBox_Test_Start.Text = "";
        TextBox_Test_End.Text = "";
        TextBox_Customer_Contact.Text = "";
        TextBox_Customer_Name.Text = "";
        TextBox_System_Name.Text = "";
        DropDown_DeviceType.SelectedIndex = -1;
        DropDown_PM.SelectedIndex = 0;
        DropDown_TestEngineer.SelectedIndex = 0;
        TextBox_ReportWritten.Text = "";
        TextBox_Initial_Report_Check.Text = "";
        TextBox_Final_Report_Check.Text = "";
        TextBox_InvoiceDate.Text = "";
        TextBox_Comments.Text = "";
        // End emptying of containers

        // If TextBox_Job# is empty--insert without and let the system auto-increment
        if (TextBox_NewJobNumber.Text == "")
        {
            string insertCommand = "INSERT INTO `job` (`Revision`) VALUES ('A')";

            MySqlConnection con = new MySqlConnection(connectionString);

            MySqlCommand cmd = new MySqlCommand(insertCommand, con);

            //cmd.Parameters.AddWithValue("@status", "Folder Build");
            //cmd.Parameters.AddWithValue("@PMid", 1);
            //cmd.Parameters.AddWithValue("@TEid", 1);


            using (con)
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }

            RefreshDropDown();

            DropDownList1.SelectedIndex = DropDownList1.Items.Count - 1;
        }
        else
        {
            string insertCommand = "INSERT INTO `job` (`idJob`) VALUES (@newJobID)";

            MySqlConnection con = new MySqlConnection(connectionString);
            MySqlCommand cmd = new MySqlCommand(insertCommand, con);

            cmd.Parameters.AddWithValue("@newJobID", int.Parse(TextBox_NewJobNumber.Text));

            using (con)
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }

            Refresh_Job_Numbers();

            DropDownList1.SelectedValue = TextBox_NewJobNumber.Text;

        }
        

    }

    protected void Date_Text_Update(TextBox myTextBox)
    {
        if (myTextBox.Text.Length > 4)
        {
            try
            {

                int Month = int.Parse(myTextBox.Text.Substring(3, 2));

                string s_Month = "";

                switch (Month)
                {
                    case 1:
                        s_Month = "Jan";
                        break;
                    case 2:
                        s_Month = "Feb";
                        break;
                    case 3:
                        s_Month = "Mar";
                        break;
                    case 4:
                        s_Month = "Apr";
                        break;
                    case 5:
                        s_Month = "May";
                        break;
                    case 6:
                        s_Month = "Jun";
                        break;
                    case 7:
                        s_Month = "Jul";
                        break;
                    case 8:
                        s_Month = "Aug";
                        break;
                    case 9:
                        s_Month = "Sep";
                        break;
                    case 10:
                        s_Month = "Oct";
                        break;
                    case 11:
                        s_Month = "Nov";
                        break;
                    case 12:
                        s_Month = "Dec";
                        break;
                }

                Debug.WriteLine(s_Month.ToString());

                string newDate = myTextBox.Text.Substring(0, 3) + s_Month + "-" + myTextBox.Text.Substring(8, 2);

                myTextBox.Text = newDate;

            }
            catch
            {
                Throw_Error_Message("Error selecting date:  please try again.");
            }
        }
    }

    
    protected void Throw_Error_Message(string message)
    {
        TextBox_Error_Messages.Visible = true;
        TextBox_Error_Messages.Text = message;
    }

    

    // Add Revision
    protected void Button1_Click(object sender, EventArgs e)
    {
        string insertCommand = "INSERT INTO `job` (`idJob`, `Revision`) VALUES (@newJobID, @Revision)";

        MySqlConnection con = new MySqlConnection(connectionString);
        MySqlCommand cmd = new MySqlCommand(insertCommand, con);

        cmd.Parameters.AddWithValue("@Revision", getNextRevision(DropDown_Revision.SelectedValue));
        cmd.Parameters.AddWithValue("@newJobID", DropDownList1.SelectedValue);

        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }

        Refresh_Revisions();

    }

    protected char getNextRevision(string Selection)
    {

        Debug.WriteLine("Current Revision:  " + Selection[0]);

        char current_Rev = Selection[0];

        char next_Rev = (char)(Convert.ToUInt16(current_Rev) + 1);

        Debug.WriteLine("Next Revision:  " + next_Rev);

        return next_Rev;
    }
    protected void DropDown_Revision_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            // Retrieve information for selected job:
            string selectSQL = "SELECT * FROM `job` WHERE (idJob=@JobID AND Revision=@Rev)";

            MySqlConnection con = new MySqlConnection(connectionString);

            MySqlCommand cmd = new MySqlCommand(selectSQL, con);

            cmd.Parameters.AddWithValue("@JobID", DropDownList1.SelectedValue);
            cmd.Parameters.AddWithValue("@Rev", DropDown_Revision.SelectedValue);

            con.Open();

            MySqlDataReader reader = cmd.ExecuteReader();
            reader.Read();

            // Partnership Manager
            DropDown_PM.SelectedIndex = (int)reader["PM_idPM"] - 1;

            // Test Engineer
            DropDown_TestEngineer.SelectedIndex = (int)reader["TestEngineer_idTestEngineer"] - 1;

            // Status
            DropDownList_Status.Text = reader["Status"].ToString();

            // Delivery Dates
            TextBox_DeliveryDate.Text = Format_Entire_Date(reader["DeliveryDate"].ToString());
            Date_Text_Update(TextBox_DeliveryDate);
            // Report or Memo?
            string ReportOrMemo = reader["ReportOrMemo"].ToString();

            // Static Testing
            CheckBox_Static_Testing.Checked = (bool)reader["StaticTesting"];

            // Dynamic Testing
            CheckBox_Dynamic_Testing.Checked = (bool)reader["DynamicTesting"];

            // PO Date
            TextBox_PODate.Text = Format_Entire_Date(reader["PODate"].ToString());
            Date_Text_Update(TextBox_PODate);
            // Folder Build Date
            TextBox_FBuild.Text = Format_Entire_Date(reader["FolderBuilt"].ToString());
            Date_Text_Update(TextBox_FBuild);
            // Folder Check Date
            TextBox_FCheck.Text = Format_Entire_Date(reader["FolderCheck"].ToString());
            Date_Text_Update(TextBox_FCheck);
            // Target Start Date
            TextBox_Target_Start.Text = Format_Entire_Date(reader["TargetStart"].ToString());
            Date_Text_Update(TextBox_Target_Start);
            // Actual Test Start Date
            TextBox_Test_Start.Text = Format_Entire_Date(reader["TestStart"].ToString());
            Date_Text_Update(TextBox_Test_Start);
            // Actual Test End Date
            TextBox_Test_End.Text = Format_Entire_Date(reader["TestEnd"].ToString());
            Date_Text_Update(TextBox_Test_End);
            // Customer Contact Information
            TextBox_Customer_Contact.Text = reader["CustomerContact"].ToString();

            // Customer Name
            TextBox_Customer_Name.Text = reader["CustomerName"].ToString();

            // System Name
            TextBox_System_Name.Text = reader["SystemName"].ToString();

            // Device Type
            DropDown_DeviceType.SelectedValue = reader["DeviceType"].ToString();

            // Report Written Date
            TextBox_ReportWritten.Text = Format_Entire_Date(reader["ReportWritten"].ToString());
            Date_Text_Update(TextBox_ReportWritten);
            // Report Initial Checked?
            TextBox_Initial_Report_Check.Text = Format_Entire_Date(reader["ReportInitialCheck"].ToString());
            Date_Text_Update(TextBox_Initial_Report_Check);
            // Report Final checked?
            TextBox_Final_Report_Check.Text = Format_Entire_Date(reader["ReportFinalCheck"].ToString());
            Date_Text_Update(TextBox_Final_Report_Check);

            // Invoice Date
            TextBox_InvoiceDate.Text = Format_Entire_Date(reader["Invoiced"].ToString());
            Date_Text_Update(TextBox_InvoiceDate);

            TextBox_Comments.Text = reader["Comments"].ToString();

            // 1 has to be subtracted to account for indices of list starting at 0 where the DB table starts at 1
            reader.Close();

            DropDownList_Status.DataBind();
            DropDownList_ReportOrMemo.DataBind();
            CheckBox_Dynamic_Testing.DataBind();
            CheckBox_Static_Testing.DataBind();
            DropDown_PM.DataBind();
            DropDown_TestEngineer.DataBind();

            con.Close();
        }
        catch (Exception JDTException)
        {
            Throw_Error_Message(JDTException.Message);
        }
    }
    protected void Button_Delete_Click(object sender, EventArgs e)
    {
        string deleteCommand = "DELETE FROM `job` WHERE (idJob=@JobID AND Revision=@Rev)";

        MySqlConnection con = new MySqlConnection(connectionString);
        MySqlCommand cmd = new MySqlCommand(deleteCommand, con);

        cmd.Parameters.AddWithValue("@JobID", DropDownList1.SelectedValue);
        cmd.Parameters.AddWithValue("@Rev", DropDown_Revision.SelectedValue);

        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }

        Refresh_Job_Numbers();
        Refresh_Revisions();
    }
}