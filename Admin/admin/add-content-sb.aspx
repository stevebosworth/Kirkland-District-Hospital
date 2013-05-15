<%@ Page Title="" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="add-content-sb.aspx.cs" Inherits="_Default" Theme="Theme1" %>   

<asp:Content ID="con_head" ContentPlaceHolderID="cph_head" Runat="Server">

</asp:Content>
<asp:Content ID="con_content" ContentPlaceHolderID="cph_content" Runat="Server">
   <div class="sb"> 
    <div id="menu_content">
        <asp:Menu ID="mnu_content" runat="server" Orientation="Horizontal" StaticMenuItemStyle-CssClass="tab" StaticSelectedStyle-CssClass="selected" CssClass="tabs" OnMenuItemClick="subMenuClick" >
            <Items>
                <asp:MenuItem Text="Add Page" Value="0" Selected="true" />
                <asp:MenuItem Text="Manage Pages" Value="1"/>
            </Items>
        </asp:Menu>
    </div> <%--/menu_content--%>
    
    <div id="main">
        <asp:Panel ID="pnl_add_page" runat="server">
            <div id="status">
                <asp:Label ID="lbl_published" runat="server" />
                <asp:Label ID="lbl_date_published" runat="server" />
                <asp:Label ID="lbl_date_updated" runat="server" />
                <asp:Label ID="lbl_saved" runat="server" />
            </div>
            <asp:Button ID="btn_new_page" runat="server" Text="New Page" CommandName="Cancel" OnCommand="subEntryAdmin" OnClientClick="You will lose any unsaved work forever.  Are you sure?" />
            <asp:HiddenField ID="hdf_cms_id" runat="server" />
            <asp:HiddenField ID="hdf_published" runat="server" />
            <asp:HiddenField ID="hdf_saved" runat="server" />
            <h3>Title:</h3>
            <asp:TextBox ID="txt_title" runat="server" Columns="100" />
            <asp:RequiredFieldValidator ID="rfv_title" runat="server" ControlToValidate="txt_title" ErrorMessage="You must enter a title" Display="None" ValidationGroup="cms" />
            <h3>Author:</h3>
            <asp:LoginName ID="lgn_author" runat="server" />
            <h3>Parent:</h3>
            <asp:SiteMapDataSource ID="sds_nav" runat="server" ShowStartingNode="false" />
            <asp:DropDownList ID="ddl_parent" runat="server" DataSourceID="sds_nav" DataTextField="title"></asp:DropDownList>
            <h3>Content: </h3>
            <AJAX:ToolkitScriptManager ID="tsm_main" runat="server" />
            <AJAX:HtmlEditorExtender runat="server" ID="hee_content" EnableSanitization="false" TargetControlID="txt_content" >
                <Toolbar>
                        <AJAX:FontNameSelector />
                        <AJAX:FontSizeSelector />
                    <AJAX:HorizontalSeparator />
                        <AJAX:Bold />
                        <AJAX:Italic />
                        <AJAX:Underline />
                    <AJAX:HorizontalSeparator />
                        <AJAX:JustifyLeft />
                        <AJAX:JustifyRight />
                        <AJAX:JustifyCenter />
                        <AJAX:JustifyFull />
                    <AJAX:HorizontalSeparator />
                        <AJAX:InsertHorizontalRule />
                    <AJAX:HorizontalSeparator />
                        <AJAX:Indent />
                        <AJAX:InsertUnorderedList />
                        <AJAX:InsertOrderedList />
                    <AJAX:HorizontalSeparator />
                        <AJAX:Copy />
                        <AJAX:Cut />
                        <AJAX:Paste />
                    <AJAX:HorizontalSeparator />
                        <AJAX:CreateLink />
                        <AJAX:UnLink />
                </Toolbar>
            </AJAX:HtmlEditorExtender>
            <asp:TextBox ID="txt_content" runat="server" TextMode="Multiline" Columns="100" Rows="25" />
            <%--VALIDATION--%>
            <asp:RequiredFieldValidator ID="rfv_content" runat="server" ControlToValidate="txt_content" ErrorMessage="You must enter content." Display="None" ValidationGroup="cms" /> 
        
            <h3>Public Url:</h3>
            <h5>Will take the form of: www.kdh.com/page.aspx?<em>yourUrlHere</em></h5>
            <asp:TextBox ID="txt_url" runat="server" />
            <%--VALIDATION--%>
            <asp:RequiredFieldValidator ID="rfv_url" runat="server" ControlToValidate="txt_url" ValidationGroup="cms" Display="None" />
            <asp:RegularExpressionValidator ID="rev_url" runat="server" ControlToValidate="txt_url" ValidationExpression="^[a-zA-Z0-9]+$" ValidationGroup="cms" Display="None" ErrorMessage="Your url cannot contain spaces or punctuation.  Try something like 'sampleUrl' or 'anotherExample'." />
            <asp:ValidationSummary ID="vds_cms" runat="server" DisplayMode="List" ShowMessageBox="true" ValidationGroup="cms" />
            <asp:CheckBox ID="ckb_publish" runat="server" Text="Publish" />
            <div id="controls">
                <asp:Button ID="btn_save" runat="server" Text="Save" CommandName="SaveNew" OnCommand="subEntryAdmin" CausesValidation="true" ValidationGroup="cms" />
                <%--<asp:Button ID="btn_publish" runat="server" Text="Publish" CommandName="PublishNew" OnCommand="subEntryAdmin" CausesValidation="true" ValidationGroup="cms" />--%>
                <%--<asp:Button ID="btn_unpublish" runat="server" Text="Unpublish" CommandName="UnPublish" OnCommand="subEntryAdmin" />--%>
                <asp:Button ID="btn_delete" runat="server" Text="Delete" CommandName="Delete" OnCommand="subEntryAdmin" />
                <asp:Button ID="btn_cancel" runat="server" Text="Cancel" CommandName="Cancel" OnCommand="subEntryAdmin" />
            </div>
        </asp:Panel>
    </div>
    <asp:Panel ID="pnl_manage_page" runat="server">
        <asp:DataList ID="dtl_pages" runat="server" OnItemDataBound="subBinding" CssClass="dtl_pages" OnItemCommand="subPageAdmin">   
                    <HeaderTemplate>
                                <th>Title: </th>
                                <th>Author: </th>
                                <th>Parent: </th>
                                <th>Url: </th>
                                <th>Date Added: </th>
                                <th>Last Edited: </th>
                                <th>Published: </th>
                                <th>Edit: </th>
                                <th>Delete: </th>
                                <th>Unpublish: </th>
                    </HeaderTemplate>                         
                    <ItemTemplate>
                                <td><asp:HiddenField ID="hdf_id" runat="server" Value='<%#Eval("cms_id") %>' />
                                    <asp:Label ID="lbl_title" runat="server" Text='<%#Eval("title") %>' /> 
                                </td>
                                <td><asp:Label ID="lbl_author" runat="server" Text='<%#Eval("author") %>' /></td>
                                <td><asp:Label ID="lbl_parent" runat="server" Text='<%#Eval("parent") %>' /></td>
                                <td><asp:Label ID="lbl_url" runat="server" Text='<%#Eval("public_url") %>' /></td>
                                <td><asp:Label ID="lbl_added" runat="server" Text='<%#Eval("date_added") %>' /></td>
                                <td><asp:Label ID="lbl_edited" runat="server" Text='<%#Eval("date_edited") %>' /></td>
                                <td><asp:Label ID="lbl_published" runat="server" Text='<%#Eval("published") %>' /></td>
                                <td><asp:LinkButton id="lkb_edit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%#Eval("cms_id") %>' /></td>
                                <td><asp:LinkButton ID="lkb_delete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%#Eval("cms_id") %>' OnClientClick="confirm('Are you sure');" /></td>
                                <td><asp:LinkButton ID="lkb_publish" runat="server" Text="" CommandName="" CommandArgument='<%#Eval("cms_id") %>' OnClientClick="confirm('Are you sure');" /></td>
                    </ItemTemplate>
                </asp:DataList>
    </asp:Panel>
   
    <%--MESSAGE MODAL PANEL--%>
        <AJAX:ModalPopupExtender ID="mpe_message" runat="server" TargetControlID="btn_show_popup" PopupControlID="pnl_message" BackgroundCssClass="modal_bg" OkControlID="btn_ok" />
        <asp:Panel ID="pnl_message" runat="server" CssClass="modal_pnl">
            <asp:Label ID="lbl_message" runat="server" />
            <asp:Button ID="btn_ok" runat="server" Text="OK" />
        </asp:Panel>
    <%--MODAL POP-UP HIDDEN BUTTON--%>
    <asp:Button ID="btn_show_popup" runat="server" style="display:none;" />

</div>
</asp:Content>

