using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;

public partial class _Default : System.Web.UI.Page
{
    DonorClass objLinq = new DonorClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void bgroupSelect(object sender, EventArgs e)
    {
        //Test
        //string test = ddl_bgroup.SelectedValue.ToString();
        //lbl_message.Text = test;


        //passing the blood group to the linq class to call all the donors with same group
        dtl_all.DataSource = objLinq.getDonorByBgroup(ddl_bgroup.SelectedValue.ToString());
        // this binds the datalist
        dtl_all.DataBind();
    }
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        //this stores the email addresses in a string which is then passed to the send email function.
        string Dl = "";
        foreach (DataListItem dli in dtl_all.Items)
        {
            CheckBox chk = (CheckBox)dli.FindControl("ckb_email");
            if (chk.Checked)
            {
                Dl += (chk.Text + ";");
            }
        }
        try
        {
            // THIS IS THE TEAM's SEND EMAIL SCRIPT

            //Create the msg object to be sent
            MailMessage msg = new MailMessage();
            //Add your email address to the recipients
            msg.To.Add(Dl);
            //Configure the address we are sending the mail from
            MailAddress address = new MailAddress("kdh@stevebosworth.ca");
            msg.From = address;
            //Append their name in the beginning of the subject
            msg.Subject = "Urgent Blood Requirement KD Hospital";
            msg.Body = "We have an urgent requirement of your Blood, Please contact us soon to confirm your availability...." ;


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
            //If the message failed at some point, let the user know

            lbl_message.Text = "Your message failed to send, please try again.";
        }
        
    }
}