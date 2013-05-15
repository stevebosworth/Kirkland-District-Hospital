using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    wtLinqClass_sb objLinq = new wtLinqClass_sb();

    protected void Page_Load(object sender, EventArgs e)
    {
        TimeSpan wt = objLinq.currentWaitTime();
        lbl_wt_time.Text = wt.ToString(@"hh\:mm\:ss");
    }

    protected void calcAvgWait(object sender, EventArgs e)
    {
        TimeSpan wt = objLinq.currentWaitTime();
        lbl_wt_time.Text = wt.ToString(@"hh\:mm\:ss");
    }
}