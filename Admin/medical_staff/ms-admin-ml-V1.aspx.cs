using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ms_admin_ml_V1 : System.Web.UI.Page
{
    ms_ClassMedicalServices objLinq = new ms_ClassMedicalServices();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            _subRebind();

        }
    }
    
    private void _subRebind()
    {
        //Adding code to empty textbox at insert section
        txt_serviceNameI.Text = string.Empty;
        txt_serviceDetailI.Text = string.Empty;
        txt_hOperationI.Text = string.Empty;
        txt_imageI.Text = string.Empty;

        //Adding code to create dropdownlist with get medical values
        ddl_main.DataSource = objLinq.getMedical();
        ddl_main.DataTextField = "ms_serviceName";
        ddl_main.DataValueField = "ms_id";
        ddl_main.DataBind();

        //Using id from dropdownlist to display information using listview
        int _id = int.Parse(ddl_main.SelectedValue.ToString());
        ltv_main.DataSource = objLinq.getMedicalServicesByID(_id);
        ltv_main.DataBind();

    }

    protected void subChange(object sender, EventArgs e)
    {
        //Using id from dropdownlist to display information using listview
        int _id = int.Parse(ddl_main.SelectedValue.ToString());
        ltv_main.DataSource = objLinq.getMedicalServicesByID(_id);
        ltv_main.DataBind();
    }

    private void _strMessage(bool flag, string str)
    {
        
        //Adding code to display message
        if (flag)
        {
            lbl_message.Text = "<span sytle='color:green;'> Medical Service " + str + " was successful </span>";
        }
        else
        {
            lbl_message.Text = "<span Style='color:red;'> Sorry, unable to" + str + "Medical Service</span>";
        }
    }
    protected void subInsert(object sender, EventArgs e)
    {
        //Adding code to insert data into table
        _strMessage(objLinq.commitInsert(txt_serviceNameI.Text, txt_serviceDetailI.Text, txt_hOperationI.Text, txt_imageI.Text), "insert");
        _subRebind();

    }
    protected void subAdmin(object sender, ListViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "subUpdate":
                //Adding code to perform update and commit update
                TextBox txtserviceName = (TextBox)e.Item.FindControl("txt_serviceNameE");
                TextBox txtserviceDetails = (TextBox)e.Item.FindControl("txt_serviceDetailsE");
                TextBox txthoursOperation = (TextBox)e.Item.FindControl("txt_hOperationE");
                TextBox txtimage = (TextBox)e.Item.FindControl("txt_imageE");


                HiddenField hdfID = (HiddenField)e.Item.FindControl("hdf_idE");
                int servID = int.Parse(hdfID.Value.ToString());

                _strMessage(objLinq.commitUpdate(servID, txtserviceName.Text, txtserviceDetails.Text, txthoursOperation.Text, txtimage.Text), "update");
                _subRebind();
                break;

            case "subDelete":
                //Adding code to delete and commit delete
                int _id = int.Parse(((HiddenField)e.Item.FindControl("hdf_idE")).Value);
                _strMessage(objLinq.commitDelete(_id), "delete");
                _subRebind();
                break;
        }
    }
}
