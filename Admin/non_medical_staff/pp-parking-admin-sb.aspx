<%@ Page Title="" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="pp-parking-admin-sb.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_content" Runat="Server">
    <div class="sb">
        <AJAX:ToolkitScriptManager ID="tsm_parking" runat="server" />
        <div id="menu_parking">
            <asp:Menu ID="mnu_parking" runat="server" Orientation="Horizontal" StaticMenuItemStyle-CssClass="tab" StaticSelectedStyle-CssClass="selected" CssClass="tabs" OnMenuItemClick="subMenuClick" >
                <Items>
                    <asp:MenuItem Text="All Permits" Value="0" Selected="true" />
                    <asp:MenuItem Text="Current Permits" Value="1"/> 
                    <asp:MenuItem Text="Expired Permits" Value="2" />
                    <asp:MenuItem Text="Find Permit" Value="3" />
                </Items>
            </asp:Menu>
        </div>

        <div id="parking_admin" class="panels">
            <asp:Panel ID="pnl_list" runat="server" CssClass="pnl_list">
                <h1>View Permits</h1>   
                <table>                    
                    <thead>
                        <tr>
                            <th>Permit #: </th>
                            <th>Name: </th>
                            <th>Email: </th>
                            <th>Plate #:</th>
                            <th>Spot #:</th>
                            <th>Time In: </th>
                            <th>Expiry: </th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>                 
                    <asp:ListView ID="ltv_parking" runat="server" DataKeyNames="park_id" OnItemCommand="subAdmin">
                        <ItemTemplate>
                            <tr>
                                <td><asp:Label ID="lbl_permit_num" runat="server" Text='<%#Eval("park_id") %>' /></td>
                                <td><asp:Label ID="lbl_name" runat="server" Text='<%#Eval("name") %>' /></td>
                                <td><asp:Label ID="lbl_email" runat="server" Text='<%#Eval("email") %>' /></td>
                                <td><asp:Label ID="lbl_plate_num" runat="server" Text='<%#Eval("plate_num") %>' /></td>
                                <td><asp:Label ID="lbl_spot" runat="server" Text='<%#Eval("spot") %>' /></td>
                                <td><asp:Label ID="lbl_time_in" runat="server" Text='<%#Eval("time_in") %>' /></td>
                                <td><asp:Label ID="lbl_time_exp" runat="server" Text='<%#Eval("time_exp") %>' /></td>
                                <td><asp:LinkButton ID="lkb_edit" runat="server" Text="Edit" CommandName="Upd" /></td>
                                <td><asp:LinkButton ID="lkb_delete" runat="server" Text="Delete" CommandName="Delete" /></td>
                                <td><asp:LinkButton ID="lkb_ticket" runat="server" Text="Ticket" CommandName="Ticket"/></td>
                            </tr>                            
                        </ItemTemplate>
                       <%-- <EditItemTemplate>
                                <td><asp:Label ID="lbl_permit_num" runat="server" Text='<%#Eval("park_id") %>' /></td>
                                <td><asp:TextBox ID="txt_name" runat="server" Text='<%#Bind("name") %>' /></td>
                                <td><asp:TextBox ID="txt_email" runat="server" Text='<%#Bind("email") %>' /></td>
                                <td><asp:TextBox ID="txt_plate_num" runat="server" Text='<%#Bind("plate_num") %>' /></td>
                                <td><asp:TextBox ID="txt_spot" runat="server" Text='<%#Bind("spot") %>' /></td>
                                <td><asp:TextBox ID="txt_time_in" runat="server" Text='<%#Bind("time_in") %>' /></td>
                                <td><asp:TextBox ID="txt_time_exp" runat="server" Text='<%#Bind("time_exp") %>' /></td>
                                <td><asp:LinkButton ID="lkb_edit" runat="server" Text="Edit" CommandName="Edit" /></td>
                                <td><asp:LinkButton ID="lkb_delete" runat="server" Text="Delete" CommandName="Delete" /></td>
                                <td><asp:LinkButton ID="lkb_ticket" runat="server" Text="Ticket" CommandName="Ticket"/></td>
                        </EditItemTemplate>--%>
                    </asp:ListView>  
                    </tbody>
                </table>
                <asp:Panel ID="pnl_edit_permit" runat="server">
                <asp:FormView ID="fmv_permit" runat="server" DefaultMode="Edit">
                    <EditItemTemplate>
                        <h3>Name: </h3>
                        <asp:HiddenField ID="hdf_idU" runat="server" Value='<%#Bind("park_id") %>' /><asp:TextBox ID="txt_fnameU" runat="server" Text='<%#Bind("name") %>' />           
                            
                        <h3>Email: </h3>
                        <asp:TextBox ID="txt_email" runat="server" Text='<%#Bind("email") %>' />
                        <h3>Plate Num: </h3>
                        <asp:TextBox ID="txt_plate" runat="server" />
                        <h3>Spot: </h3>
                        <asp:DropDownList ID="ddl_spots" runat="server">
                        </asp:DropDownList>
                        <h3>Duration: </h3>
                        <asp:DropDownList ID="ddl_duration" runat="server" >
                            <asp:ListItem Value="15" Text="15 Minutes" />
                            <asp:ListItem Value="30" Text="30 Minutes" />
                            <asp:ListItem Value="45" Text="45 Minutes" />
                            <asp:ListItem Value="60" Text="60 Minutes" />
                        </asp:DropDownList>
                        <asp:Button ID="btn_submit" runat="server" Text="Pay" CommandName="Update" />
                        <asp:Button ID="btn_cancel" runat="server" Text="Cancel" />
                    </EditItemTemplate>            
                </asp:FormView> 
            </asp:Panel>
            </asp:Panel>
            
            <%--FIND PERMIT PANEL--%>
            <asp:Panel ID="pnl_find" runat="server">
                <h3>Reciept #</h3>
                <asp:TextBox ID="txt_park_idU" runat="server" />
                <h3>Email: </h3>
                <asp:TextBox ID="txt_emailU" runat="server" />
                <asp:Button ID="btn_submitU" runat="server" Text="Submit" OnClick="getPermit" />
            </asp:Panel>

            <%--UPDATE PARKING PANEL--%>
            <%--<AJAX:ModalPopupExtender  ID="mpe_parking_admin" runat="server" TargetControlID="btn_show_popup" PopupControlID="pnl_edit_permit" BackgroundCssClass="modal_bg" CancelControlID="btn_cancel"/>--%>
            
            
            <%--MESSAGE PANEL == I HAVE NO IDEA WHY THIS IS SHOWING ALL THE TIME AND DOES NOT DISPLAY PROPERLY--%>
                <AJAX:ModalPopupExtender ID="mpe_message" runat="server" TargetControlID="btn_show_popup" PopupControlID="pnl_message" BackgroundCssClass="modal_bg" CancelControlID="btn_OK" />
                <asp:Panel ID="pnl_message" runat="server" CssClass="modal_pnl">
                    <asp:Label ID="lbl_message" runat="server" />
                    <asp:Button ID="btn_OK" runat="server" Text="OK" />
                </asp:Panel>
            <%--MODAL POP-UP HIDDEN BUTTON--%>
        <asp:Button ID="btn_show_popup" runat="server" style="display:none;" />
            
        </div> <%--/parking_admin--%>
    </div> <%--/.sb--%>
</asp:Content>

