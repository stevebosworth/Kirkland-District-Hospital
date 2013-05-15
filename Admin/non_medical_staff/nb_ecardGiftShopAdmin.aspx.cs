using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Admin_nb_ecardGiftShopAdmin : System.Web.UI.Page
{
    //creating an instance of the LINQ class for ecards and gift shop
    ecardLinq objLinqEcard = new ecardLinq();
    giftShopLinq objLinqGiftShop = new giftShopLinq();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            _subRebindEcards();
            _subRebindGiftShop();
        }
    }

    //gift Shop rebind data
    private void _subRebindGiftShop()
    {

        txt_nameI.Text = string.Empty;
        txt_descI.Text = string.Empty;
        ddl_categoryI.Text=string.Empty;
        txt_priceI.Text = string.Empty;
        hdf_GimageUrlI.Value = string.Empty;
        grd_gift.DataSource = objLinqGiftShop.getnb_giftShops();
        grd_gift.DataBind();
        
    }

    //eCards rebind data
    private void _subRebindEcards()
    {

        txt_nameII.Text = string.Empty;
        txt_descII.Text = string.Empty;
        ddl_categoryII.Text = string.Empty;
        txt_msgII.Text = string.Empty;
        hdf_EimageUrlI.Value = string.Empty;
        grd_ecard.DataSource = objLinqEcard.getnb_ecardsShops();
        grd_ecard.DataBind();
        
    }



    protected void subInsertII(object sender, EventArgs e)
    {
        //code to upload ecards image and insert data
        if (fu_EimageUploadI.HasFile)
        {
            try
            {
                if (fu_EimageUploadI.PostedFile.ContentType == "image/jpeg")
                {
                    if (fu_EimageUploadI.PostedFile.ContentLength < 102400)
                    {
                        string filename = Path.GetFileName(fu_EimageUploadI.FileName);
                        fu_EimageUploadI.SaveAs(Server.MapPath("~/") + "/images/EcardGiftShop/" + filename);

                        //assign value of the path to hidden field
                        hdf_EimageUrlI.Value = "images/EcardGiftShop/" + filename.ToString();

                        //code to insert data into the database
                        _strMessage1(objLinqEcard.commitInsert(txt_nameII.Text, txt_descII.Text, ddl_categoryII.Text, txt_msgII.Text, hdf_EimageUrlI.Value.ToString()), "insert");
                        //rebind data
                        _subRebindEcards();
                    }
                    else
                    {
                        //failed validation
                        cmv_EimageUploadI.IsValid = false;
                    }
                }

                else
                {
                    //failed validation
                    cmv_EimageUploadI.IsValid = false;
                }
            }
            catch (Exception)
            {
                //failed validation
                cmv_EimageUploadI.IsValid = false;
            }
        }
    }

    //message to let the user know that the data was successfully deleted, added or updated
    private void _strMessage1(bool flag, string str)
    {
        if (flag)
        {
            lbl_messageB.Text = "Data " + str + " was successful";
        }
        else
        {
            lbl_messageB.Text = "Sorry, unable to " + str + "Data";
        }
    }

    //gridview page index changing
    protected void grd_ecard_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        grd_ecard.PageIndex = e.NewPageIndex; 

        _subRebindEcards();

    }

    //gridview row cancel edit
    protected void grd_ecard_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

        grd_ecard.EditIndex = -1; 

        _subRebindEcards();

    }

    //gridview row deleting
    protected void grd_ecard_RowDeleting(object sender, GridViewDeleteEventArgs e)
    { 
        HiddenField hdfIDD = (HiddenField)(grd_ecard.Rows[e.RowIndex].FindControl("hdf_idD"));

        int _id = int.Parse(hdfIDD.Value.ToString());
        _strMessage1(objLinqEcard.commitDelete(_id), "delete");
        _subRebindEcards();

    }


    //gridview row editing
    protected void grd_ecard_RowEditing(object sender, GridViewEditEventArgs e)
    {

        grd_ecard.EditIndex = e.NewEditIndex;
        _subRebindEcards();

    }


    //code to update data
    protected void grd_ecard_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

        HiddenField hdfIDUU = (HiddenField)(grd_ecard.Rows[e.RowIndex].FindControl("hdf_idUU"));
        TextBox txtNameUU = (TextBox)(grd_ecard.Rows[e.RowIndex].FindControl("txt_nameEE"));
        TextBox txtDescriptionUU = (TextBox)(grd_ecard.Rows[e.RowIndex].FindControl("txt_descEE"));
        DropDownList ddlCategoryUU = (DropDownList)(grd_ecard.Rows[e.RowIndex].FindControl("ddl_categoryEE"));
        TextBox txtMsgUU = (TextBox)(grd_ecard.Rows[e.RowIndex].FindControl("txt_msgEE"));
        FileUpload imageEUploaderU = (FileUpload)(grd_ecard.Rows[e.RowIndex].FindControl("fu_EimageUploadU"));
        HiddenField imageEurlU = (HiddenField)(grd_ecard.Rows[e.RowIndex].FindControl("hdf_EimageGUrlU"));
        CustomValidator cmv_imageEUploaderU = (CustomValidator)(grd_ecard.Rows[e.RowIndex].FindControl("cmv_EimageUploadU"));

        int proID = int.Parse(hdfIDUU.Value.ToString());


        //code to upload Gift  image
        if (imageEUploaderU.HasFile)
        {
            try
            {
                if (imageEUploaderU.PostedFile.ContentType == "image/jpeg")
                {
                    if (imageEUploaderU.PostedFile.ContentLength < 102400)
                    {
                        string filename = Path.GetFileName(imageEUploaderU.FileName);
                        imageEUploaderU.SaveAs(Server.MapPath("~/") + "/images/EcardGiftShop/" + filename);

                        //assign value of the path to hidden field
                        imageEurlU.Value = "images/EcardGiftShop/" + filename.ToString();

                        //code to update edited data into the database
                        _strMessage1(objLinqEcard.commitUpdate(proID, txtNameUU.Text, txtDescriptionUU.Text, ddlCategoryUU.Text, txtMsgUU.Text, imageEurlU.Value.ToString()), "Update");

                        grd_ecard.EditIndex = -1;

                        //rebind
                        _subRebindEcards();
                    }
                    else
                    {
                        //failed validation
                        cmv_imageEUploaderU.IsValid = false;

                    }
                }

                else
                {
                    //failed validation
                    cmv_imageEUploaderU.IsValid = false;
                }
            }
            catch (Exception)
            {
                //failed validation
                cmv_imageEUploaderU.IsValid = false;
            }
        }

    }




    //----------------code for Gift Shop---------------///////////






    protected void subInsert(object sender, EventArgs e)
    {
      
        //code to upload gift image
        if (fu_GimageUploadI.HasFile)
        {
            try
            {
                if (fu_GimageUploadI.PostedFile.ContentType == "image/jpeg")
                {
                    if (fu_GimageUploadI.PostedFile.ContentLength < 102400)
                    {
                        string filename = Path.GetFileName(fu_GimageUploadI.FileName);
                        fu_GimageUploadI.SaveAs(Server.MapPath("~/") + "/images/EcardGiftShop/" + filename);

                        //assign value of the path to hidden field
                        hdf_GimageUrlI.Value = "images/EcardGiftShop/" + filename.ToString();

                        //code to insert data into the database
                        _strMessage(objLinqGiftShop.commitInsert(txt_nameI.Text, txt_descI.Text, ddl_categoryI.Text, txt_priceI.Text, hdf_GimageUrlI.Value.ToString()), "insert");
                        //rebind data
                        _subRebindGiftShop();
                    }
                    else
                    {
                        //failed validation
                        cmv_GimageUploadI.IsValid = false;
                    }
                }

                else
                {
                    //failed validation
                    cmv_GimageUploadI.IsValid = false;
                }
            }
            catch (Exception)
            {
                //failed validation
                cmv_GimageUploadI.IsValid = false;
            }
        }

     
    }

    //message letting the user know that the update, delet or insert was successful
    private void _strMessage(bool flag, string str)
    {
        if (flag)
        {
            lbl_message.Text = "Data " + str + " was successful";
        }
        else
        {
            lbl_message.Text = "Sorry, unable to " + str + "Data";
        }
    }

    //page index changing
    protected void grd_gift_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        grd_gift.PageIndex = e.NewPageIndex; 

        _subRebindGiftShop();

    }

    //row canceling edit
    protected void grd_gift_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

        grd_gift.EditIndex = -1; 

        _subRebindGiftShop();

    }

    //row deleting 
    protected void grd_gift_RowDeleting(object sender, GridViewDeleteEventArgs e)
    { 
        HiddenField hdfIDD = (HiddenField)(grd_gift.Rows[e.RowIndex].FindControl("hdf_idD"));

        int _id = int.Parse(hdfIDD.Value.ToString());
        _strMessage(objLinqGiftShop.commitDelete(_id), "delete");
        _subRebindGiftShop();

    }


    //row editing
    protected void grd_gift_RowEditing(object sender, GridViewEditEventArgs e)
    {

        grd_gift.EditIndex = e.NewEditIndex;
        _subRebindGiftShop();

    }

    protected void grd_gift_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

        HiddenField hdfIDU = (HiddenField)(grd_gift.Rows[e.RowIndex].FindControl("hdf_idEU"));
        TextBox txtNameU = (TextBox)(grd_gift.Rows[e.RowIndex].FindControl("txt_nameE"));
        TextBox txtDescriptionU = (TextBox)(grd_gift.Rows[e.RowIndex].FindControl("txt_descE"));
        DropDownList ddlCategoryU = (DropDownList)(grd_gift.Rows[e.RowIndex].FindControl("ddl_categoryE"));
        TextBox txtPriceU = (TextBox)(grd_gift.Rows[e.RowIndex].FindControl("txt_priceE"));
        FileUpload imageGUploaderU = (FileUpload)(grd_gift.Rows[e.RowIndex].FindControl("fu_GimageUploadU"));
        HiddenField imageGurlU = (HiddenField)(grd_gift.Rows[e.RowIndex].FindControl("hdf_GimageGUrlU"));
        CustomValidator cmv_imageGUploaderU = (CustomValidator)(grd_gift.Rows[e.RowIndex].FindControl("cmv_GimageUploadU"));
        int proID = int.Parse(hdfIDU.Value.ToString());


        //code to upload Gift  image
        if (imageGUploaderU.HasFile)
        {
            try
            {
                if (imageGUploaderU.PostedFile.ContentType == "image/jpeg")
                {
                    if (imageGUploaderU.PostedFile.ContentLength < 102400)
                    {
                        string filename = Path.GetFileName(imageGUploaderU.FileName);
                        imageGUploaderU.SaveAs(Server.MapPath("~/") + "/images/EcardGiftShop/" + filename);

                        //assign value of the path to hidden field
                        imageGurlU.Value = "images/EcardGiftShop/" + filename.ToString();

                        //code to update edited data into the database
                        _strMessage(objLinqGiftShop.commitUpdate(proID, txtNameU.Text, txtDescriptionU.Text, ddlCategoryU.Text, txtPriceU.Text, imageGurlU.Value.ToString()), "Update");

                        grd_gift.EditIndex = -1;

                        //rebind
                        _subRebindGiftShop();
                    }
                    else
                    {
                        //failed validation
                        cmv_imageGUploaderU.IsValid = false;

                    }
                }

                else
                {
                    //failed validation
                    cmv_imageGUploaderU.IsValid = false;
                }
            }
            catch (Exception)
            {
                //failed validation
                cmv_imageGUploaderU.IsValid = false;
            }
        }


    }
}