<%@ Page Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="nb_ecardGiftShopAdmin.aspx.cs"  Theme="Theme1" Inherits="Admin_nb_ecardGiftShopAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_head" Runat="Server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="cph_content" Runat="Server">

    <%--Ajax toolkitscript manager--%>
    <AJAX:ToolkitScriptManager ID="tsm_ecardGiftShop" runat="server" />

    <AJAX:TabContainer ID="tab_options" runat="server">
  <%--Code for Gift card controls--%>
        <AJAX:TabPanel ID="tp_giftShop" runat="server" >
            <HeaderTemplate>
                Gift Shop Admin
            </HeaderTemplate>

          <ContentTemplate>
              <h1>Gift Shop Admin</h1>
                 <%--message--%>
    <asp:Label ID="lbl_message" runat="server" /><br /><br />

<asp:Panel ID="Panel1" runat="server" ScrollBars="Both">
 <%--code for insert controls--%>
<table class="style1">

    <tr>
        <td ></td>
        <td><asp:Label ID="lbl_idI" runat="server" Text='<%# Eval("id") %>'></asp:Label></td>
    </tr>
    <tr>
        <td >Name</td>
        <td><asp:TextBox ID="txt_nameI" runat="server"></asp:TextBox></td>
        <td><asp:RequiredFieldValidator ID="rfv_nameI" runat="server" Text="*Required" ControlToValidate="txt_nameI" ValidationGroup="insert1" /></td>
    </tr>
    <tr>
        <td >Description</td>
        <td><asp:TextBox ID="txt_descI" runat="server" Height="22px" ></asp:TextBox></td>
        <td><asp:RequiredFieldValidator ID="rfv_descI" runat="server" Text="*Required" ControlToValidate="txt_descI" ValidationGroup="insert1" /></td>
    </tr>
    <tr>
        <td >Category</td>
        <td>
            <asp:DropDownList ID="ddl_categoryI" runat="server">
                <asp:ListItem>All</asp:ListItem>
                <asp:ListItem>Get Well Soon</asp:ListItem>
                <asp:ListItem>Congratualations</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Text="*Required" ControlToValidate="ddl_categoryI" ValidationGroup="insert1" /></td>

    </tr>
    <tr>
        <td >Price</td>
        <td><asp:TextBox ID="txt_priceI" runat="server"></asp:TextBox></td>
        <td><asp:RequiredFieldValidator ID="rfv_priceI" runat="server" Text="*Required" ControlToValidate="txt_priceI" ValidationGroup="insert1" /></td>
        <td><asp:CompareValidator ID="cmv_priceI" runat="server" Text="*Not a number" ControlToValidate="txt_priceI" Operator="DataTypeCheck" Type="Currency" ValidationGroup="insert1" Display="Dynamic" /></td>
    </tr>
    
    <tr>
        <td >Image Url</td>
         <td ><asp:FileUpload id="fu_GimageUploadI" runat="server" /></td>
        <td>
            <asp:RequiredFieldValidator ID="rfv_GimageUploadI" runat="server" Text="*Required" ControlToValidate="fu_GimageUploadI" ValidationGroup="insert1" />
            <asp:CustomValidator ID="cmv_GimageUploadI" runat="server" ControlToValidate="fu_GimageUploadI" ErrorMessage="File must be in JPEG format and must not exceed 100kb in size" ForeColor="Red" ValidateEmptyText="True" ValidationGroup="insert1" />
        </td>
        <asp:HiddenField ID="hdf_GimageUrlI" runat="server" />
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><asp:Button ID="btn_insert" runat="server" Height="26px"  Text="Insert" Width="89px" onclick="subInsert" ValidationGroup="insert1" /></td>
    </tr>
    <tr>
        <td >&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">



            <%--gridview control for gift Shop--%>
    <asp:GridView ID="grd_gift" runat="server" AutoGenerateColumns="False" CellPadding="4" onpageindexchanging="grd_gift_PageIndexChanging" onrowcancelingedit="grd_gift_RowCancelingEdit"
        onrowdeleting="grd_gift_RowDeleting" onrowediting="grd_gift_RowEditing" onrowupdating="grd_gift_RowUpdating" DataKeyNames="id" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px">

        <RowStyle BackColor="White" ForeColor="#003399" />
             <Columns>
                <asp:TemplateField HeaderText="ID">
                     <ItemTemplate><%--item template--%>
                            <asp:Label ID="lbl_id1" runat="server" Text='<%# Eval("id") %>' />
                     </ItemTemplate>   
                     <EditItemTemplate><%--edit item template--%>
                            <asp:HiddenField ID="hdf_idE" runat="server" Value='<%# Eval("id") %>'></asp:HiddenField><%--hidden field--%>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate><%--item template--%>
                            <asp:Label ID="lbl_name" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                    </ItemTemplate>

                    <EditItemTemplate><%--edit item template--%>
                            <asp:TextBox ID="txt_nameE" runat="server" Text='<%# Bind("name") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_nameE" runat="server" Text="*Required" ControlToValidate="txt_nameE" ValidationGroup="update1" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Description">
                    <ItemTemplate><%--item template--%>
                            <asp:Label ID="lbl_desc" runat="server" Text='<%# Eval("description") %>'></asp:Label>
                    </ItemTemplate>

                    <EditItemTemplate><%--edit item template--%>
                            <asp:TextBox ID="txt_descE" runat="server" Text='<%# Bind("description") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_descE" runat="server" Text="*Required" ControlToValidate="txt_descE" ValidationGroup="update1" />
                    </EditItemTemplate>
                </asp:TemplateField>

                 <asp:TemplateField HeaderText="Category">
                    <ItemTemplate><%--item template--%>
                            <asp:Label ID="lbl_category" runat="server" Text='<%# Eval("category") %>'></asp:Label>
                    </ItemTemplate>

                    <EditItemTemplate><%--edit item template--%>
                            <asp:DropDownList ID="ddl_categoryE" runat="server">
                                <asp:ListItem>All</asp:ListItem>
                                <asp:ListItem>Get Well Soon</asp:ListItem>
                                <asp:ListItem>Congratualations</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfv_categoryE" runat="server" Text="*Required" ControlToValidate="ddl_categoryE" ValidationGroup="update1" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Price">
                    <ItemTemplate><%--item template--%>
                            <asp:Label ID="lbl_price" runat="server" Text='<%# Eval("price") %>'></asp:Label>
                    </ItemTemplate>

                    <EditItemTemplate><%--edit item template--%>
                            <asp:TextBox ID="txt_priceE" runat="server" Text='<%# Bind("price") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_priceE" runat="server" Text="*Required" ControlToValidate="txt_priceE" ValidationGroup="update1" />
                            <asp:CompareValidator ID="cpv_priceE" runat="server" Text="*Not a number" ControlToValidate="txt_priceE" Operator="DataTypeCheck" Type="Currency" ValidationGroup="update1" Display="Dynamic" />
                    </EditItemTemplate>
                </asp:TemplateField>

                  <asp:TemplateField HeaderText="Image Url">
                    <ItemTemplate><%--item template--%>
                            <asp:Label ID="lbl_imgUrl" runat="server" Text='<%# Eval("imageUrl") %>'></asp:Label>
                    </ItemTemplate>

                    <EditItemTemplate><%--edit item template--%>
                        <asp:FileUpload id="fu_GimageUploadU" runat="server" />
                        <asp:HiddenField ID="hdf_GimageGUrlU" runat="server" Value ='<%# Eval("imageUrl") %>' />
                        <asp:RequiredFieldValidator ID="rfv_GimageUploadU" runat="server" Text="*Required" ControlToValidate="fu_GimageUploadU" ValidationGroup="update1" />
                        <asp:CustomValidator ID="cmv_GimageUploadU" runat="server" ControlToValidate="fu_GimageUploadU" ErrorMessage="File must be in JPEG format and must not exceed 100kb in size" ForeColor="Red" ValidateEmptyText="True" ValidationGroup="update1" />       
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Edit">
                    
                    <ItemTemplate><%--item template--%>                         
                            <asp:LinkButton ID="lbn_edit" runat="server" CommandName="Edit" >Edit</asp:LinkButton>                            
                    </ItemTemplate>

                    <EditItemTemplate><%--edit item template--%>
                            <asp:HiddenField ID="hdf_idEU" runat="server" Value='<%#Eval("id") %>' />
                            <asp:LinkButton ID="lbn_update" runat="server" CommandName="Update"  ValidationGroup="update1">Update</asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="lbn_cancel" runat="server" CommandName="Cancel" CausesValidation="false">Cancel</asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Delete">
                    <ItemTemplate><%--item template--%>
                            <asp:HiddenField ID="hdf_idD" runat="server" Value='<%#Eval("id") %>' />
                            <asp:LinkButton ID="lbn_delete" runat="server" CommandName="Delete" onclientclick="return confirm('Are you sure want to delete the current record ?')">Delete</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>


        </Columns>


        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
        <SortedAscendingCellStyle BackColor="#EDF6F6" />
        <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
        <SortedDescendingCellStyle BackColor="#D6DFDF" />
        <SortedDescendingHeaderStyle BackColor="#002876" />

    </asp:GridView>
   
   </td>

   
