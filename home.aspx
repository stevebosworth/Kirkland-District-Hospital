<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="_Default" Theme="Theme1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_head" Runat="Server">
    <link rel="stylesheet" type="text/css" href="App_Themes/Theme1/engine1/style.css" />
	<script type="text/javascript" src="App_Themes/Theme1/engine1/jquery.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_content" Runat="Server">
            <AJAX:ToolkitScriptManager ID="tsm_home" runat="server" />
            <div id="slider">
            <div id="wowslider-container1">
	            <div class="ws_images"><ul>
                    <li><img src="App_Themes/Theme1/data1/images/ourteam.jpg" alt="Newsletter" title="Newsletter" id="wows1_0"/></li>
                    </ul></div>
                   <div class="ws_thumbs">
                    <div>
                        <a href="~/ne-news-ml-V1.aspx" title="News"><img src="App_Themes/Theme1/data1/tooltips/ourteam.jpg" alt="" /></a>
                        <a href="~/eventsCalendar_sk.aspx" title="Events"><img src="App_Themes/Theme1/data1/tooltips/intensive_care_unit.jpg" alt="" /></a>
                        <a href="~/donation_sk.aspx" title="Donate Today"><img src="App_Themes/Theme1/data1/tooltips/stateoftheartinfrastructure.jpg" alt="" /></a>
                        <a href="~/appVolunteer_ml_V1.aspx" title="Volunteer Opportunities"><img src="App_Themes/Theme1/data1/tooltips/orthodentalservices.jpg" alt="" /></a>
                        <a href="~/careers_bp.aspx" title="Careers and Jobs"><img src="App_Themes/Theme1/data1/tooltips/gynaecology.jpg" alt="" /></a>
                    </div>
                </div>            
	            <div class="ws_shadow"></div>
	            </div>
	            <script type="text/javascript" src="App_Themes/Theme1/engine1/wowslider.js"></script>
	            <script type="text/javascript" src="App_Themes/Theme1/engine1/script.js"></script>
	            <!-- End WOWSlider.com BODY section -->   
            </div>
            <div class="article"> 
                <img src="images/icons/light_icon.png" alt="light" />
                <h1>Your Current ER Wait Time</h1>
                <div id="wait_time">
                    <p>If you require immeadiate medical assistance please visit us or call 911.</p>  
                    <h2>Current Average Wait</h2>
                    <asp:UpdatePanel ID="udp_wait_time" runat="server">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="tmr_wait" EventName="Tick" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:Label ID="lbl_wt_time" runat="server" style="color: #235c9d; font-family: 'pt sans', Sans-Serif; font-size: 25px;" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Timer ID="tmr_wait" runat="server" Interval="60000" OnTick="calcAvgWait" /> 
                    <p>HH:MM:SS</p>
                </div>
            </div>
            <div class="article">                
                <img src="images/icons/scope_icon.png" alt="scope" />
                <h1>Visitor Information</h1>
                <p>Need to Find a friend? Find your way around the hospital? Send a card to a friend?  We'll even help you park your car. Take a look at the top menu under "Patients and Visitors" for more info. </p>
            </div>
            <div class="article">     
                <img src="images/icons/compass_icon.png" alt="compass icon" />
                <h1>Where are We Located</h1>
                <p>Need a hand finding us?  Need to book an appointment or reach us for any reason? We're here to help and you can <a href="contact.aspx">contact us here</a>.  We look forward to hearing from you.   </p>
            </div>
            <div id="container_recruiting">
                <div id="recruit">
                    <h1>Recruiting</h1>
                    <img src="images/icons/briefcase_icon.png" alt="briefcase icon" />
                </div>
                <div id="career">
                    <h1>Interested in a career in healthcare that challenges and rewards you?</h1>
                    <p>Are you looking for an exciting career in health care?  Join our tight knit team of health care professionals today!  We're always on the hunt for passionate health care workrs.  Please contact us or send us your resume to apply today.  Join us in beautiful Kirkland for the opportunity of a lifetime.  Not only will you have the chance to work with our great team, you'll get to experience the best the north has to offer and the tranquility of small town life.</p>
                    <a href="#">Careers</a><a href="#">Physicians</a><a href="#">Nurses</a><a href="#">Doctors</a>
                </div>
            </div>

</asp:Content>

