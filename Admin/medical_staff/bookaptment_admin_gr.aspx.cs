using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    //creating an instance of the LINQ class
    bookingClass objLinq = new bookingClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        //this checks if the page has been updated and calls rebind method in case a new entry has been inserted, hence it is showed dynamically after every insert
        if (!Page.IsPostBack)
        {
            _subRebind();
        }
    }
    protected void subAdmin(object sender, CommandEventArgs e)
    {
        // For the time being INSERT is not necessary as the user can himself book an appointment.
        switch (e.CommandName)
        {
        //    case "Insert":
        //        _strMessage(objLinq.commitInsert(.......);
        //        _subRebind();
        //        break;

            case "Update":
                _showUpdate(int.Parse(e.CommandArgument.ToString()));
                break;

            case "Delete":
                _showDelete(int.Parse(e.CommandArgument.ToString()));
                break;

        }
    }

    protected void subUpDel(object sender, DataListCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Update":
                TextBox txtfname = (TextBox)e.Item.FindControl("txt_fnameU");
                TextBox txtlname = (TextBox)e.Item.FindControl("txt_lnameU");
                TextBox txtphone = (TextBox)e.Item.FindControl("txt_phoneU");
                TextBox txtemail = (TextBox)e.Item.FindControl("txt_emailU");
                TextBox txtdate = (TextBox)e.Item.FindControl("txt_dateU");
                DateTime txtDate = Convert.ToDateTime(txtdate.Text);
                HiddenField hdfID = (HiddenField)e.Item.FindControl("hdf_id");
                int proID = int.Parse(hdfID.Value.ToString());
                _strMessage(objLinq.commitUpdate(proID, txtfname.Text, txtlname.Text, txtphone.Text, txtemail.Text, txtDate), "update");
                _subRebind();

                break;
            case "Delete":
                int _id = int.Parse(((HiddenField)e.Item.FindControl("hdf_id")).Value);
                _strMessage(objLinq.commitDelete(_id), "delete");
                _subRebind();
                break;

            case "Cancel":
                _subRebind();
                break;
        }
    }

    private void _showUpdate(int id)
    {
        _panelControl(pnl_update);
        bookingClass _linq = new bookingClass();
        dtl_update.DataSource = _linq.getBookingByID(id);
        dtl_update.DataBind();
    }

    private void _showDelete(int id)
    {
        _panelControl(pnl_delete);
        dtl_delete.DataSource = objLinq.getBookingByID(id);
        dtl_delete.DataBind();
    }

    private void _panelControl(Panel pnl)
    {
        pnl_all.Visible = false;
        pnl_delete.Visible = false;
        pnl_update.Visible = false;
        pnl.Visible = true;
    }

    private void _subRebind()
    {
        
        dtl_all.DataSource = objLinq.getbookings();
        dtl_all.DataBind();
        _panelControl(pnl_all);
    }

    private void _strMessage(bool flag, string str)
    {
        if (flag)
        {
            lbl_message.Text = "Appointment " + str + " was successfully updates";
        }
        else
        {
            lbl_message.Text = "Sorry, unable to " + str + " update the appointment";
        }
    }
}