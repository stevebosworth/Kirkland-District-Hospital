using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    ppClass_sb objPark = new ppClass_sb();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            _subRebind();
        }
    }

    private void _panelControl(Panel pnl)
    {
        pnl_list.Visible = false;
        pnl_find.Visible = false;
        pnl.Visible = true;
    }

    private void _subRebind()
    {
        _panelControl(pnl_list);
        ltv_parking.DataSource = objPark.getAllPermits();
        ltv_parking.DataBind();
    }


    //Controls for mnu_parking
    protected void subMenuClick(object sender, MenuEventArgs e)
    {
        int index = Int32.Parse(e.Item.Value);

        switch (index)
        {
            case 0:
                ltv_parking.DataSource = objPark.getAllPermits();
                DataBind();
                _panelControl(pnl_list);
              
            break;
            case 1:
                ltv_parking.DataSource = objPark.getCurrentPermits(DateTime.Now);
                DataBind();
                _panelControl(pnl_list);
              
            break;
            case 2:
                ltv_parking.DataSource = objPark.getExpiredPermits(DateTime.Now);
                DataBind();
                _panelControl(pnl_list);
               
            break;
            case 3:
                _panelControl(pnl_find);
            break;
        }
    }

    //Get a specific permit and show edit panel
    protected void getPermit(object sender, EventArgs e)
    {
        try
        {
            fmv_permit.DataSource = objPark.getParkingByID_Email(int.Parse(txt_park_idU.Text), txt_emailU.Text);
            fmv_permit.DataBind();
            //mpe_parking_admin.Show();
        }
        catch (Exception)
        {
            lbl_message.Text = "Error: There was a problem. Please Try again.";
            mpe_message.Show();
        }
        
    }



    protected void subAdmin(object sender, ListViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Upd":
                Label lblPermitNum = (Label)e.Item.FindControl("lbl_permit_num");
                fmv_permit.DataSource = objPark.getParkingByID(int.Parse(lblPermitNum.Text));
                fmv_permit.DataBind();
                //mpe_parking_admin.Show();
            break;
            case "Delete":
                
            break;
            case "Ticket":
                
            break;
        }
    }

    private void _strMessage(bool flag, string str)
    {
        if (flag)
        {
            lbl_message.Text = "Permit was successfully" + str;
            mpe_message.Show();
        }
        else
        {
            lbl_message.Text = "Error: Permit was not " + str;
            mpe_message.Show();
        }
    }
}