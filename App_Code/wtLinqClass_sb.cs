using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LinqClass_sb
/// </summary>
public class wtLinqClass_sb
{
    //kdhDataContext objPatientsDC = new kdhDataContext();    

    //SELECT ALL PATIENTS
    public IQueryable<wt_patient> getPatients()
    {
        kdhDataContext objPatientsDC = new kdhDataContext();  
        var allPatients = objPatientsDC.wt_patients.OrderByDescending(x => x.chk_in).Select(x => x);

        return allPatients;
    }

    public IQueryable<wt_patient> getPatientByID(int _id)
    {
        kdhDataContext objPatientsDC = new kdhDataContext();  

        var patientID = objPatientsDC.wt_patients.Where(x => x.pat_id == _id).Select(x => x);
        return patientID;
    }


    //all patients that have not been updated or checked out
    public IQueryable<wt_patient> getActivePatients()
    {
        kdhDataContext objPatientsDC = new kdhDataContext();

        var currPatients = objPatientsDC.wt_patients.Where(x => x.chk_upd == null || x.chk_out == null).Select(x => x).OrderByDescending(x => x.chk_in);

        return currPatients;
    }

    //INSERT NEW PATIENT
    public bool commitPatientInsert(string _fname, string _lname, int _pat_num, int _hcard, int _triage_id, DateTime _chk_in)
    {
        kdhDataContext objPatientsDC = new kdhDataContext();

        try
        {

            using (objPatientsDC)
            {
                wt_patient objNewPatient = new wt_patient();

                //DateTime chkIn = DateTime.Parse(_chk_in);

                objNewPatient.fname = _fname;
                objNewPatient.lname = _lname;
                objNewPatient.pat_num = _pat_num;
                objNewPatient.hcard = _hcard;
                objNewPatient.triage_id = _triage_id;
                objNewPatient.chk_in = _chk_in;
                //insert command
                objPatientsDC.wt_patients.InsertOnSubmit(objNewPatient);
                objPatientsDC.SubmitChanges();
                return true;
            }
        }
        catch (Exception)
        {
            return false;
        }

    }


    public bool commitPatientUpdate(int _id, string _fname, string _lname, int _pat_num, int _hcard, int _triage_id)
    {
        kdhDataContext objPatientsDC = new kdhDataContext();  
   
        using (objPatientsDC)
        {
            var objUpdatePatient = objPatientsDC.wt_patients.Single(y => y.pat_id == _id);

            objUpdatePatient.fname = _fname;
            objUpdatePatient.lname = _lname;
            objUpdatePatient.pat_num = _pat_num;
            objUpdatePatient.hcard = _hcard;
            objUpdatePatient.triage_id = _triage_id;

            objPatientsDC.SubmitChanges();

            return true;
        }
    }

    //DELETE PATIENT
    public bool commitDeletePatient(int _id)
    {
        kdhDataContext objPatientsDC = new kdhDataContext();  

        var objDeletePatient = objPatientsDC.wt_patients.Single(x => x.pat_id == _id);

        objPatientsDC.wt_patients.DeleteOnSubmit(objDeletePatient);
        objPatientsDC.SubmitChanges();

        return true;
    }

    //Update patient's status depending on which fields have been set in the Database.
    public bool commitUpdatePatientStatus(int _patNum, int _status)
    {
        kdhDataContext objPatientsDC = new kdhDataContext();

        var patient = objPatientsDC.wt_patients.Single(x => x.pat_num == _patNum);

        if (_status == 0)
        {
            patient.chk_upd = DateTime.Now;
        }
        else
        {
            patient.chk_out = DateTime.Now;
        }

        objPatientsDC.SubmitChanges();

        return true;
    }

    public TimeSpan currentWaitTime()
    {
        kdhDataContext objPatientsDC = new kdhDataContext();

        try
        {
            //get a set of the current patients(as IQueryable)
            var currentPatients = objPatientsDC.wt_patients.Where(x => !x.chk_upd.HasValue).Select(x => x);


            var currentTime = DateTime.Now;

            List<TimeSpan> remainingTimes = new List<TimeSpan>();

            foreach (var patient in currentPatients)
            {
                TimeSpan expectedWait = TimeSpan.ParseExact("0" + patient.triage_id.ToString(), "hh", null);
                DateTime chkIn = DateTime.Parse(patient.chk_in.ToString());
                //amount of time a patient has been waiting
                TimeSpan timeWaiting = currentTime - chkIn;
                //subtract timeWaiting from their expected waitTime(based on triage level) to get remaining waitTime
                TimeSpan remainingTime = timeWaiting - expectedWait;
                //add remaingTime to an array of times
                remainingTimes.Add(remainingTime);
            }

            long averageWaitTime = Convert.ToInt64(remainingTimes.Average(timeSpan => timeSpan.Ticks));
        
            TimeSpan currWT = TimeSpan.FromTicks(averageWaitTime);

        
            return currWT;
        }
        catch(Exception)
        {
            TimeSpan noWait = TimeSpan.Parse("0");
            return noWait;
        }
    }
}