<%@ Page Title="" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="bookaptment_admin_gr.aspx.cs" Inherits="_Default" Theme="Theme1" Debug="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_content" Runat="Server">
    View All Appointments
    
    <%--On this page admin can view all the appointments that have been booked. 

    Admin can also update delete the appointments as required. i have used datalist to display the appointments--%>
    
    <asp:Panel ID="pnl_all" runat="server" GroupingText="All Products">
            <table>
                <thead style="font-weight:bolder; background-color:#d3d3d3;">
                    <tr>
                        <th><asp:Label ID="lbl_name" runat="server" Text="Name" /></th>
                        <th><asp:Label ID="Lbl_date" runat="server" Text="Date" /></th>
                        <th><asp:Label ID="lbl_option" runat="server" Text="Option" /></th>
                        <th><asp:Label ID="lbl_option2" runat="server" Text="Option" /></th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Datalist ID="dtl_all" runat="server" >
                        <ItemTemplate>
                            <tr>
                                <asp:HiddenField ID="hdf_id" runat="server" Value='<%#Eval("id") %>' />
                                <td><%#Eval("fname")%></td>
                                <td><%#Eval("date")%></td>
       <%--Calling subAdmin oncommand,where we have used switch statement to perform update, delete --%>
                                <td><asp:LinkButton ID="btn_update" runat="server" Text="Update" CommandName="Update" CommandArgument='<%#Eval("id")%>' OnCommand="subAdmin" /></td>
                                <td><asp:LinkButton ID="btn_delete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%#Eval("id") %>' OnCommand="subAdmin" /></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Datalist>
                </tbody>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnl_update" runat="server" GroupingText="Update Product">
            <table>
                 <thead style="font-weight:bolder; background-color:#d3d3d3;">
                    <tr>
                        <th><asp:Label ID="lbl_fnameU" runat="server" Text="First Name" /></th>
                        <th><asp:Label ID="lbl_lnameU" runat="server" Text="Last Name" /></th>
                        <th><asp:Label ID="lbl_phoneU" runat="server" Text="Phone" /></th>
                        <th><asp:Label ID="lbl_emailU" runat="server" Text="Email" /></th>
                        <th><asp:Label ID="lbl_dateU" runat="server" Text="Date" /></th>                        
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Datalist ID="dtl_update" runat="server" OnItemCommand="subUpDel">
                        <ItemTemplate>
                            <tr>                                
                                <td><asp:TextBox ID="txt_fnameU" runat="server" Text='<%#Eval("fname") %>' /></td>
                                <td><asp:TextBox ID="txt_lnameU" runat="server" Text='<%#Eval("lname")%>'/></td>
                                <td><asp:TextBox ID="txt_phoneU" runat="server" Text='<%#Eval("phone") %>' /></td>
                                <td><asp:TextBox ID="txt_emailU" runat="server" Text='<%#Eval("email") %>' /></td>
                                <td><asp:TextBox ID="txt_dateU" runat="server" Text='<%#Eval("date") %>' /></td>
                                <td><asp:HiddenField ID="hdf_id" runat="server" Value='<%#Eval("id") %>' /></td>
                            </tr>
                            <tr>
                                <td><asp:RequiredFieldValidator ID="rfv_fnameU" runat="server" Text="*Required" ControlToValidate="txt_fnameU" ValidationGroup="update" Display="Dynamic" /></td>
                                <td><asp:RequiredFieldValidator ID="rfv_lnameU" runat="server" Text="*Required" ControlToValidate="txt_lnameU" ValidationGroup="update" Display="Dynamic" /></td>
                                <td><asp:RequiredFieldValidator ID="rfv_phoneU" runat="server" Text="*Required" ControlToValidate="txt_phoneU" ValidationGroup="update" Display="Dynamic" /></td>
                                <td><asp:RequiredFieldValidator ID="rfv_emailU" runat="server" Text="*Required" ControlToValidate="txt_emailU" ValidationGroup="update" Display="Dynamic" /></td>
                                <td><asp:RequiredFieldValidator ID="rfv_dateU" runat="server" Text="*Required" ControlToValidate="txt_dateU" ValidationGroup="update" Display="Dynamic" />
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
                        <th><asp:Label ID="lbl_fnameD" runat="server" Text="First Name" /></th>
                        <th><asp:Label ID="lbl_lnameD" runat="server" Text="Last Name" /></th>
                        <th><asp:Label ID="lbl_phoneD" runat="server" Text="Phone" /></th>
                        <th><asp:Label ID="lbl_emailD" runat="server" Text="Email" /></th>
                        <th><asp:Label ID="lbl_dateD" runat="server" Text="Date" /></th>
                    </tr>
                </thead>
                <tbody>
    <%--Delete Panel--%>
                    <asp:Datalist ID="dtl_delete" runat="server" OnItemCommand="subUpDel">
                        <ItemTemplate>
                            <tr>
                                <td><asp:HiddenField ID="hdf_id" runat="server" Value='<%#Eval("id") %>' /></td>
                                <td><asp:Label ID="txt_fnameDe" runat="server" Text='<%#Eval("fname") %>' /></td>
                                <td><asp:Label ID="txt_lnameDe" runat="server" Text='<%#Eval("lname") %>' /></td>
                                <td><asp:Label ID="txt_PhoneDe" runat="server" Text='<%#Eval("phone") %>' /></td>
                                <td><asp:Label ID="txt_emailDe" runat="server" Text='<%#Eval("email") %>' /></td>
                                <td><asp:Label ID="date" runat="server" Text='<%#Eval("date") %>' /></td>
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
        <asp:Label ID="lbl_message" runat="server" />


</asp:Content>

