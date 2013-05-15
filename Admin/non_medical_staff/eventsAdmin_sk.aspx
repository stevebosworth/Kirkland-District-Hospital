<%@ Page Title="" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="eventsAdmin_sk.aspx.cs" Inherits="Admin_eventsAdmin_sk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_content" Runat="Server">

<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />  
        <script src="http://code.jquery.com/jquery-1.8.2.js" type="text/javascript"></script>   
         <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js" type="text/javascript"></script>  
    <link rel="stylesheet" href="/resources/demos/style.css" />
   
   <%--calendar--%>
     <script type="text/javascript">
         window.onload = function () {
             GridViewColor("<%=GridViewResult.ClientID%>", "#f6e0f8", "#abc7ce", "#00d7f8", "#fd6");
         }
         function GridViewColor(GridViewId, NormalColor, AlterColor, HoverColor, SelectColor) {

             if (document.getElementById("MainContent_GridViewResult") == null) {
                 return;
             }
             var AllRows = document.getElementById("MainContent_GridViewResult").getElementsByTagName("tr");
             for (var i = 1; i < AllRows.length; i++) {
                 AllRows[i].style.background = i % 2 == 0 ? NormalColor : AlterColor;
                 if (HoverColor != "") {
                     AllRows[i].onmouseover = function () { if (!this.selected) this.style.background = HoverColor; }
                     if (i % 2 == 0) {
                         AllRows[i].onmouseout = function () { if (!this.selected) this.style.background = NormalColor; }
                     }
                     else {
                         AllRows[i].onmouseout = function () { if (!this.selected) this.style.background = AlterColor; }
                     }
                 }
                 if (SelectColor != "") {
                     AllRows[i].onclick = function () {
                         this.style.background = this.style.background == SelectColor ? HoverColor : SelectColor;
                         this.selected = !this.selected;
                     }
                 }
             }
         }
    </script>


    <script type="text/javascript">

        $(function () { $("#datepicker").datepicker({ minDate: 0, maxDate: "+6M" }); });      
       
     </script>

    <%-- label to display message that event is added--%>
    <asp:Label ID="lblStatus" runat="server" Text="" />

<h2>
    <asp:Label ID="lblEvent" runat="server" Font-Bold="true" Text="Add New Event" />
</h2>
<br />
<br />

