﻿<%@ Page Title="" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="newsletterAdmin_sk.aspx.cs" Inherits="Admin_non_medical_staff_newsletterAdmin_sk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_content" Runat="Server">

<h2> ADD NEWS</h2>

 

     <asp:Label ID="lblShow" runat="server" Font-Bold="True" ForeColor="#6600CC" />

       <br />
  <br />
  <%--news title with validations--%>
    <asp:Label ID="lblTitle" runat="server" Font-Bold="true" Text="Title" />
    <asp:TextBox ID="txtTitle" runat="server" />
    <asp:RequiredFieldValidator ID="rfv_title" runat ="server" Text ="*Required" ControlToValidate="txtTitle" Display="Dynamic" SetFocusOnError="true" ValidationGroup="grp_addnews" />
    <br /><br />

    <%--news desciption with validations--%>
    <asp:Label ID="lblDescription" runat="server" Font-Bold="true" Text="Description" /><br />
    <asp:TextBox ID="txtDescription" TextMode="MultiLine" runat="server" Height="126px" Width="215px" />
    <asp:RequiredFieldValidator ID="rfv_desc" runat ="server" Text ="*Required" ControlToValidate="txtDescription" Display ="Dynamic" SetFocusOnError="true" ValidationGroup="grp_addnews" />
    <br /><br />  
     
     <%--Add button--%>    
    <asp:Button ID="btnAdd" runat="server" Text="ADD" onclick="btnAdd_Click" ValidationGroup="grp_addnews" />

    <%--Update button--%>
      <asp:Button ID="btnUpdate" runat="server" Text="Update" Visible="false" 
        onclick="btnUpdate_Click" ValidationGroup="grp_addnews" /> &nbsp;&nbsp;

    <%--Cancel button--%>
    <asp:Button ID="btnCancel" runat="server" Text="Cancel" Visible="false" 
        onclick="btnCancel_Click" />



    <br />
    <br />

    <%--grid view to display all the news--%>
    <asp:GridView ID="GridViewResult" DataKeyNames="Id" 
     
      AutoGenerateDeleteButton="True" onrowdeleting="GridViewResult_RowDeleting" 
     onselectedindexchanged="GridViewResult_SelectedIndexChanged" 
     AutoGenerateEditButton="True"
     onrowediting="GridViewResult_RowEditing"
     runat="server">
    </asp:GridView>


</asp:Content>

