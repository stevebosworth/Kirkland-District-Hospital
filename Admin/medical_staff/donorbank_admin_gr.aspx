<%@ Page Title="" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="donorbank_admin_gr.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_content" Runat="Server">
    
    <%--On this page the admin can select all the donors according to their blood group.
        
         i have used checkboxes in conjunction to the datalist to send an email to multiple recepients--%>
    
    <h1>Send Email To Donors</h1>
    <br />
    <asp:Label ID="lbl_bgroup" runat="server" Text="Please Select A Blood Group"/>
    
    <%--on change of index of dropdown list, the blood group is passed to getdonorsbybgroup 
    method which pulls all the donors registered with the same blood group--%>
    
    <asp:DropDownList ID="ddl_bgroup" runat="server" AutoPostBack="true" OnSelectedIndexChanged="bgroupSelect" >
        <asp:ListItem value="">Select</asp:ListItem>
        <asp:ListItem Value="O+">O+</asp:ListItem>
        <asp:ListItem Value="O-">O-</asp:ListItem>
        <asp:ListItem Value="AB+">AB+</asp:ListItem>
        <asp:ListItem Value="AB-">AB-</asp:ListItem>
        <asp:ListItem Value="A+">A+</asp:ListItem>
        <asp:ListItem Value="A">A-</asp:ListItem>
        <asp:ListItem Value="B+">B+</asp:ListItem>
        <asp:ListItem Value="B-">B-</asp:ListItem>                    
    </asp:DropDownList>

    <asp:Datalist ID="dtl_all" runat="server" CellPadding="4" ForeColor="#333333" OnItemCommand="DataList1_ItemCommand">
        <AlternatingItemStyle BackColor="White" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderTemplate>
             <asp:Table ID="Table1" runat="server" CellPadding="10" CellSpacing="10">
                <asp:TableRow>
                    <asp:TableHeaderCell>Name</asp:TableHeaderCell>                    
                    <asp:TableHeaderCell>Blood Group</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Phone</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Address</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Postal</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Select</asp:TableHeaderCell>
                </asp:TableRow>
             </asp:Table>
        </HeaderTemplate>
        <ItemStyle BackColor="#EFF3FB" />
        <ItemTemplate>
            <asp:Table ID="Table1" runat="server" CellPadding="10" CellSpacing="10" >
                <asp:TableRow>
                    <asp:TableCell><%#Eval("fname")%></asp:TableCell>                    
                    <asp:TableCell><%#Eval("bgroup")%></asp:TableCell>
                    <asp:TableCell><%#Eval("phone")%></asp:TableCell>
                    <asp:TableCell><%#Eval("address")%></asp:TableCell>
                    <asp:TableCell><%#Eval("pcode")%></asp:TableCell>
                    <%--The text field of the checkboxes is passed to the function to send email--%>
                    <asp:TableCell><asp:CheckBox runat="server" ID="ckb_email" Text='<%#Eval("email")%>' /></asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ItemTemplate>
        <FooterTemplate>
            <asp:Button ID="btn_send" runat="server" Text="Send Email"/>
        </FooterTemplate>
        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    </asp:Datalist>
    
    <asp:Label ID="lbl_message" runat="server" />
</asp:Content>

