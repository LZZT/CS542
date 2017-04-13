<%--
  Created by IntelliJ IDEA.
  User: yenchanghsieh
  Date: 3/8/17
  Time: 7:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Title</title>

    <link href="tooplate_style.css" rel="stylesheet" type="text/css" />

    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
    <script src="https://code.jquery.com/ui/3.2.1/jquery-ui.js"></script>

    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

    <script>
        $(document).ready(function() {
            $("input[name$='manager']").click(function() {
                var test = $(this).val();

                $("div.desc").hide();
                if(test === "insert")
                    $("#insert").show();
                else if(test === "search")
                    $("#search").show();
            });
        });
    </script>

    <script>
        $(function() {
            $('#departTime').timepicker({
                timeFormat: 'HH:mm:ss',
                interval: 15,
                startTime: '00:00:00',
                dynamic: false,
                dropdown: true,
                scrollbar: true
            });

            $('#arriTime').timepicker({
                timeFormat: 'HH:mm:ss',
                interval: 15,
                startTime: '00:00:00',
                dynamic: false,
                dropdown: true,
                scrollbar: true
            });
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#submit').click(function() {
                checked = $("input[type=checkbox]:checked").length;

                if(!checked) {
                    alert("You must fill all fields in this form.");
                    return false;
                }

                var selectDepart = document.getElementById("departAirport");
                var departAirport = selectDepart.options[selectDepart.selectedIndex].value;
                var selectArrival = document.getElementById("arriAirport");
                var arrivalAirport = selectArrival.options[selectArrival.selectedIndex].value;
                if(departAirport == arrivalAirport) {
                    alert("Departure airport cannot be same with Arrived airport!");
                    return false;
                }
            });
        });
    </script>

</head>

<body>
<br><br>

<%
    if (null == session.getAttribute("username") || !((String)session.getAttribute("username")).equals("root")) {
        response.sendRedirect("login.jsp");
    }
%>

<div id="tooplate_wrapper">
    <div id="tooplate_menu">
        <ul>
            <li><a href="index.jsp" class="current" style="font-size: large">Home</a></li>
            <li><a href="reloadDB.action" style="font-size: large">Manager</a></li>
            <li><a href="about.html" style="font-size: large">About Us</a></li>
            <li><a href="contact.html" style="font-size: large">Contact</a></li>
            <li>

                <%
                    if (null == session.getAttribute("username")) {
                %>
                <input type="button" value="Login" onclick="location.href='login.jsp';">
                <input type="button" value="Register" onclick="location.href='register.jsp';">

                <% } else {
                %>
                <form action="logout.action" method="post">
                    <h4>Hi! ${sessionScope.username}</h4>
                    <input type="submit" value="Logout"/>
                    <input type="button" value="My trip" onclick="location.href='mytrip.jsp' ;">
                </form>
                <% }%>
            </li>

        </ul>
    </div> <!-- end of tooplate_menu -->

    <div id="tooplate_header">
        <h1>Manager Mode</h1>
    </div>

    <!-- -->
    <div id="tooplate_wrapper">
        <s:actionerror cssStyle="color:red"/>

        <div id="managerOp">

            <h4>You must fill all fields in this form.</h4>

            <input type="radio" name="manager" value="insert" checked/>Insert Flight
            <input type="radio" name="manager" value="search"  />Search Flight


            <div id="insert" class="desc">

                <form action="insertFlight.action" method="post">

                    Flight Number: <input type="text" name="flightNumber" required><br>

                    Departure Time: <input type="text" name="departTime" id="departTime" required><br>

                    Arrival Time: <input type="text" name="arriTime" id="arriTime" required><br>

                    Days Operated:  <input type="checkbox" name="daysOperated" value="Mon">Mon
                                    <input type="checkbox" name="daysOperated" value="Tue">Tue
                                    <input type="checkbox" name="daysOperated" value="Wed">Wed
                                    <input type="checkbox" name="daysOperated" value="Thu">Thu
                                    <input type="checkbox" name="daysOperated" value="Fri">Fri
                                    <input type="checkbox" name="daysOperated" value="Sat">Sat
                                    <input type="checkbox" name="daysOperated" value="Sun">Sun<br>

                    <s:select label="Departure Airports"
                              headerKey="-1" headerValue="Select Departure Airport"
                              list="#session.managerAirports"
                              name="departAirport" /> <br>

                    <s:select label="Arrival Airports"
                              headerKey="-1" headerValue="Select Arrival Airport"
                              list="#session.managerAirports"
                              name="arriAirport" /> <br>

                    <s:select label="Airline"
                              headerKey="-1" headerValue="Select Airline"
                              list="#session.managerAirlines"
                              name="airline" /> <br>

                    <s:select label="Aircraft Model"
                              headerKey="-1" headerValue="Select Aircraft Model"
                              list="#session.managerAircraft"
                              name="aircraftModel" /> <br>

                    Price: <input type="text" name="price" required><br>

                    <input type="submit" value="submit" id="submit">
                </form>
            </div>

            <div id ="search" class="desc" hidden>
                <form action="searchFlightByFlightNumber.action" method="post">
                    Flight Number: <input type="text" name="flightNumber"><br>

                    <input type="submit" value="submit">
                </form>
            </div>
        </div>
    </div>
</div>
    <div id="tooplate_footer_wrapper">
        <div id="tooplate_footer">
            Copyright © 2017 <a href="#">CS 542 Team 2</a>
        </div>
    </div>

</body>
</html>
