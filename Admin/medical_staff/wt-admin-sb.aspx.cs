using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _wtAdmin: System.Web.UI.Page
{
    wtLinqClass_sb objLinq = new wtLinqClass_sb();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            _subRebind();

            TimeSpan wt = objLinq.currentWaitTime();
            lbl_wt_time.Text = wt.ToString(@"hh\:mm\:ss");
        }
    }

    //INSERT NEW PATIENT
    protected void subInsert(object sender, EventArgs e)
    {
        //call _strMessage to insert.  Returns bool and string for success/failure message
        if (Page.IsValid)
        {
                _strMessage(objLinq.commitPatientInsert(txt_fname.Text, txt_lname.Text, int.Parse(txt_pat_num.Text.ToString()), int.Parse(txt_hcard_num.Text.ToString()), int.Parse(ddl_triage.SelectedValue.ToString()), DateTime.Parse(lbl_chk_in.Text)), "added");
                _subRebind();
        }
    }


    protected void subMenuClick(object sender, MenuEventArgs e)
    {
        int index = Int32.Parse(e.Item.Value);

        if (index == 0)
        {
            _panelControl(pnl_admin);
            
        }
        else
        {
            _panelControl(pnl_upd_patient);
            ddl_pat_name.DataSource = objLinq.getActivePatients();
            ddl_pat_name.DataTextField = "lname";
            ddl_pat_name.DataValueField = "pat_num";
            ddl_pat_name.DataBind();
        }
            
    }

    private void _panelControl(Panel pnl)
    {
        pnl_admin.Visible = false;
        pnl_upd_patient.Visible = false;
        pnl.Visible = true;
    }

    //Get current time for check-in form
    protected void subChkIn(object sender, EventArgs e)
    {
        lbl_chk_in.Text = DateTime.Now.ToString();
    }

    //filter patient list panel based on mnu_manage selection
    protected void subFilter(object sender, MenuEventArgs e)
    {
        int index = Int32.Parse(e.Item.Value);

        switch (index)
        {
            case 0:
                _subRebind();
            break;
            case 1:
                //get all patients and databind
                dtl_patients.DataSource = objLinq.getPatients();
                dtl_patients.DataBind();
            break;
        }
    }

    //Used by PATIENT LIST PANEL 
    protected void subWait(object sender, DataListCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "CalcTime":
                Label lblChkIn = (Label)e.Item.FindControl("lbl_chk_inL");
                Label lblWait = (Label)e.Item.FindControl("lbl_wait");
                DateTime currTime = DateTime.Now;
                DateTime chkIn = DateTime.Parse(lblChkIn.Text);
                TimeSpan wtTime = currTime - chkIn;
                double totalTime = wtTime.TotalMinutes;
                //Display Total Time Waiting
                lblWait.Text = wtTime.ToString(@"hh\:mm\:ss");
            break;

            case "Delete":
                _strMessage(objLinq.commitDeletePatient(int.Parse(e.CommandArgument.ToString())), "deleted");
                _subRebind();
            break;

            case "Edit":
                HiddenField hdfID = (HiddenField)e.Item.FindControl("hdf_id");

                int _id = int.Parse(hdfID.Value.ToString());
                fmv_patients.DataSource = objLinq.getPatientByID(_id);
                fmv_patients.DataBind();
                mpe_patient.Show();
            break;
        }        
    }

    //PATIENT UPDATE 
    protected void subAdmin(object sender, FormViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Upd":
                if (Page.IsValid)
                {

                    HiddenField hdfIDU = fmv_patients.FindControl("hdf_idU") as HiddenField;
                    TextBox txtFNameU = fmv_patients.FindControl("txt_fnameU") as TextBox;
                    TextBox txtLNameU = fmv_patients.FindControl("txt_lnameU") as TextBox;
                    TextBox txtPatNumU = fmv_patients.FindControl("txt_pat_numU") as TextBox;
                    TextBox txtHCardU = fmv_patients.FindControl("txt_hcardU") as TextBox;
                    DropDownList ddlTriageU = fmv_patients.FindControl("ddl_triageU") as DropDownList;

                    int _triageU = int.Parse(ddlTriageU.SelectedValue.ToString());

                    _strMessage(objLinq.commitPatientUpdate(int.Parse(hdfIDU.Value.ToString()), txtFNameU.Text, txtLNameU.Text, int.Parse(txtPatNumU.Text), int.Parse(txtHCardU.Text), _triageU), "updated");

                    _subRebind();
                }
            break;
            case "Can":
                mpe_patient.Hide();
            break;
        }
    }

    //FIGURED OUT A BETTER WAY TO DO THIS BUT LEFT IT IN CAUSE... WELL... YOU KNOW.

    //protected void calcAvgWait(object sender, EventArgs e)
    //{
        
    //    //Get all Active Patients
    //    var activePatients = objLinq.getActivePatients();

    //    int total = activePatients.Count();

    //    //list of patients in ER and how long they will wait
    //    List<TimeSpan> listTimeLeft = new List<TimeSpan>();

    //    foreach (var row in activePatients)
    //    {
    //        //Time patients has been waiting
    //        DateTime currTime = DateTime.Now;
    //        DateTime chkInTime = DateTime.Parse(row.chk_in.ToString());
    //        TimeSpan timeWaiting = currTime - chkInTime;
    //        //Expected total wait given triage level
    //        TimeSpan triage = TimeSpan.FromHours(row.triage_id);          
            
    //         TimeSpan timeLeft = triage - timeWaiting;

    //         if (timeLeft.TotalHours > double.Parse(triage.ToString(@"hh")))
    //         {
    //             Response.Write("<script>alert('There are Active Patients who have been waiting longer than their assigned triage level.  Please review the Current Patients list and correct any errors.');</script>");
    //             break;
    //         }
    //         else
    //         {
    //             listTimeLeft.Add(timeLeft);
    //             lbl_test.Text += currTime.ToString("T") + " | " + chkInTime.ToString() + " | " + timeWaiting.ToString("T") + " | " + double.Parse(triage.ToString(@"hh")) + " | " + timeLeft.TotalHours.ToString() + "<br />";
    //         }           
    //    }

        //lbl_test.Text += listTimeLeft.("timeLeft").ToString("T");

        
    //}

    protected void calcAvgWait(object sender, EventArgs e)
    {
        TimeSpan wt = objLinq.currentWaitTime();
        lbl_wt_time.Text = wt.ToString(@"hh\:mm\:ss");
    }


    //updates patients from 
    protected void subUpdate(object sender, CommandEventArgs e)
    {
        //passes 0 to update patient, 1 to check the patient out
        if (ddl_pat_name.SelectedValue == txt_pat_numU.Text)
        {
            switch (e.CommandName)
            {
                case "CheckIn":
                    _strMessage(objLinq.commitUpdatePatientStatus(int.Parse(txt_pat_numU.Text), 0),"checked in");
                    break;
                case "CheckOut":
                    _strMessage(objLinq.commitUpdatePatientStatus(int.Parse(txt_pat_numU.Text), 1), "checked out");
                break;
            }
        }
        else
        {
            lbl_message.Text = "The Patient Number and Name do not match.  Please check your chart.";
            mpe_message.Show();
        }
    }


    private void _subRebind()
    {
        _panelControl(pnl_admin);
        txt_fname.Text = string.Empty;
        txt_lname.Text = string.Empty;
        txt_pat_num.Text = string.Empty;
        txt_hcard_num.Text = string.Empty;
        dtl_patients.DataSource = objLinq.getActivePatients();
        dtl_patients.DataBind();
        TimeSpan wt = objLinq.currentWaitTime();
        lbl_wt_time.Text = wt.ToString(@"hh\:mm\:ss");
    }

    private void _strMessage(bool flag, string str)
    {
        if (flag)
        {
            lbl_message.Text = "Patient was successfully" + str;
            mpe_message.Show();
        }
        else
        {
            lbl_message.Text = "Error: Patient was not " + str;
            mpe_message.Show();
        }
    }
}