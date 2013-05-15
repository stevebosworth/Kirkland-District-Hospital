<%@ Page Title="" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="wt-admin-sb.aspx.cs" Inherits="_wtAdmin" Theme="Theme1" %>

<asp:Content ID="con_head" ContentPlaceHolderID="cph_head" Runat="Server">

</asp:Content>
<asp:Content ID="con_main" ContentPlaceHolderID="cph_content" Runat="Server">
    <div class="sb">
    <AJAX:ToolkitScriptManager ID="tsm_patients" runat="server" />
    <div id="menu_patients">
        <asp:Menu ID="mnu_patients" runat="server" Orientation="Horizontal" StaticMenuItemStyle-CssClass="tab" StaticSelectedStyle-CssClass="selected" CssClass="tabs" OnMenuItemClick="subMenuClick" >
            <Items>
                <asp:MenuItem Text="Add Patient" Value="0" Selected="true" />
                <asp:MenuItem Text="Update Patients" Value="1"/>
            </Items>
        </asp:Menu>
    </div> <%--/menu_patients--%>

    <div id="patient_admin" class="panels">   
        <%--ADMIN PANEL--%>
        <asp:Panel ID="pnl_admin" runat="server">
            <div id="add_patient">
                <h1>Add Patient: </h1>
                <asp:Label ID="lbl_fname" runat="server" Text="First Name: "  />
                <asp:TextBox ID="txt_fname" runat="server" />
                <%--VALIDATION--%>
                <asp:RequiredFieldValidator ID="rfv_fname" runat="server" ControlToValidate="txt_fname" ErrorMessage="*Required<br />" Display="Dynamic" ForeColor="Red" ValidationGroup="addPatient" />

                <asp:Label ID="lbl_lname" runat="server" Text="Last Name: "  />
                <asp:TextBox ID="txt_lname" runat="server" />
                <%--VALIDATION--%>
                <asp:RequiredFieldValidator ID="rfv_lname" runat="server" ControlToValidate="txt_lname" ErrorMessage="*Required<br />" Display="Dynamic" ForeColor="Red" ValidationGroup="addPatient" />

                <asp:Label ID="lbl_pat_num" runat="server" Text="Patient #" />
                <asp:TextBox ID="txt_pat_num" runat="server" />
                <%--VALIDATION--%>
                <asp:RequiredFieldValidator ID="rfv_pat_num" runat="server" ControlToValidate="txt_pat_num" ErrorMessage="*Required<br />" Display="Dynamic" ForeColor="Red" ValidationGroup="addPatient" />
                <asp:RegularExpressionValidator ID="rev_pat_num" runat="server" ControlToValidate="txt_pat_num" ValidationExpression="^\d{4}$" ErrorMessage="Enter 4 digit patient number. No spaces or dashes.<br />" Display="Dynamic" ForeColor="Red" ValidationGroup="addPatient" />

                <asp:Label ID="lbl_hcard_num" runat="server" Text="Health Card #: " />
                <asp:TextBox ID="txt_hcard_num" runat="server" />
                <%--VALIDATION--%>
                <asp:RequiredFieldValidator ID="rfv_hcard_num" runat="server" ControlToValidate="txt_hcard_num" ErrorMessage="*Required<br />" Display="Dynamic" ForeColor="Red" ValidationGroup="addPatient" />
                <asp:RegularExpressionValidator ID="rev_hcard_num" runat="server" ControlToValidate="txt_hcard_num" ValidationExpression="^\d{3}$" ErrorMessage="Enter only the last 3 digits of the patients health card.<br />" Display="Dynamic" ForeColor="Red" ValidationGroup="addPatient" />
                <asp:DropDownList ID="ddl_triage" runat="server">
                    <asp:ListItem Value="1" Text="Triage Level 1" />
                    <asp:ListItem Value="2" Text="Triage Level 2" />
                    <asp:ListItem Value="3" Text="Triage Level 3" />
                    <asp:ListItem Value="4" Text="Triage Level 4" />
                    <asp:ListItem Value="5" Text="Triage Level 5" />
                </asp:DropDownList>
                <asp:UpdatePanel ID="upd_chk_in" runat="server">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="tmr_chk_in" EventName="Tick" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Label ID="lbl_chk_in" runat='server' />       
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Button ID="btn_add" runat="server" Text="Add Patient" CommandName="Insert" OnClick="subInsert" CausesValidation="true" ValidationGroup="addPatient" />
            </div>
            
            <div id="curr_wait_time">
                <h1>Current Average Wait Time: </h1>
                <asp:UpdatePanel ID="udp_wait_time" runat="server">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="tmr_wait" EventName="Tick" />
                    </Triggers>
                    <ContentTemplate>
                        <h2><asp:Label ID="lbl_wt_time" runat="server" /></h2>       
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Timer ID="tmr_wait" runat="server" Interval="60000" OnTick="calcAvgWait" />            
            </div>

            <%--PATIENT LIST PANEL--%>
            <div id="menu_manage">
                <h1>View Patients</h1>
                <asp:Menu ID="mnu_manage" runat="server" Orientation="Horizontal" StaticMenuItemStyle-CssClass="tab" StaticSelectedStyle-CssClass="selected" CssClass="tabs" OnMenuItemClick="subFilter" >
                    <Items>
                        <asp:MenuItem Text="Current Patients" Value="0" Selected="true" />
                        <asp:MenuItem Text="All Patients" Value="1"/>
                    </Items>
                </asp:Menu>
            </div> <%--/menu_manage--%>
            <asp:Panel ID="pnl_list" runat="server" CssClass="pnl_list">
                       
                <asp:DataList ID="dtl_patients" runat="server" OnItemCommand="subWait" CssClass="dtl_patients">   
                    <HeaderTemplate>
                        <th>Patient Name: </th>
                        <th>Patient Number: </th>
                        <th>Health Card: </th>
                        <th>Triage Level: </th>
                        <th>Checked-In: </th>
                        <th>Updated: </th>
                        <th>Checked-Out: </th>
                        <th>Time-Waiting: </th>
                        <th>Edit: </th>
                        <th>Delete </th>
                    </HeaderTemplate>                         
                    <ItemTemplate>
                        <td><asp:HiddenField ID="hdf_id" runat="server" Value='<%#Eval("pat_id") %>' /><asp:Label ID="lbl_fname" runat="server" Text='<%#Eval("fname") %>' /> <asp:Label ID="lbl_lnameL" runat="server" Text='<%#Eval("lname") %>' /></td>
                        <td><asp:Label ID="lbl_pat_numL" runat="server" Text='<%#Eval("pat_num") %>' /></td>
                        <td><asp:Label ID="lbl_hcardL" runat="server" Text='<%#Eval("hcard") %>' /></td>
                        <td><asp:Label ID="lbl_triageL" runat="server" Text='<%#Eval("triage_id") %>' /></td>
                        <td><asp:Label ID="lbl_chk_inL" runat="server" Text='<%#Eval("chk_in") %>' /></td>
                        <td><asp:Label ID="lbl_chk_updL" runat="server" Text='<%#Eval("chk_upd") %>' /></td>
                        <td><asp:Label ID="lbl_chk_outL" runat="server" Text='<%#Eval("chk_out") %>' /></td>
                        <td>
                            <asp:UpdatePanel ID="upd_wait" runat="server" ChildrenAsTriggers="true">
                            <Triggers>
                                <%--<asp:AsyncPostBackTrigger ControlID="tmr_wait" EventName="Tick" />--%>
                            </Triggers>
                            <ContentTemplate> 
                                <asp:Label ID="lbl_wait" runat="server" />    
                            </ContentTemplate>
                            </asp:UpdatePanel>
                            
                        </td>    
                        <td><asp:LinkButton id="lkb_edit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%#Eval("pat_id") %>' /></td>
                        <td><asp:LinkButton ID="lkb_delete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%#Eval("pat_id") %>' OnClientClick="confirm('Are you sure');" /></td>
                        <td><asp:LinkButton ID="lkb_calc_time" runat="server" Text="Get Waiting Time" CommandName="CalcTime" /></td>
                    </ItemTemplate>
                </asp:DataList>  
            </asp:Panel>  
        </asp:Panel> <%--/pnl_admin--%>

        <%--DOCTOR UPDATE PATIENT ADMIN PANEL--%>
        <asp:Panel ID="pnl_upd_patient" runat="server">
            <h2>Patient #:</h2>
            <asp:TextBox ID="txt_pat_numU" runat="server" />
            <h2>Patient Name:</h2>
            <asp:DropDownList ID="ddl_pat_name" runat="server">
            </asp:DropDownList>

            <asp:Button ID="btn_chk_in" runat="server" Text="Check In" CommandName="CheckIn" OnCommand="subUpdate" OnClientClick="Update Patient?" />
            <asp:Button ID="btn_chk_out" runat="server" Text="Check Out" CommandName="CheckOut" OnCommand="subUpdate" OnClientClick="Check Patient Out?"  />
        </asp:Panel>

        <%--EDIT PATIENT MODAL PANEL--%>
        <AJAX:ModalPopupExtender ID="mpe_patient" runat="server" TargetControlID="btn_show_popup" PopupControlID="pnl_edit_patient" BackgroundCssClass="modal_bg" />
        <asp:Panel ID="pnl_edit_patient" runat="server" CssClass="modal_pnl">
                    <asp:FormView ID="fmv_patients" runat="server" OnItemCommand="subAdmin" DefaultMode="Edit">
                        <EditItemTemplate>
                            <h3>First Name: </h3>
                            <asp:HiddenField ID="hdf_idU" runat="server" Value='<%#Bind("pat_id") %>' /><asp:TextBox ID="txt_fnameU" runat="server" Text='<%#Bind("fname") %>' />
                            <%--VALIDATION--%>
                            <asp:RequiredFieldValidator ID="rfv_fnameU" runat="server" ControlToValidate="txt_fnameU" ErrorMessage="*Required<br />" Display="Dynamic" ForeColor="Red" ValidationGroup="updPatient" />

                            <h3>Last Name: </h3>
                            <asp:TextBox ID="txt_lnameU" runat="server" Text='<%#Bind("lname") %>' />
                            <%--VALIDATION--%>
                            <asp:RequiredFieldValidator ID="rfv_lnameU" runat="server" ControlToValidate="txt_lnameU" ErrorMessage="*Required<br />" Display="Dynamic" ForeColor="Red" ValidationGroup="updPatient" />

                            <h3>Patient Number: </h3>
                            <asp:TextBox ID="txt_pat_numU" runat="server" Text='<%#Bind("pat_num") %>' />
                            <%--VALIDATION--%>
                            <asp:RequiredFieldValidator ID="rfv_pat_numU" runat="server" ControlToValidate="txt_pat_numU" ErrorMessage="*Required<br />" Display="Dynamic" ForeColor="Red" ValidationGroup="updPatient" />
                            <asp:RegularExpressionValidator ID="rev_pat_numU" runat="server" ControlToValidate="txt_pat_numU" ValidationExpression="^\d{4}$" ErrorMessage="Enter 4 digit patient number. No spaces or dashes.<br />" Display="Dynamic" ForeColor="Red" ValidationGroup="updPatient" />

                            <h3>Health Card Num: </h3>
                            <asp:TextBox ID="txt_hcardU" runat="server" Text='<%#Bind("hcard") %>' />
                            <%--VALIDATION--%>
                            <asp:RequiredFieldValidator ID="rfv_hcardU" runat="server" ControlToValidate="txt_hcardU" ErrorMessage="*Required<br />" Display="Dynamic" ForeColor="Red" ValidationGroup="updPatient" />
                            <asp:RegularExpressionValidator ID="rev_hcardU" runat="server" ControlToValidate="txt_hcardU" ValidationExpression="^\d{3}$" ErrorMessage="Enter only the last 3 digits of the patients health card.<br />" Display="Dynamic" ForeColor="Red" ValidationGroup="updPatient" />

                            <h3>Triage Level: </h3>
                            <asp:DropDownList ID="ddl_triageU" runat="server" DataValueField='<%#Bind("triage_id") %>'>
                                <asp:ListItem Value="1" Text="Triage Level 1" />
                                <asp:ListItem Value="2" Text="Triage Level 2" />
                                <asp:ListItem Value="3" Text="Triage Level 3" />
                                <asp:ListItem Value="4" Text="Triage Level 4" />
                                <asp:ListItem Value="5" Text="Triage Level 5" />
                            </asp:DropDownList>

                            <asp:Button id="btn_updateU" runat="server" Text="Update" CommandName="Upd" CausesValidation="true" ValidationGroup="updPatient" />
                            <asp:Button ID="btn_cancelU" runat="server" Text="Cancel" CommandName="Can" />
                        </EditItemTemplate>            
                    </asp:FormView> 
        </asp:Panel> 

        <%--MESSAGE MODAL PANEL--%>
        <AJAX:ModalPopupExtender ID="mpe_message" runat="server" TargetControlID="btn_show_popup" PopupControlID="pnl_message" BackgroundCssClass="modal_bg" OkControlID="btn_ok" />
        <asp:Panel ID="pnl_message" runat="server" CssClass="modal_pnl">
            <asp:Label ID="lbl_message" runat="server" />
            <asp:Button ID="btn_ok" runat="server" Text="OK" />
        </asp:Panel>
        
        <asp:Timer ID="tmr_chk_in" runat="server" Interval="1000" OnTick="subChkIn" /> 
    </div> <%--/patient_admin--%>

    <%--MODAL POP-UP HIDDEN BUTTON--%>
    <asp:Button ID="btn_show_popup" runat="server" style="display:none;" />
    </div> <%--/sb--%>
</asp:Content>

