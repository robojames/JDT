using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using MySql.Data.MySqlClient;

public partial class _Default : System.Web.UI.Page
{
    private string connectionString = "server=localhost; uid=root; pwd=beebe123; database=jdt;";

    protected void Page_PreInit(object sender, EventArgs e)
    {
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
   


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            try
            {
                DateTime theDate = DateTime.Parse(DataBinder.Eval(e.Row.DataItem, "ReportWritten").ToString());
                e.Row.Cells[3].BackColor = System.Drawing.Color.LightGreen;
            }
            catch
            {
                e.Row.Cells[3].BackColor = System.Drawing.Color.Red;
            }

            try
            {
                DateTime theDate = DateTime.Parse(DataBinder.Eval(e.Row.DataItem, "ReportInitialCheck").ToString());
                e.Row.Cells[4].BackColor = System.Drawing.Color.LightGreen;
            }
            catch
            {
                e.Row.Cells[4].BackColor = System.Drawing.Color.Red;
            }

            try
            {
                DateTime theDate = DateTime.Parse(DataBinder.Eval(e.Row.DataItem, "ReportFinalCheck").ToString());
                e.Row.Cells[5].BackColor = System.Drawing.Color.LightGreen;
            }
            catch
            {
                e.Row.Cells[5].BackColor = System.Drawing.Color.Red;
            }
            

        }
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        Dictionary<int, string> name_Table = new Dictionary<int, string>();

        
       for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            name_Table.Add(i, GridView1.Rows[i].Cells[0].Text);

            if (i > 0)
            {
                if (GridView1.Rows[i - 1].Cells[0].Text == GridView1.Rows[i].Cells[0].Text)
                {
                    name_Table[i] = "";
                }
            }

            GridView1.Rows[i].Cells[0].Text = name_Table[i];

        }


    }
}