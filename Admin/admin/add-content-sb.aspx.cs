using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    cmsLinqClass_sb objLinq = new cmsLinqClass_sb();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            _subRebind();
            _panelControl(pnl_add_page);
        }
    }

    //protected void subSaveNewPage(object sender, EventArgs e)
    //{
    //    if (Page.IsValid)
    //    {
    //        _strMessage(objLinq.commitNewPage(txt_title.Text, lbl_author.Text, ddl_parent.SelectedValue.ToString(), txt_content.Text, DateTime.Now, DateTime.Now, 1, 0, string.Empty), "Saved");
    //        _subRebind();
    //    }
    //}

    //protected void subPublishNewPage(object sender, EventArgs e)
    //{
    //    if (Page.IsValid)
    //    {
    //        _strMessage(objLinq.commitNewPage(txt_title.Text, lbl_author.Text, ddl_parent.SelectedValue.ToString(), txt_content.Text, DateTime.Now, DateTime.Now, 1, 1, txt_url.Text), "Published");
    //        objLinq.publishPage(ddl_parent.SelectedValue.ToString(), txt_title.Text, txt_url.Text);
    //    }
    //}

    protected void subEntryAdmin(object sender, CommandEventArgs e)
    {
        switch (e.CommandName)
        {
            //case "PublishNew":
            //    if (Page.IsValid)
            //    {
            //        _strMessage(objLinq.commitNewPage(txt_title.Text, lbl_author.Text, ddl_parent.SelectedValue.ToString(), txt_content.Text, DateTime.Now, DateTime.Now, 1, 1, txt_url.Text), "Published");
            //        objLinq.publishPage(ddl_parent.SelectedValue.ToString(), txt_title.Text, txt_url.Text);
            //    }
            //break;
            case "SaveNew":
                if (Page.IsValid)
                {
                    _strMessage(objLinq.commitNewPage(txt_title.Text, lgn_author.ToString(), ddl_parent.SelectedValue.ToString(), txt_content.Text, DateTime.Now, DateTime.Now, 1, 0, string.Empty), "Saved");
                    //add if published then publish
                    _subRebind();
                }
            break;
            //case "UnPublish":
            //    if (int.Parse(hdf_cms_id.Value) > 0)
            //    {
            //        _strMessage(objLinq.unPublishPage(int.Parse(hdf_cms_id.Value.ToString()), ddl_parent.SelectedValue.ToString(), txt_title.Text), "unpublished");
            //    }
            //    else
            //    {
            //        lbl_message.Text = "Page is not Saved.  You must save the Page first.";
            //    }
            //break;
            case "UpdatePage":
                if (int.Parse(hdf_cms_id.Value) > 0)
                {
                    //update page in DB
                    _strMessage(objLinq.commitPageUpdate(int.Parse(hdf_cms_id.Value), txt_title.Text, lgn_author.ToString(), ddl_parent.SelectedValue.ToString(), txt_content.Text, DateTime.Now, 1, Convert.ToInt32(ckb_publish.Checked), txt_url.Text), "Updated");
                    //check to see if initial published value and value from form match.
                    if (Convert.ToInt32(ckb_publish.Checked) == int.Parse(hdf_published.Value))
                    {
                        //Publish or Unpublish based on form checkbox
                        switch (Convert.ToInt32(ckb_publish.Checked))
                        {
                            case 1:
                                objLinq.publishPage(int.Parse(hdf_cms_id.Value), ddl_parent.SelectedValue.ToString(), txt_title.Text, txt_url.Text);
                            break;
                            case 0:
                                objLinq.unPublishPage(int.Parse(hdf_cms_id.Value), txt_title.Text, txt_url.Text);
                            break;
                        }

                    }
                    //Go back to Manage Pages
                    _panelControl(pnl_manage_page);
                }
                else
                {
                    lbl_message.Text = "Page is not Saved.  You must save the Page before you can update it.";
                    mpe_message.Show();
                }
                
            break;
            case "Delete":
                if (int.Parse(hdf_cms_id.Value) > 0)
                {
                    _strMessage(objLinq.commitPageDelete(int.Parse(hdf_cms_id.Value.ToString()), int.Parse(ckb_publish.Checked.ToString()), ddl_parent.SelectedValue.ToString(), txt_title.Text), "deleted");
                }
                else
                {
                    lbl_message.Text = "Page is not Saved.  You must save the Page before you can delete it.";
                    mpe_message.Show();
                }
            break;
            case "Cancel":
                _subRebind();
            break;

        }
    }

    //Manage Page Panel Functions
    protected void subPageAdmin(object sender, DataListCommandEventArgs e)
    {        
        HiddenField hdfID = (HiddenField)e.Item.FindControl("hdf_id");
        Label lblPub = (Label)e.Item.FindControl("lbl_published"); 
        Label lblTitle = (Label)e.Item.FindControl("lbl_title");
        Label lblParent =  (Label)e.Item.FindControl("lbl_parent");
        Label lblUrl = (Label)e.Item.FindControl("lbl_url");

        switch (e.CommandName)
        {
            case "UnPublish":
                _strMessage(objLinq.unPublishPage(int.Parse(hdfID.Value.ToString()), lblParent.Text, lblTitle.Text), "unpublished");
                _subRebind();
                _panelControl(pnl_manage_page);
            break;
            case "Publish":
                _strMessage(objLinq.publishPage(int.Parse(hdfID.Value.ToString()), lblParent.Text, lblTitle.Text, lblUrl.Text), "published");
                _subRebind();
                _panelControl(pnl_manage_page);
            break;
            case "Delete":
                _strMessage(objLinq.commitPageDelete(int.Parse(hdfID.Value.ToString()), int.Parse(lblPub.Text), lblParent.Text, lblTitle.Text), "deleted");
                _subRebind();
                _panelControl(pnl_manage_page);
            break;
            case "Edit":
               var cmsPage = objLinq.getPageByID(int.Parse(hdfID.Value.ToString()));

               foreach (var cms in cmsPage)
               {
                   hdf_cms_id.Value = cms.cms_id.ToString();
                   hdf_published.Value = cms.published.ToString();
                   ddl_parent.SelectedValue = cms.parent.ToString();
                   txt_content.Text = cms.entry.ToString();
                   txt_title.Text = cms.title.ToString();
                   txt_url.Text = cms.public_url.ToString();
                   ckb_publish.Checked = Convert.ToBoolean(cms.published);
                   btn_save.Text = "Update";
                   btn_save.CommandName = "UpdatePage";
                   _panelControl(pnl_add_page);

               }
                
            break;
        }
    }

    private void _subRebind()
    {
        txt_title.Text = string.Empty;
        txt_content.Text = string.Empty;
        txt_url.Text = string.Empty;
        ddl_parent.SelectedIndex = 0;
        dtl_pages.DataSource = objLinq.getPages();
        dtl_pages.DataBind();
    }


    //Display either a publish or unpublish button depending on item's state 
    protected void subBinding(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            Label lblPublished = e.Item.FindControl("lbl_published") as Label;
            LinkButton lbkPublish = e.Item.FindControl("lkb_publish") as LinkButton;

            switch (lblPublished.Text)
            {
                case "1":
                    lbkPublish.Text = "Unpublish";
                    lbkPublish.CommandName = "UnPublish";
                    break;
                case "0":
                    lbkPublish.Text = "Publish";
                    lbkPublish.CommandName = "Publish";
                    break;
            }
        }

        //foreach (DataListItem item in dtl_pages.Items)
        //{
        //    Label lblPublished = item.FindControl("lbl_published") as Label;
        //    LinkButton lbkPublish = item.FindControl("lkb_publish") as LinkButton;

        //    switch (lblPublished.Text)
        //    {
        //        case "1":
        //            lbkPublish.Text = "Unpublish";
        //            lbkPublish.CommandName = "UnPublish";
        //        break;
        //        case "0":
        //            lbkPublish.Text = "Publish";
        //            lbkPublish.CommandName = "Publish";
        //        break;
        //    }
        //}
    }

    protected void _strMessage(bool flag, string str)
    {
        if (flag)
        {
            lbl_message.Text = "Page was successfully " + str;
            mpe_message.Show();
        }
        else
        {
            lbl_message.Text = "Error: Page was not " + str;
            mpe_message.Show();
        }
    }

    protected void subMenuClick(object sender, MenuEventArgs e)
    {
        int index = Int32.Parse(e.Item.Value);

        if (index == 0)
        {
            _panelControl(pnl_add_page);
        }
        else
        {
            _panelControl(pnl_manage_page);
        }
    }

    private void _panelControl(Panel _pnl)
    {
        pnl_add_page.Visible = false;
        pnl_manage_page.Visible = false;
        _pnl.Visible = true;
    }
}