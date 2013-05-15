using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.IO;
using System.Web.UI;


/// <summary>
/// Summary description for cmsLinqClass_sb
/// </summary>
public class cmsLinqClass_sb
{	
    kdhDataContext objPagesDC = new kdhDataContext();

    //Select all Pages
	public IQueryable<page> getPages()
    {
        kdhDataContext objPagesDC = new kdhDataContext();

        var allPages = objPagesDC.pages.Select(x => x);
        
        return allPages;
    }

    //Select Page by ID
    public IQueryable<page> getPageByID(int _id)
    {
        var pageByID = objPagesDC.pages.Where(x => x.cms_id == _id).Select(x => x);
        return pageByID;
    }

    //Select by public_url
    public IQueryable<page> getPublishedPageByUrl(string _publicUrl)
    {
        var publicPageByUrl = objPagesDC.pages.Where(x => x.public_url == _publicUrl).Select(x => x);
        return publicPageByUrl;
    }

    //ADD NEW PAGE
    public bool commitNewPage(string _title, string _author, string _parent, string _entry, DateTime _dateAdded, DateTime _dateEdited, int _saved, int _published, string _publicUrl)
    {
        page objNewPage = new page();

        using(objPagesDC)
        {
            objNewPage.title = _title;
            objNewPage.author = _author;
            objNewPage.parent = _parent;
            objNewPage.entry = _entry;
            objNewPage.date_added = _dateAdded;
            objNewPage.date_edited = _dateEdited;
            objNewPage.saved = _saved;
            objNewPage.published = _published;
            objNewPage.public_url = _publicUrl;

            objPagesDC.pages.InsertOnSubmit(objNewPage);
            objPagesDC.SubmitChanges();
        }

        return true;
    }

    public bool commitPageUpdate(int _cmsID, string _title, string _author, string _parent, string _entry, DateTime _dateEdited, int _saved, int _published, string _publicUrl)
    {
        using (objPagesDC)
        {
            var objUpdPage = objPagesDC.pages.Single(x => x.cms_id == _cmsID);

            objUpdPage.title = _title;
            objUpdPage.author = _author;
            objUpdPage.parent = _parent;
            objUpdPage.entry = _entry;
            objUpdPage.date_edited = _dateEdited;
            objUpdPage.saved = _saved;
            objUpdPage.published = _published;
            objUpdPage.public_url = _publicUrl;

            objPagesDC.SubmitChanges();
        }
        return true;
    }

    public bool commitPageDelete(int _cmsID, int _published, string _parent, string _title)
    {
        if (_published == 1)
        {
            unPublishPage(_cmsID, _parent, _title);
        }

        //string path = System.Web.HttpContext.Current.Server.MapPath("../web.sitemap");

        //XmlDocument doc = new XmlDocument();

        //doc.Load(path);
        //XmlNode deleteNode = doc.SelectSingleNode("/siteMap/siteMapNode/siteMapNode[@title='" + _parent + "']/siteMapNode[@title='" + _title + "']");
        //deleteNode.RemoveAll();
        //doc.Save(path);
        
        var objDelPage = objPagesDC.pages.Single(x => x.cms_id == _cmsID);

        objPagesDC.pages.DeleteOnSubmit(objDelPage);
        objPagesDC.SubmitChanges();

        return true;
    }

    public bool publishPage(int _cmsID, string _parent, string _title, string _publicUrl)
    {
        string path = System.Web.HttpContext.Current.Server.MapPath("../../web.sitemap");

        XmlDocument doc = new XmlDocument();

        doc.Load(path);
        XmlNode newSiteMapNode = createSiteMapNode(doc, _title, _publicUrl);
        XmlNode parentNode = doc.SelectSingleNode("/siteMap/siteMapNode/siteMapNode[@title='" + _parent + "']");
        if(!parentNode.InnerXml.Contains(newSiteMapNode.ToString()))
            {
            parentNode.AppendChild(newSiteMapNode);
            doc.Save(path);
        
            using (objPagesDC)
            {
                var objUpdPublished = objPagesDC.pages.Single(x => x.cms_id == _cmsID);
                objUpdPublished.published = 1;
                objPagesDC.SubmitChanges();

            }

            return true;
        }
        return false;

    }

    protected XmlNode createSiteMapNode(XmlDocument doc, string _title, string _publicUrl)
    {
        // create new siteMapNode
        XmlNode siteMapNode = doc.CreateElement("siteMapNode");
        XmlAttribute attrUrl = doc.CreateAttribute("url");
        attrUrl.Value = "~/page_sb.aspx?page=" + _publicUrl;
        XmlAttribute attrTitle = doc.CreateAttribute("title");
        attrTitle.Value = _title;
        XmlAttribute attrDesc = doc.CreateAttribute("description");
        attrDesc.Value = _title;
        //append attributes to siteMapNode
        siteMapNode.Attributes.Append(attrUrl);
        siteMapNode.Attributes.Append(attrTitle);
        siteMapNode.Attributes.Append(attrDesc);          

        return siteMapNode;
    }

    public bool unPublishPage(int _cmsID, string _parent, string _title)
    {
        kdhDataContext objPagesDC = new kdhDataContext();

        string path = System.Web.HttpContext.Current.Server.MapPath("../../web.sitemap");

        XmlDocument doc = new XmlDocument();

        doc.Load(path);
        XmlNode deleteNode = doc.SelectSingleNode("/siteMap/siteMapNode/siteMapNode[@title='" + _parent + "']/siteMapNode[@title='" + _title + "']");
        deleteNode.RemoveAll();
        doc.Save(path);

        using (objPagesDC)
        {
            var objUpdPublished = objPagesDC.pages.Single(x => x.cms_id == _cmsID);
            objUpdPublished.published = 0;
            objPagesDC.SubmitChanges();
        }
        return true;
    }

    
}