using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;//imported
using System.Net;//imported

public partial class Admin_non_medical_staff_newsletterAdmin_sk : System.Web.UI.Page
{
    private static int id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        lblShow.Text = "";

        if (!IsPostBack)
        {
            UpdateGridView();
        }


    }

    //to display all the updated news from the database into the gridview
    public void UpdateGridView()
    {
        newsletterClass_sk db = new newsletterClass_sk();
        GridViewResult.DataSource = db.GetAllNews();
        GridViewResult.DataBind();
    }

    //code to add new news into the database table
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        dp_New newNews = new dp_New();
        newNews.NewsTitle = txtTitle.Text;
        newNews.NewsDescription = txtDescription.Text;
        newNews.Date = System.DateTime.Now;
        newsletterClass_sk db = new newsletterClass_sk();
        db.AddNews(newNews);
        lblShow.Text = "News Saved";
        SendNews();
        Reset();
        UpdateGridView();

    }

    public void Reset()
    {
        txtTitle.Text = "";
        txtDescription.Text = "";
    }


    protected void GridViewResult_SelectedIndexChanged(object sender, EventArgs e)
    {
        id = Convert.ToInt32(GridViewResult.SelectedValue.ToString());
    }

    //code to delete the selected news
    protected void GridViewResult_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        newsletterClass_sk db = new newsletterClass_sk();
        int id = Convert.ToInt32(GridViewResult.Rows[e.RowIndex].Cells[1].Text);
        db.DeleteNewsById(id);
        Response.Redirect("newsletterAdmin_sk.aspx");
    }

    //code to selct the rows which are to be edited and display in the text boxes
    protected void GridViewResult_RowEditing(object sender, GridViewEditEventArgs e)
    {
        btnAdd.Visible = false;
        btnCancel.Visible = true;
        btnUpdate.Visible = true;

        id = Convert.ToInt32(GridViewResult.Rows[e.NewEditIndex].Cells[1].Text);
        txtTitle.Text = GridViewResult.Rows[e.NewEditIndex].Cells[2].Text.ToString();
        txtDescription.Text = GridViewResult.Rows[e.NewEditIndex].Cells[2].Text.ToString();
    }

    //code to update the news
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        newsletterClass_sk db = new newsletterClass_sk();
        dp_New ee = new dp_New();
        ee.Id = id;
        ee.NewsTitle = txtTitle.Text;

        ee.NewsDescription = txtDescription.Text;
        ee.Date = System.DateTime.Now;

        db.UpdateEvent(ee);
        Response.Redirect("newsletterAdmin_sk.aspx");
        
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Reset();
    }

    //code to send the newsletter via email to the subscribed users
    public void SendNews()
    {
        try
        {

            dp_New newNews = new dp_New();
            List<dp_NewsSignUp> allEmails = new List<dp_NewsSignUp>();

            //Create the msg object to be sent
            MailMessage msg = new MailMessage();
            //Add your email address to the recipients

            foreach (dp_NewsSignUp email in allEmails)
            {

                msg.Bcc.Add(email.Email);
            }


            //Configure the address we are sending the mail from
            MailAddress address = new MailAddress("kdh@stevebosworth.ca");
            msg.From = address;
            //Append their name in the beginning of the subject
            msg.Subject = "News Letter ";
            msg.Body = "News";

            //Configure an SmtpClient to send the mail.
            SmtpClient client = new SmtpClient("mail.stevebosworth.ca");
            client.EnableSsl = false; //only enable this if your provider requires it
            //Setup credentials to login to our sender email address ("UserName", "Password")
            NetworkCredential credentials = new NetworkCredential("kdh@stevebosworth.ca", "Pa55w0rd!");
            client.Credentials = credentials;

            //Send the msg
            client.Send(msg);
        }
        catch
        {

        }
    }
}