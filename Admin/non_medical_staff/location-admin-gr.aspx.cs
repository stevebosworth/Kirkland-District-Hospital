using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    //creating an instance of the LINQ class
    tblocation_gr objLinq = new tblocation_gr();
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
        switch (e.CommandName)
        {
            case "Insert":
                _strMessage(objLinq.commitInsert(txt_deptnameI.Text, txt_locationI.Text, txt_phoneI.Text, txt_geoI.Text) , "insert");
                _subRebind();
                break;

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
                TextBox txtdeptname = (TextBox)e.Item.FindControl("txt_deptnameU");
                TextBox txtlocation = (TextBox)e.Item.FindControl("txt_locationU");
                TextBox txtphone = (TextBox)e.Item.FindControl("txt_phoneU");
                TextBox txtgeo = (TextBox)e.Item.FindControl("txt_geoU");
                HiddenField hdfID = (HiddenField)e.Item.FindControl("hdf_id");
                int proID = int.Parse(hdfID.Value.ToString());
                _strMessage(objLinq.commitUpdate(proID,txtdeptname.Text, txtlocation.Text, txtphone.Text, txtgeo.Text), "update");
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
        tblocation_gr _linq = new tblocation_gr();
        dtl_update.DataSource = _linq.getLocationByID(id);
        dtl_update.DataBind();
    }

    private void _showDelete(int id)
    {
        _panelControl(pnl_delete);
        dtl_delete.DataSource = objLinq.getLocationByID(id);
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
        txt_deptnameI.Text = string.Empty;
        txt_locationI.Text = string.Empty;
        txt_phoneI.Text = string.Empty;
        txt_geoI.Text = string.Empty;
        dtl_all.DataSource = objLinq.getLocations();
        dtl_all.DataBind();
        _panelControl(pnl_all);
    }

    private void _strMessage(bool flag, string str)
    {
        if (flag)
        {
            lbl_message.Text = "Department " + str + " was successful";
        }
        else
        {
            lbl_message.Text = "Sorry, unable to " + str + " Department";
        }
    }
}