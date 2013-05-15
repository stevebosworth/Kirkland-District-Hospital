using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    cmsLinqClass_sb objLinq = new cmsLinqClass_sb();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            var _url = Request.QueryString["page"];

            rpt_page.DataSource = objLinq.getPublishedPageByUrl(_url);
            rpt_page.DataBind();
        }
    }
}