using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

public partial class _Default : System.Web.UI.Page
{
    public string UserName = "";

    protected void Page_PreInit(object sender, EventArgs e)
    {
        UserName = Page.User.Identity.Name;

        string[] temp = UserName.Split('\\');

        UserName = temp[1];
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}