<table>
  <%--event name with validations--%>
    <tr>
    <td><asp:Label ID="lblEventName" runat="server" Font-Bold="true" Text="Event Name" /></td>
    <td><asp:TextBox ID="txtEventName" runat="server" /></td>
    <td><asp:RequiredFieldValidator ID="rfv_eventName" runat ="server" ControlToValidate="txtEventName" Text="*Required" Display="Dynamic" SetFocusOnError="true" ValidationGroup="grp_add" /></td>
    </tr>

  <%--event type with validations--%>
    <tr>
    <td><asp:Label ID="lblEventType" runat="server" Font-Bold="true" Text="Event Type" /></td>
    <td><asp:DropDownList ID="ddlEventType" runat="server" /></td>
    <td><asp:RequiredFieldValidator ID="rfv_eventType" runat ="server" ControlToValidate="ddlEventType" InitialValue ="--Select--" Text="Select Event Type" Display="Dynamic" SetFocusOnError ="true" ValidationGroup="grp_add" /></td>
    </tr>
   
   <%--event organizer with validations--%> 
    <tr>
    <td><asp:Label ID="lblOrganizers" runat="server" Font-Bold="true" Text="Organizers" /></td>
    <td><asp:TextBox ID="txtOrganizers" runat="server" /></td>
    <td><asp:RequiredFieldValidator ID="rfv_organizers" runat ="server" ControlToValidate="txtOrganizers" Text="*Required" Display="Dynamic" SetFocusOnError="true" ValidationGroup="grp_add" /></td>
    <td><asp:RegularExpressionValidator ID="rev_organizers" runat ="server" Text ="Organizers should not contain numbers" ControlToValidate="txtOrganizers" Display="Dynamic" SetFocusOnError="true" ValidationExpression="[a-zA-Z ]{1,40}$" ValidationGroup="grp_add" /></td>
    </tr>

   <%--date of event with validations--%>
    <tr>
    <td><asp:Label ID="lblDate" runat="server" Font-Bold="true" Text="Date" /></td>
    <td><input type="text" id="datepicker" name="txtDate" value="<%= currDate %>" class="textBox"/></td>
    <%--<td><asp:RequiredFieldValidator ID="rfv_datepicker" runat ="server" Text ="*Required" ControlToValidate="" Display="Dynamic" SetFocusOnError ="true" /></td>--%>
    </tr>

   <%--event venue with validations--%>
    <tr>
    <td><asp:Label ID="lblVenue" runat="server" Font-Bold="true" Text="Venue" /></td>
    <td><asp:TextBox ID="txtVenue" runat="server" /></td>
    <td><asp:RequiredFieldValidator ID="rfv_venue" runat ="server" ControlToValidate="txtVenue" Text="*Required" Display="Dynamic" SetFocusOnError="true" ValidationGroup="grp_add" /></td>
    </tr>

    <%--event timings with validations--%>
    <tr>
    <td><asp:Label ID="lblTimings" runat="server" Font-Bold="true" Text="Timings" /></td>
    <td><asp:TextBox ID="txtTimings" runat="server" /></td>
    <td><asp:RequiredFieldValidator ID="rfv_timings" runat ="server" ControlToValidate="txtTimings" Text="*Required" Display="Dynamic" SetFocusOnError="true" ValidationGroup="grp_add" /></td>
    <td><asp:RegularExpressionValidator ID="rev_timings" runat ="server" ControlToValidate ="txtTimings" Text ="Time should be in the correct format" Display="Dynamic" SetFocusOnError ="true" ValidationExpression="^(20|21|22|23|[01]\d|\d)(([:][0-5]\d){1,2})$" ValidationGroup="grp_add" /></td>
    </tr>

    <%--event guests with validations--%>
    <tr>
    <td><asp:Label ID="lblGuest" runat="server" Font-Bold="true" Text="Guest" /></td>
    <td><asp:TextBox ID="txtGuest" runat="server" /></td>
    <td><asp:RequiredFieldValidator ID="rfv_guest" runat ="server" ControlToValidate="txtGuest" Text="*Required" Display="Dynamic" SetFocusOnError="true" ValidationGroup="grp_add" /></td>
    <td><asp:RegularExpressionValidator ID="rev_guest" runat ="server" Text ="Guest Name should contain only alphabets" ControlToValidate="txtGuest" Display="Dynamic" SetFocusOnError="true" ValidationExpression="[a-zA-Z ]{1,40}$" ValidationGroup="grp_add" /></td>
    </tr>

</table>
        <br />
    <%--Add button--%>
    <asp:Button ID="btnAdd" runat="server" Text="ADD" onclick="btnAdd_Click" ValidationGroup="grp_add" />

    <%--Update button--%>
    <asp:Button ID="btnUpdate" runat="server" Text="Update" Visible="false" onclick="btnUpdate_Click" ValidationGroup="grp_add" /> &nbsp;&nbsp;
    
    <%--Cancel button--%>
    <asp:Button ID="btnCancel" runat="server" Text="Cancel" Visible="false" onclick="btnCancel_Click" />


<br /><br /><br /><br /><br />

<%--grid view to display all the events--%>
    <asp:GridView ID="GridViewResult" runat="server" DataKeyNames="Id" width="500px"
     onrowdeleting="GridViewResult_RowDeleting" 
     CssClass="GridView" AutoGenerateDeleteButton="True" AutoGenerateEditButton="True"       
        onselectedindexchanged="GridViewResult_SelectedIndexChanged" 
        onrowediting="GridViewResult_RowEditing" >
    </asp:GridView>


</asp:Content>

