using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_eventsAdmin_sk : System.Web.UI.Page
{
    string[] eventTypes = { "--Select--", "Health Lectures", "Classes", "Doctor Appointments" };
    public string currDate = String.Empty;
    private static long id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            RefreshGridView();
            foreach (string st in eventTypes)
            {
                ddlEventType.Items.Add(st);
            }
        }
    }

    public void RefreshGridView()
    {
        eventsLinqClass db = new eventsLinqClass();
        GridViewResult.DataSource = db.GetAllEvents();
        GridViewResult.DataBind();
    }


    //code to add new event to the database
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        lblStatus.Text = "";
        dp_Event newEvent = new dp_Event();
        newEvent.Date = Request.Form["txtDate"];
        newEvent.EventName = txtEventName.Text;
        newEvent.Organizers = txtOrganizers.Text;
        newEvent.Venue = txtVenue.Text;
        newEvent.Timings = txtTimings.Text;
        newEvent.Guest = txtGuest.Text;
        newEvent.EventType = ddlEventType.SelectedItem.ToString();
        eventsLinqClass db = new eventsLinqClass();
        db.AddEvent(newEvent);
        Reset();
        RefreshGridView();
        lblStatus.Text = "Event Successfully Added";
    }

    //to reset all the fields after an event is added
    public void Reset()
    {
        txtEventName.Text = "";
        txtOrganizers.Text = "";
        txtVenue.Text = "";
        txtTimings.Text = "";
        txtGuest.Text = "";
    }


    protected void GridViewResult_SelectedIndexChanged(object sender, EventArgs e)
    {
        id = Convert.ToInt64(GridViewResult.SelectedValue.ToString());
    }

    //to delete the selected row
    protected void GridViewResult_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        eventsLinqClass db = new eventsLinqClass();
        int id = Convert.ToInt32(GridViewResult.Rows[e.RowIndex].Cells[1].Text);
        db.DeleteEventById(id);
        Response.Redirect("eventsAdmin_sk.aspx");
    }

    //to cancel the adding of new event
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("eventsAdmin_sk.aspx");
    }

    //to update the selected event
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        eventsLinqClass db = new eventsLinqClass();
        dp_Event ee = new dp_Event();
        ee.Id = id;
        ee.EventName = txtEventName.Text;
        ee.EventType = ddlEventType.SelectedItem.ToString();
        ee.Organizers = txtOrganizers.Text;
        ee.Date = Request.Form["txtDate"];
        ee.Venue = txtVenue.Text;
        ee.Timings = txtTimings.Text;
        ee.Guest = txtGuest.Text;
        db.UpdateEvent(ee);
        Response.Redirect("eventsAdmin_sk.aspx");

    }

    //to edit the selected row
    protected void GridViewResult_RowEditing(object sender, GridViewEditEventArgs e)
    {
        btnAdd.Visible = false;
        btnCancel.Visible = true;
        btnUpdate.Visible = true;

        id = Convert.ToInt64(GridViewResult.Rows[e.NewEditIndex].Cells[1].Text);
        txtEventName.Text = GridViewResult.Rows[e.NewEditIndex].Cells[2].Text.ToString();
        ddlEventType.SelectedValue = GridViewResult.Rows[e.NewEditIndex].Cells[3].Text.ToString();
        txtOrganizers.Text = GridViewResult.Rows[e.NewEditIndex].Cells[4].Text.ToString();
        currDate = GridViewResult.Rows[e.NewEditIndex].Cells[5].Text.ToString();
        txtVenue.Text = GridViewResult.Rows[e.NewEditIndex].Cells[6].Text.ToString();
        txtTimings.Text = GridViewResult.Rows[e.NewEditIndex].Cells[7].Text.ToString();
        txtGuest.Text = GridViewResult.Rows[e.NewEditIndex].Cells[8].Text.ToString();
    }
}