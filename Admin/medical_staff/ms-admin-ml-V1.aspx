<%@ Page Title="" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="ms-admin-ml-V1.aspx.cs" Inherits="Admin_ms_admin_ml_V1" Theme="Theme1"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_content" Runat="Server">

<h1>Admin - Medical Services</h1>
    <asp:Label ID="lbl_message" runat="server" />
    <br />
      
    <%-- Code for inserting Medical Service --%>

    <asp:Label ID="lbl_insert" runat="server" Text="Insert new Medical Service" Font-Bold="true" />
    <br />
    <br />
    
    <asp:Label ID="lbl_serviceNameI" runat="server" Text="Service Name" AssociatedControlID="txt_serviceNameI" />
    <br />
    <asp:TextBox ID="txt_serviceNameI" runat="server" />
    <asp:RequiredFieldValidator ID="rfv_serviceNameI" runat="server" Text="*Required" ControlToValidate="txt_servicenameI" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Please enter Service Name." ValidationGroup="insert_form" />
    <br />

    <asp:Label ID="lbl_serviceDetailI" runat="server" Text="Service Details" AssociatedControlID="txt_serviceDetailI" />
    <br />
    <asp:TextBox ID="txt_serviceDetailI" runat="server" TextMode="MultiLine" Columns="40" Rows="10" />
    <asp:RequiredFieldValidator ID="rfv_serviceDetailI" runat="server" Text="*Required" ControlToValidate="txt_serviceDetailI" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Please enter Service Details." ValidationGroup="insert_form"  />
    <br />
    
    <asp:Label ID="lbl_hOperationI" runat="server" Text="Hours of Operation" AssociatedControlID="txt_hOperationI" />
    <br />
    <asp:TextBox ID="txt_hOperationI" runat="server" />
    <asp:RequiredFieldValidator ID="rfv_hOperationI" runat="server" Text="*Required" ControlToValidate="txt_hOperationI" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Please enter hours of operation." ValidationGroup="insert_form"/>
    <br />

    <asp:Label ID="lbl_imageI" runat="server" Text="Image link" AssociatedControlID="txt_imageI" />
    <br />
    <asp:TextBox ID="txt_imageI" runat="server" />
    <asp:RequiredFieldValidator ID="rfv_imageI" runat="server" Text="*Required" ControlToValidate="txt_imageI" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Please enter image file name." ValidationGroup="insert_form" />
    <br />

    <asp:Button ID="btn_insert" runat="server" Text="Insert" OnClick="subInsert" ValidationGroup="insert_form"/>
    <br />
    <br />
    
    <%-- Code for dropDownlist to display Medical Service --%>
    <asp:DropDownList ID="ddl_main" runat="server" AutoPostBack="true" OnSelectedIndexChanged="subChange" />
    <br />
    <br />

    <%-- Code Listview to display Service name, Details, hours of operation and image file --%>
    <asp:ListView ID="ltv_main" runat="server" OnItemCommand="subAdmin">
    <LayoutTemplate>
    <table>
        <thead>
            <tr>
            <th>Service Name</th>
            <th>Service Details</th>
            <th>Hours Operation</th>
            <th>File Image</th>
            </tr>
        </thead>
     
        <tbody>
        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
        </tbody>
    </table>
    </LayoutTemplate>
    
    <%-- Code to bind Columns from Medical Service Table--%>
    
    <ItemTemplate>
        <tr>
            <td>
            <asp:HiddenField ID="hdf_idE" runat="server" Value='<%#Eval("ms_id")%>' />
            
            <asp:TextBox ID="txt_serviceNameE" runat="server" Text='<%#Bind("ms_serviceName")%>'  />
            </td>

            <td>
            <asp:TextBox ID="txt_serviceDetailsE" runat="server" Text='<%#Bind("ms_serviceDetails")%>' TextMode="MultiLine" Columns="40" Rows="15" />
            </td>
            
            <td>
            <asp:TextBox ID="txt_hOperationE" runat="server" Text='<%#Bind("ms_hoursOperation")%>'  />
            </td>
            
            <td>
            <asp:TextBox ID="txt_imageE" runat="server" Text='<%#Bind("ms_image")%>'  />
            </td>


            <td>
            <asp:LinkButton ID="lkb_update" runat="server" Text="Update" CommandName="subUpdate" />
            </td>
            <td>
            <asp:LinkButton ID="lkb_delete" runat="server" Text="Delete" CommandName="subDelete" />
            </td>
      
         </tr>
    </ItemTemplate>
    
    </asp:ListView>
  

</asp:Content>

