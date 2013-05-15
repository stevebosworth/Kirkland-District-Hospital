<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="page_sb.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_content" Runat="Server">
    <div class="sb">
        <div id="page">
        <asp:Repeater ID="rpt_page" runat="server">
            <ItemTemplate>
                <div id="page_header">
                    <h1><asp:Label ID="lbl_title" runat="server" Text='<%#Eval("title") %>' /></h1>
                    <h4><asp:Label ID="lbl_author" runat="server" Text='<%#Eval("author") %>' /></h4>
                </div>
                <div id="page_content">
                    <asp:Label ID="lbl_content" runat="server" Text='<%#Eval("entry") %>' />
                </div>
            </ItemTemplate>
        </asp:Repeater>   
        </div>
    </div>
</asp:Content>

