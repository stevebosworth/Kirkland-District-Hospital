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
    ppClass_sb objPark = new ppClass_sb();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txt_name.Text = "";
            txt_email.Text = "";
            txt_plate.Text = "";
            _panelControl(pnl_info);
        }

        
        
    }
    
    protected void subAdmin(object sender, CommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Pay":
                //set datetime for expiry
                DateTime dtExpires = DateTime.Now.AddMinutes(double.Parse(ddl_duration.SelectedValue.ToString()));

                _strMessage(objPark.commitParkingInsert(txt_name.Text, txt_email.Text, txt_plate.Text, ddl_spots.SelectedValue.ToString(), DateTime.Now, dtExpires), "payment", dtExpires, ddl_spots.SelectedValue.ToString());
                //update available spots and rebind spots ddl on form
                objPark.resetSpots();
                _getFreeSpots();

                mpe_message.Show();

            break;
            case "Cancel":
                txt_name.Text = string.Empty;
                txt_email.Text = string.Empty;
                txt_plate.Text = string.Empty;
                ddl_duration.SelectedIndex = 0;
                ddl_spots.SelectedIndex = 0;
            break;
            case "Confirm":
                if (Page.IsValid)
                {

                    lbl_nameC.Text = txt_name.Text;
                    lbl_emailC.Text = txt_email.Text;
                    lbl_plate_numC.Text = txt_email.Text;
                    lbl_spotC.Text = ddl_spots.SelectedValue.ToString();
                    lbl_durationC.Text = ddl_duration.SelectedValue.ToString() + " minutes";
                    txt_card_name.Text = txt_name.Text;
                    mpe_confirm.Show();
                }
            break;
        }
    }

    private void _strMessage(bool flag, string _str, DateTime _timeExp, string _spot)
    {
        if (flag)
        {
            lbl_message.Text = "Thanks for Parking with us! Your " + _str + " was sucessful.";
            //send email reciept if permit added or updated
            //sendReceipt(_timeExp, _spot);
            mpe_message.Show();
            
        }
        else
        {
            lbl_message.Text = "Sorry, Your " + _str + " was not unsuccessful.  Please try again.";
            mpe_message.Show();
        }
    }

    protected void subMenuClick(object sender, MenuEventArgs e)
    {
        int index = Int32.Parse(e.Item.Value);

        switch (index)
        {
            case 0:
                _panelControl(pnl_info);
            break;
            case 1:
                _panelControl(pnl_pay);
                objPark.resetSpots();
                _getFreeSpots();
            break;
            case 2:
                _panelControl(pnl_update);
            break;
        }
    }

    private void _panelControl(Panel pnl)
    {
        pnl_info.Visible = false;
        pnl_pay.Visible = false;
        pnl_update.Visible = false;
        pnl.Visible = true;
    }

    //send current time
    protected void currTime(object sender, EventArgs e)
    {
        lbl_curr_time.Text = DateTime.Now.ToShortTimeString();
    }

    //sets spots dropdown list based on available spots from DB
    private void _getFreeSpots()
    {
        int _occupied = 0;

        ddl_spots.DataSource = objPark.getSpotsByStatus(_occupied);
        ddl_spots.DataValueField = "spot";
        ddl_spots.DataTextField = "spot";
        ddl_spots.DataBind();
    }

    protected void getPermit(object sender, EventArgs e)
    {
        try
        {
            fmv_update.DataSource = objPark.getParkingByID_Email(int.Parse(txt_park_idU.Text), txt_emailU.Text);
            fmv_update.DataBind();
            mpe_update.Show();
        }
        catch(Exception)
        {
            lbl_message.Text = "Error: There was a problem. Please Try again.";
                mpe_message.Show();
        }
    }


    //ADD TIME FORM
    protected void subUpdate(object sender, FormViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Update":
                HiddenField hdfIDU = fmv_update.FindControl("hdf_idU") as HiddenField;
                HiddenField hdfSpot = fmv_update.FindControl("hdf_spotU") as HiddenField;
                DropDownList ddlDurationU = fmv_update.FindControl("ddl_durationU") as DropDownList;
                Label lblTimeExpU = fmv_update.FindControl("lbl_time_expU") as Label;

                DateTime TimeExp = DateTime.Parse(lblTimeExpU.Text);
                //new expiry time
                DateTime newTimeExp = TimeExp.AddMinutes(double.Parse(ddlDurationU.SelectedIndex.ToString()));
                
                //attempt insert in DB and handle success or failure. 
                _strMessage(objPark.commitParkingAddTime(int.Parse(hdfIDU.Value), newTimeExp), "update", newTimeExp, hdfSpot.Value.ToString());
 
            break;
            case "Cancel":
                mpe_update.Hide();
            break;
        }
    }

    //Now in ppClass_sb.cs

    //get expired permits and reset spots to unoccupied
    //private void _resetSpots()
    //{
    //    //get expired spots
    //    var expiredSpots = objPark.getExpiredPermits(DateTime.Now);

    //    foreach (var spot in expiredSpots)
    //    {
    //       var spotSingle = objPark.getSpotBySpot(spot.spot);
            
    //    }
    //}

    //Send Email Receiptfd
    protected void sendReceipt(DateTime _timeExp, string _spot)
    {
        //This is the script provided by my hosting to send mail (Source URL: https://support.gearhost.com/KB/a777/aspnet-form-to-email-example.aspx?KBSearchID=41912)
        try
        {
            //Create the msg object to be sent
            MailMessage msg = new MailMessage();
            //Add your email address to the recipients
            msg.To.Add(txt_email.Text);
            //Configure the address we are sending the mail from
            MailAddress address = new MailAddress("kdh@stevebosworth.ca");
            msg.From = address;
            //Append their name in the beginning of the subject
            msg.Subject = "Your KDH Parking Reciept";
            msg.Body = "Thank you for parking with us. You are parked in " + _spot + " and your permit expires at " + _timeExp.ToString(@"hh\:mm\:ss") + ".";


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