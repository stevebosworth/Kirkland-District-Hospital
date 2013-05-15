using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ppClass_sb
/// </summary>
public class ppClass_sb
{
    kdhDataContext objParkingDC = new kdhDataContext();

    //Get all Permits
    public IQueryable<parking> getAllPermits()
    {
        var allPermits = objParkingDC.parkings.Select(x => x);

        return allPermits;
    }

    //Get all current Permits
    public IQueryable<parking> getCurrentPermits(DateTime _currTime)
    {
        var currentPermits = objParkingDC.parkings.Where(x => x.time_exp > _currTime).Select(x => x);

        return currentPermits;
    }

    //Get Expired Permits
    public IQueryable<parking> getExpiredPermits(DateTime _currTime)
    {
        var expiredPermits = objParkingDC.parkings.Where(x => x.time_exp < _currTime && x.spot.Length > 2).Select(x => x);
        
        return expiredPermits;
    }

    //Get Permit by ID
    public IQueryable<parking> getParkingByID(int _id)
    {
        var parkingID = objParkingDC.parkings.Where(x => x.park_id == _id).Select(x => x);
        return parkingID;
    }

    //Get Permit by ID AND email
    public IQueryable<parking> getParkingByID_Email(int _id, string _email)
    {
        var parkingIDEMail = objParkingDC.parkings.Where(x => x.park_id == _id && x.email == _email);
        return parkingIDEMail;
    }

    //Get Permit by ID and clear spot
    public IQueryable<parking> getParkingByID_UpdSpot(int _id, string _spot)
    {
        var objParkingID = objParkingDC.parkings.Where(x => x.park_id == _id).Select(x => x);
        var objSpot = objParkingDC.pp_spots.Single(x => x.spot == _spot);

        objSpot.occupied2 = 0;
        objParkingDC.SubmitChanges();

        return objParkingID;        
    }

    //Get all spots
    public IQueryable<pp_spot> getSpots()
    {
        var allSpots = objParkingDC.pp_spots.Select(x => x);

        return allSpots;
    }

    //Get parking spots by status
    public IQueryable<pp_spot> getSpotsByStatus(int _occupied)
    {

        var freeSpots = objParkingDC.pp_spots.Where(x => x.occupied2 == _occupied).Select(x => x);

        return freeSpots;
    }

    //Get spot by spot number
    public IQueryable<pp_spot> getSpotBySpot(string _spot)
    {
        var spotBySpot = objParkingDC.pp_spots.Where(x => x.spot == _spot).Select(x => x);
        return spotBySpot;
    }

    //ADD NEW PERMIT
    public bool commitParkingInsert(string _name, string _email, string _plateNum, string _spot, DateTime _timeIn, DateTime _timeExp)
    {
        parking objNewParking = new parking();
        
        using(objParkingDC)
        {

            var objSpots = objParkingDC.pp_spots.Single(x => x.spot == _spot);

            objNewParking.name = _name;
            objNewParking.email = _email;
            objNewParking.plate_num = _plateNum;
            objNewParking.spot = _spot;
            objNewParking.time_in = _timeIn;
            objNewParking.time_exp = _timeExp;

            //update parking spot to occupied in pp_spots table
            objSpots.occupied2 = 1;

            objParkingDC.parkings.InsertOnSubmit(objNewParking);
            objParkingDC.SubmitChanges();

        }
        return true;
    }

    //reset spots with expired permits
    public void resetSpots()
    {
        var expiredSpots = getExpiredPermits(DateTime.Now);

        foreach (var spot in expiredSpots)
        {
            //This clears the spot from expired permits so a spot can be reused for new permits and is not constantly reset.
            if (spot.spot.Length > 0)
            {
                deleteSpotinPermit(spot.park_id);
            }
            var spotSingle = objParkingDC.pp_spots.Single(x => x.spot == spot.spot);
            spotSingle.occupied2 = 0;
        }

        objParkingDC.SubmitChanges();
    }

    //deletes spot value in expired permits to prevent spot from being consistently reset by expired permits on that spot.
    private void deleteSpotinPermit(int _parkID)
    {
        var permit = objParkingDC.parkings.Single(x => x.park_id == _parkID);
        permit.spot = string.Empty;

        objParkingDC.SubmitChanges();
    }

    //Add time to permit
    public bool commitParkingAddTime(int _id, DateTime _timeExp)
    {
        var objParkingAdd = objParkingDC.parkings.Single(x => x.park_id == _id);

        objParkingAdd.time_exp = _timeExp;

        objParkingDC.SubmitChanges();

        return true;
    }

    //Update Permit
    public bool commitParkingUpdate(int _id, string _name, string _email, string _plateNum, string _spot, DateTime _timeIn, DateTime _timeExp)
    {

        using(objParkingDC)
        {
            var objParkingUpdate = objParkingDC.parkings.Single(y => y.park_id == _id);

            var objSpotUpdate = objParkingDC.pp_spots.Single(x => x.spot == _spot);
            
            //object parking permit information
            objParkingUpdate.name = _name;
            objParkingUpdate.email = _email;
            objParkingUpdate.plate_num = _plateNum;
            objParkingUpdate.spot = _spot;
            objParkingUpdate.time_in = _timeIn;
            objParkingUpdate.time_exp = _timeExp;
            
            //update spot
            objSpotUpdate.occupied2 = 1;

            objParkingDC.SubmitChanges();
        }
        return true;
    }


    //Delete a permit and set spot to unoccupied (0)
    public bool commitParkingDelete(int _id, string _spot)
    {
        var objDeleteParking = objParkingDC.parkings.Single(x => x.park_id == _id);
        var objUpdSpot = objParkingDC.pp_spots.Single(x => x.spot == _spot);

        //set spot back to unoccupied
        objUpdSpot.occupied2 = 0;

        objParkingDC.parkings.DeleteOnSubmit(objDeleteParking);
        
        objParkingDC.SubmitChanges();

        return true;
    }


    
}