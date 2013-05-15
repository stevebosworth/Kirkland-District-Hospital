<%@ Page Title="" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" debug="true" CodeFile="location-admin-gr.aspx.cs" Theme="Theme1" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_content" Runat="Server">
<%-- This is the insert panel from where a user can insert department details in the database
    
    i have used a column for geolocation to expand this feature in future (to store the latitude and longitudes)
    --%>
        <asp:Label ID="lbl_message" runat="server" />
        <br /><br />
        <asp:Label ID="lbl_insert" runat="server" Text="Insert New Department: " Font-Bold="true" />
        <br />
        <asp:Label ID="lbl_deptnameI" runat="server" Text="Name" AssociatedControlID="txt_deptnameI" />
        <br />
        <asp:TextBox ID="txt_deptnameI" runat="server" />
        <asp:RequiredFieldValidator ID="rfv_deptnameI" runat="server" Text="*Required" ControlToValidate="txt_deptnameI" ValidationGroup="insert" />
        <br />
        <asp:Label ID="lbl_location" runat="server" Text="Location" AssociatedControlID="txt_locationI" />
        <br />
        <asp:TextBox ID="txt_locationI" runat="server" TextMode="MultiLine" />
        <asp:RequiredFieldValidator ID="rfv_locationI" runat="server" Text="*Required" ControlToValidate="txt_locationI" ValidationGroup="insert" />
        <br />
        <asp:Label ID="lbl_phoneI" runat="server" Text="Phone" AssociatedControlID="txt_phoneI" />
        <br />
        <asp:TextBox ID="txt_phoneI" runat="server" />
        <asp:RequiredFieldValidator ID="rfv_phoneI" runat="server" Text="*Required" ControlToValidate="txt_phoneI" ValidationGroup="insert" Display="Dynamic" />
        <br />
        <asp:Label ID="lbl_geo" runat="server" Text="Geolocation" AssociatedControlID="txt_geoI" />
        <br />
        <asp:TextBox ID="txt_geoI" runat="server" />
        <asp:RequiredFieldValidator ID="rfv_geoI" runat="server" Text="*Required" ControlToValidate="txt_geoI" ValidationGroup="insert" Display="Dynamic" />
        <br />
        <asp:Button ID="btn_insert" runat="server" Text="Insert" CommandName="Insert" OnCommand="subAdmin" ValidationGroup="insert" />
        <br /><br />
        
        
        <asp:Panel ID="pnl_all" runat="server" GroupingText="All Products">
            <table>
                <thead style="font-weight:bolder; background-color:#d3d3d3;">
                    <tr>
                        <th><asp:Label ID="lbl_name" runat="server" Text="Name" /></th>
                        <th><asp:Label ID="lbl_option" runat="server" Text="Option" /></th>
                        <th><asp:Label ID="lbl_option2" runat="server" Text="Option" /></th>
                    </tr>
                </thead>
                <tbody>
        <%--Using datalist to display data.--%>

        <%--This panel only shows the product name and delete and update options--%>
                    <asp:Datalist ID="dtl_all" runat="server" >
                        <ItemTemplate>
                            <tr>
                                <asp:HiddenField ID="hdf_id" runat="server" Value='<%#Eval("id") %>' />
                                <td><%#Eval("deptname")%></td>
       <%--Calling subAdmin oncommand,where we have used switch statement to perform update, delete --%>
                                <td><asp:LinkButton ID="btn_update" runat="server" Text="Update" CommandName="Update" CommandArgument='<%#Eval("id")%>' OnCommand="subAdmin" /></td>
                                <td><asp:LinkButton ID="btn_delete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%#Eval("id") %>' OnCommand="subAdmin" /></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Datalist>
                </tbody>
            </table>
        </asp:Panel>
        <%--This is the update panel--%>
        <asp:Panel ID="pnl_update" runat="server" GroupingText="Update Product">
            <table>
                 <thead style="font-weight:bolder; background-color:#d3d3d3;">
                    <tr>
                        <th><asp:Label ID="lbl_deptnameU" runat="server" Text="Department Name" /></th>
                        <th><asp:Label ID="lbl_locationU" runat="server" Text="Location" /></th>
                        <th><asp:Label ID="lbl_phoneU" runat="server" Text="Phone" /></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Datalist ID="dtl_update" runat="server" OnItemCommand="subUpDel">
                        <ItemTemplate>
                            <tr>                                
                                <td><asp:TextBox ID="txt_deptnameU" runat="server" Text='<%#Eval("deptName") %>' /></td>
                                <td><asp:TextBox ID="txt_locationU" runat="server" Text='<%#Eval("location")%>' TextMode="MultiLine" /></td>
                                <td><asp:TextBox ID="txt_phoneU" runat="server" Text='<%#Eval("phone") %>' /></td>
                                <td><asp:TextBox ID="txt_geoU" runat="server" Text='<%#Eval("geolocation") %>' /></td>
                                <td><asp:HiddenField ID="hdf_id" runat="server" Value='<%#Eval("id") %>' /></td>
                            </tr>
                            <tr>
                                <td><asp:RequiredFieldValidator ID="rfv_deptnameU" runat="server" Text="*Required" ControlToValidate="txt_deptnameU" ValidationGroup="update" /></td>
                                <td><asp:RequiredFieldValidator ID="rfv_locationU" runat="server" Text="*Required" ControlToValidate="txt_locationU" ValidationGroup="update" /></td>
                                <td><asp:RequiredFieldValidator ID="rfv_phoneU" runat="server" Text="*Required" ControlToValidate="txt_phoneU" ValidationGroup="update" Display="Dynamic" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:Button ID="btn_doUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="update" />&nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btn_Cancel" runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Datalist>
                </tbody>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnl_delete" runat="server" GroupingText="Delete Product">
            <table>
                <thead style="font-weight:bolder;">
                    <tr>
                        <td colspan="4" style="color:red; text-align:center"><asp:Label ID="lbl_delete" runat="server" Text="Are you sure you want to delete this item?" /></td>
                    </tr>
                    <tr>
                        <th><asp:Label ID="lbl_deptnameD" runat="server" Text="Department Name" /></th>
                        <th><asp:Label ID="lbl_locationD" runat="server" Text="Location" /></th>
                        <th><asp:Label ID="lbl_phoneD" runat="server" Text="Phone" /></th>
                    </tr>
                </thead>
                <tbody>
    <%--Delete Panel--%>
                    <asp:Datalist ID="dtl_delete" runat="server" OnItemCommand="subUpDel">
                        <ItemTemplate>
                            <tr>
                                <td><asp:HiddenField ID="hdf_id" runat="server" Value='<%#Eval("id") %>' /></td>
                                <td><asp:Label ID="txt_proDeptNameDe" runat="server" Text='<%#Eval("deptName") %>' /></td>
                                <td><asp:Label ID="txt_prolocationDe" runat="server" Text='<%#Eval("location") %>' /></td>
                                <td><asp:Label ID="txt_proPhoneDe" runat="server" Text='<%#Eval("phone") %>' /></td>
                                <td><asp:Label ID="txt_proGeoDe" runat="server" Text='<%#Eval("geolocation") %>' /></td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:Button ID="btn_doDelete" runat="server" Text="Delete" CommandName="Delete" />&nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btn_doCancel" runat="server" Text="Cancel" CommandName="Cancel" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Datalist>
                </tbody>
            </table>
        </asp:Panel>
</asp:Content>