</tr>

<tr>
    <td >&nbsp;</td>
    <td>&nbsp;</td>
</tr>

<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
</tr>

</table>
 </asp:Panel>
<div>

</div>

    </ContentTemplate>

    </AJAX:TabPanel>

        <%--Code for Ecards controls--%>

         <AJAX:TabPanel ID="tp_eCards" runat="server" >
             <HeaderTemplate>
                E-Cards Admin
             </HeaderTemplate>

          <ContentTemplate>
              <h1>E-cards Admin</h1>
                <%--message--%>
    <asp:Label ID="lbl_messageB" runat="server" /><br /><br />

 <%--code for insert--%>
<asp:Panel ID="Panel2" runat="server" ScrollBars="Both">
<table class="style1">

    <tr>
        <td ></td>
        <td><asp:Label ID="Label2" runat="server" Text='<%# Eval("id") %>'></asp:Label></td>
    </tr>
    <tr>
        <td >Name</td>
        <td><asp:TextBox ID="txt_nameII" runat="server"></asp:TextBox></td>
        <td><asp:RequiredFieldValidator ID="rfv_nameII" runat="server" Text="*Required" ControlToValidate="txt_nameII" ValidationGroup="insert" /></td>
    </tr>
    <tr>
        <td >Description</td>
        <td><asp:TextBox ID="txt_descII" runat="server" Height="22px" ></asp:TextBox></td>
        <td><asp:RequiredFieldValidator ID="rfv_descII" runat="server" Text="*Required" ControlToValidate="txt_descII" ValidationGroup="insert" /></td>
    </tr>
    <tr>
        <td >Category</td>
        <td>
            <asp:DropDownList ID="ddl_categoryII" runat="server">
               <asp:ListItem>All</asp:ListItem>
               <asp:ListItem>Get Well Soon</asp:ListItem>
               <asp:ListItem>Congratualations</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td><asp:RequiredFieldValidator ID="rfv_categoryII" runat="server" Text="*Required" ControlToValidate="ddl_categoryII" ValidationGroup="insert" /></td>
    </tr>
    <tr>
        <td >Message</td>
        <td><asp:TextBox ID="txt_msgII" runat="server"></asp:TextBox></td>
        <td><asp:RequiredFieldValidator ID="rfv_msgII" runat="server" Text="*Required" ControlToValidate="txt_msgII" ValidationGroup="insert" /></td>
    </tr>
    <tr>
        <td >Image Url</td>
         <td ><asp:FileUpload id="fu_EimageUploadI" runat="server" /></td>
        <td>
            <asp:RequiredFieldValidator ID="rfv_EimageUploadI" runat="server" Text="*Required" ControlToValidate="fu_EimageUploadI" ValidationGroup="insert" />
            <asp:CustomValidator ID="cmv_EimageUploadI" runat="server" ControlToValidate="fu_EimageUploadI" ErrorMessage="File must be in JPEG format and must not exceed 100kb in size" ForeColor="Red" ValidateEmptyText="True" ValidationGroup="insert" />
        </td>
        <asp:HiddenField ID="hdf_EimageUrlI" runat="server" />
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><asp:Button ID="btn_insertII" runat="server" Height="26px"  Text="Insert" Width="89px" onclick="subInsertII" ValidationGroup="insert" /></td>
    </tr>
    <tr>
        <td >&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2"><%--gridview control for eCards--%>



    <asp:GridView ID="grd_ecard" runat="server" AutoGenerateColumns="False" CellPadding="4" onpageindexchanging="grd_ecard_PageIndexChanging" onrowcancelingedit="grd_ecard_RowCancelingEdit"
        onrowdeleting="grd_ecard_RowDeleting" onrowediting="grd_ecard_RowEditing" onrowupdating="grd_ecard_RowUpdating" DataKeyNames="id" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px">

        <RowStyle BackColor="White" ForeColor="#003399" />
             <Columns>
                <asp:TemplateField HeaderText="ID">
                     <ItemTemplate><%--item template--%>
                            <asp:Label ID="lbl_id1" runat="server" Text='<%# Eval("id") %>' />
                     </ItemTemplate>   
                     <EditItemTemplate><%--edit item template--%>
                            <asp:HiddenField ID="hdf_idEE" runat="server" Value='<%# Eval("id") %>'></asp:HiddenField><%--hidden field--%>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate><%--item template--%>
                            <asp:Label ID="lbl_nameEE" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                    </ItemTemplate>

                    <EditItemTemplate><%--edit item template--%>
                            <asp:TextBox ID="txt_nameEE" runat="server" Text='<%# Bind("name") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_nameEE" runat="server" Text="*Required" ControlToValidate="txt_nameEE" ValidationGroup="update" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Description">
                    <ItemTemplate><%--item template--%>
                            <asp:Label ID="lbl_descEE" runat="server" Text='<%# Eval("description") %>'></asp:Label>
                    </ItemTemplate>

                    <EditItemTemplate><%--edit item template--%>
                            <asp:TextBox ID="txt_descEE" runat="server" Text='<%# Bind("description") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_descE" runat="server" Text="*Required" ControlToValidate="txt_descEE" ValidationGroup="update" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Category">
                    <ItemTemplate><%--item template--%>
                            <asp:Label ID="lbl_categoryEE" runat="server" Text='<%# Eval("category") %>'></asp:Label>
                            
                    </ItemTemplate>

                    <EditItemTemplate><%--edit item template--%>
                            <asp:DropDownList ID="ddl_categoryEE" runat="server" DataTextField='<%# Bind("category") %>'>
                                <asp:ListItem>All</asp:ListItem>
                                <asp:ListItem>Get Well Soon</asp:ListItem>
                                <asp:ListItem>Congratualations</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfv_categoryEE" runat="server" Text="*Required" ControlToValidate="ddl_categoryEE" ValidationGroup="update" />
                    </EditItemTemplate>
                </asp:TemplateField>

                 <asp:TemplateField HeaderText="Message">
                    <ItemTemplate><%--item template--%>
                            <asp:Label ID="lbl_msgEE" runat="server" Text='<%# Eval("message") %>'></asp:Label>
                    </ItemTemplate>

                    <EditItemTemplate><%--edit item template--%>
                            <asp:TextBox ID="txt_msgEE" runat="server" Text='<%# Bind("message") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_msgEE" runat="server" Text="*Required" ControlToValidate="txt_msgEE" ValidationGroup="update" />
                    </EditItemTemplate>
                </asp:TemplateField>

                 <asp:TemplateField HeaderText="Image Url">
                    <ItemTemplate><%--item template--%>
                            <asp:Label ID="lbl_ImageUrlEE" runat="server" Text='<%# Eval("imageUrl") %>'></asp:Label>
                    </ItemTemplate>

                    <EditItemTemplate><%--edit item template--%>
                            <asp:FileUpload id="fu_EimageUploadU" runat="server" />
                            <asp:HiddenField ID="hdf_EimageGUrlU" runat="server" Value ='<%# Eval("imageUrl") %>' />
                            <asp:RequiredFieldValidator ID="rfv_EimageUploadU" runat="server" Text="*Required" ControlToValidate="fu_EimageUploadU" ValidationGroup="update" />
                            <asp:CustomValidator ID="cmv_EimageUploadU" runat="server" ControlToValidate="fu_EimageUploadU" ErrorMessage="File must be in JPEG format and must not exceed 100kb in size" ForeColor="Red" ValidateEmptyText="True" ValidationGroup="update" />       
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Edit">
                    
                    <ItemTemplate><%--item template--%>                         
                            <asp:LinkButton ID="lbn_editEE" runat="server" CommandName="Edit" >Edit</asp:LinkButton>                            
                    </ItemTemplate>

                    <EditItemTemplate><%--edit item template--%>
                            <asp:HiddenField ID="hdf_idUU" runat="server" Value='<%#Eval("id") %>' />
                            <asp:LinkButton ID="lbn_update" runat="server" CommandName="Update"  ValidationGroup="update">Update</asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="lbn_cancel" runat="server" CommandName="Cancel" CausesValidation="false">Cancel</asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Delete">
                    <ItemTemplate><%--item template--%>
                            <asp:HiddenField ID="hdf_idD" runat="server" Value='<%#Eval("id") %>' />
                            <asp:LinkButton ID="lbn_delete" runat="server" CommandName="Delete" onclientclick="return confirm('Are you sure want to delete the current record ?')">Delete</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>


        </Columns>


        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
        <SortedAscendingCellStyle BackColor="#EDF6F6" />
        <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
        <SortedDescendingCellStyle BackColor="#D6DFDF" />
        <SortedDescendingHeaderStyle BackColor="#002876" />

    </asp:GridView>
    

   </td>

   
</tr>
   
<tr>
    <td >&nbsp;</td>
    <td>&nbsp;</td>
</tr>

<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
</tr>

</table>
    </asp:Panel>
<div>

</div>
               
          </ContentTemplate>

        </AJAX:TabPanel>

    </AJAX:TabContainer>
</asp:Content>

