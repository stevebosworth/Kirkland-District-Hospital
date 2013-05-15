<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="pp_public_sb.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_content" Runat="Server">
    <div class="sb">
        <asp:ScriptManager ID="scm_parking" runat="server" />
        <asp:Menu ID="mnu_parking" runat="server" Orientation="Horizontal" StaticMenuItemStyle-CssClass="tab" StaticSelectedStyle-CssClass="selected" CssClass="tabs" OnMenuItemClick="subMenuClick" >
            <Items>
                <asp:MenuItem Text="Parking Info" Value="0" Selected="true" />
                <asp:MenuItem Text="Pay For Parking" Value="1"/>
                <asp:MenuItem Text="Update Your Ticket" Value="2" />
            </Items>
        </asp:Menu>
        <div id="parking_public" class="panels">
            <asp:Label ID="lbl_test" runat="server" />
            <%--PARKING INFO PANEL--%>
            <asp:panel id="pnl_info" runat="server">
                <AJAX:Accordion ID="acc_parking" runat="server">
                    <Panes>
                        <AJAX:AccordionPane ID="acp_hours" runat="server" CssClass="acc_pane">
                            <Header>
                                <h1>Hours</h1>
                            </Header>
                            <Content>
                                <p>Our Parking Lot is Open 24 hours a day, 7 days a week.</p>
                                <p>Parking costs 2/hr or $10 for an 8 hr period.</p>                                
                            </Content>
                        </AJAX:AccordionPane>
                        <AJAX:AccordionPane ID="acp_rules" runat="server" CssClass="acc_pane">
                            <Header>
                                <h1>Rules and Regulations</h1>
                            </Header>
                            <Content>
                                <p>You can pay for parking by the hour through our website.</p>
                                <p>For longer periods you must pay the attendant.</p>
                            </Content>
                        </AJAX:AccordionPane>
                        <AJAX:AccordionPane ID="acp_help" runat="server" CssClass="acc_pane">
                            <Header>
                                <h1>Help</h1>
                            </Header>
                            <Content>
                                <p>Please see our friendly parking attendant or <a href="~/contact.aspx">contact us.</a></p>
                            </Content>
                        </AJAX:AccordionPane>
                    </Panes>
                </AJAX:Accordion>
            </asp:panel><%--/pnl_info--%>
            
            <%--PAY FOR PARKING PANEL--%>
            <asp:panel id="pnl_pay" runat="server">
                <h3>Name: </h3>
                <asp:TextBox ID="txt_name" runat="server" />
                <%--VALIDATION--%>
                <asp:RequiredFieldValidator ID="rfv_name" runat="server" ControlToValidate="txt_name" ErrorMessage="You must enter your name." Display="None" ValidationGroup="pay" />
                <h3>Email: </h3>
                <asp:TextBox ID="txt_email" runat="server" />
                <%--VALIDATION--%>
                <asp:RequiredFieldValidator ID="rfv_email" runat="server" ControlToValidate="txt_email" ErrorMessage="You must enter an email." Display="None" ValidationGroup="pay" />
                <%-- Email Validator --%>
                <asp:RegularExpressionValidator ID="rev_email" runat="server" Text="Emails must be in the form of ****@****.*** " ControlToValidate="txt_email" Display="none" SetFocusOnError="true" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="You must enter a valid email (ie. steve@bosworth.com)" ValidationGroup="pay" />
                <h3>Plate Num: </h3>
                <asp:TextBox ID="txt_plate" runat="server" />
                <%--VALIDATION--%>
                <asp:RequiredFieldValidator ID="rfv_plate" runat="server" ControlToValidate="txt_plate" ErrorMessage="You must enter your plate number." Display="None" ValidationGroup="pay" />
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
                <h3>Current Time: </h3>
                <asp:UpdatePanel ID="udp_curr_time" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lbl_curr_time" runat="server" />
                        <asp:Timer ID="tmr_curr_time" runat="server" Interval="1000" OnTick="currTime" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Button ID="btn_confirm" runat="server" Text="Confirm" CommandName="Confirm" CausesValidation="true" ValidationGroup="pay" OnCommand="subAdmin" />
                <asp:Button ID="btn_cancel" runat="server" Text="Cancel" CommandName="Cancel" OnCommand="subAdmin" />
                <asp:ValidationSummary ID="vds_pay" runat="server" ValidationGroup="pay" ShowSummary="false" ShowMessageBox="true" DisplayMode="List" />
                <%--CONFIRM PAYMENT MODAL POPUP--%>
                <AJAX:ModalPopupExtender ID="mpe_confirm" runat="server" TargetControlID="btn_null" PopupControlID="pnl_confirm" BackgroundCssClass="modal_bg" CancelControlID="btn_close" />
                <asp:Panel ID="pnl_confirm" runat="server" CssClass="modal_pnl">
                    <div id="summary">
                        <h2>Confirm Your Info: </h2>
                        <h3>Name: </h3>
                        <asp:Label ID="lbl_nameC" runat="server" />
                        <h3>Email: </h3>
                        <asp:Label ID="lbl_emailC" runat="server" />
                        <h3>Plate Num: </h3>
                        <asp:Label ID="lbl_plate_numC" runat="server" />
                        <h3>Spot: </h3>
                        <asp:Label ID="lbl_spotC" runat="server" />
                        <h3>Duration: </h3>
                        <asp:Label ID="lbl_durationC" runat="server" />
                    </div>
                    <div class="payment">
                        <h3>Name on Card: </h3>
                        <asp:TextBox ID="txt_card_name" runat="server" />
                        <h3>Card Number: </h3>
                        <asp:TextBox ID="txt_card_num" runat="server" />
                        <h3>Expiry: mm/yy</h3>
                        <asp:TextBox ID="txt_card_exp" runat="server" />
                    </div>
                    
                    <asp:Button ID="btn_pay" runat="server" CommandName="Pay" OnCommand="subAdmin" Text="Pay" />
                    <asp:Button ID="btn_close" runat="server" CommandName="Cancel" OnCommand="subAdmin" Text="Close" />
                </asp:Panel>
            </asp:panel> <%--/pnl_pay--%>

            <%--UPDATE PARKING PANEL--%>
            <asp:Panel ID="pnl_update" runat="server">
                <h3>Reciept #</h3>
                <asp:TextBox ID="txt_park_idU" runat="server" />
                <h3>Email: </h3>
                <asp:TextBox ID="txt_emailU" runat="server" />
                <asp:Button ID="btn_submitU" runat="server" Text="Submit" OnClick="getPermit" />
                <%--UPDATE PARKING MODAL POPUP--%>
                <AJAX:ModalPopupExtender ID="mpe_update" runat="server" TargetControlID="btn_null" PopupControlID="pnl_upd_form" BackgroundCssClass="modal_bg" CancelControlID="btn_cancel_add" />
                <asp:Panel ID="pnl_upd_form" runat="server" CssClass="modal_pnl">
                    <asp:FormView ID="fmv_update" runat="server" DefaultMode="Edit">
                        <EditItemTemplate>
                            <asp:HiddenField ID="hdf_idU" runat="server" Value='<%#Eval("park_id") %>' />
                            <asp:HiddenField ID="hdf_spotU" runat="server" Value='<%#Eval("spot") %>' />
                            <h3>Name: </h3>
                            <asp:Label ID="lbl_nameU" runat="server" Text='<%#Eval("name") %>' />
                            <h3>Plate Num: </h3>
                            <asp:Label ID="lbl_plateU" runat="server" Text='<%#Eval("plate_num") %>' />
                            <h3>Current Expiry: </h3>
                            <asp:Label ID="lbl_time_expU" runat="server" Text='<%#Eval("time_exp") %>' />
                            <h3>Add Time: </h3>
                            <asp:DropDownList ID="ddl_durationU" runat="server" >
                                <asp:ListItem Value="15" Text="15 Minutes" />
                                <asp:ListItem Value="30" Text="30 Minutes" />
                                <asp:ListItem Value="45" Text="45 Minutes" />
                                <asp:ListItem Value="60" Text="60 Minutes" />
                            </asp:DropDownList>
                            <asp:Button ID="btn_add_time" runat="server" Text="Add Time" CommandName="Update"  />
                            <asp:Button ID="btn_cancel_add" runat="server" Text="Cancel" /> 
                        </EditItemTemplate>  
                    </asp:FormView>
                </asp:Panel> <%--/pnl_upd_form--%>
            </asp:Panel> <%--/pnl_update--%>
        </div>
    </div>
    <%--MESSAGE MODAL PANEL--%>
        <AJAX:ModalPopupExtender ID="mpe_message" runat="server" TargetControlID="btn_null" PopupControlID="pnl_message" BackgroundCssClass="modal_bg" OkControlID="btn_ok" />
        <asp:Panel ID="pnl_message" runat="server" CssClass="modal_pnl">
            <asp:Label ID="lbl_message" runat="server" />
            <asp:Button ID="btn_ok" runat="server" Text="OK" />
        </asp:Panel>
    <%--Placeholder button for Modal Popup Extenders--%>
    <asp:Button ID="btn_null" runat="server" style="display:none" />
</asp:Content>

